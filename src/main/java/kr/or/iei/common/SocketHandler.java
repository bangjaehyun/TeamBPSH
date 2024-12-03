package kr.or.iei.common;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.or.iei.common.emitter.Emitter;
import kr.or.iei.common.exception.CommonException;
import kr.or.iei.emp.model.service.EmpService;
import kr.or.iei.emp.model.vo.Chat;


@Component("socketHandler")
public class SocketHandler extends TextWebSocketHandler{
	
	@Autowired
	@Qualifier("empService")
	private EmpService service;
	
	@Autowired
	@Qualifier("messageSource")
	private MessageSource exMessage;
	
	private ArrayList<WebSocketSession> emps;
	public static HashMap<String, WebSocketSession> map;
	private HashMap<String, String> empGroup;
	
	public SocketHandler() {
		emps = new ArrayList<WebSocketSession>();
		map = new HashMap<String, WebSocketSession>();
		empGroup = new HashMap<String, String>();
	}
	
	//소켓이 생성되어 연결되었을 때 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		emps.add(session); //신규 접속자 정보 저장
	}
	
	
	//메세지를 송신 시 동작하는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			String nullEx = "";
		try {
			//수신 받은 메시지 형식 == Json 형식 => 파싱 처리
			JsonElement element = JsonParser.parseString(message.getPayload());
			JsonObject jsonObj = element.getAsJsonObject();
			String type= jsonObj.get("type").getAsString();
			
			if(type.equals("connect")) {
				//최초 연결 시, 연결 정보 등록
				String empCode = jsonObj.get("empCode").getAsString();
				map.put(empCode, session);
				
			}else if(type.equals("chat")) {
				nullEx = jsonObj.get("empCode").getAsString();
				
				//메시지 송신
				String groupNo   = jsonObj.get("groupNo").getAsString();
				String toEmpCode   = jsonObj.get("toEmp").getAsString();
				String empCode = jsonObj.get("empCode").getAsString();
				String empName = jsonObj.get("empName").getAsString();
				String msg      = jsonObj.get("msg").getAsString();
				String fileName = jsonObj.get("chatFileName") != null ? jsonObj.get("chatFileName").getAsString() : null;
				String filePath = jsonObj.get("chatFilePath") != null ? jsonObj.get("chatFilePath").getAsString() : null;
				
				Chat chat = new Chat();
				chat.setGroupNo(groupNo);
				chat.setEmpCode(empCode);
				chat.setEmpName(empName);
				chat.setChatMsg(msg);
				chat.setChatMsgGb(filePath != null ? "1" : "0");
				chat.setChatFileName(fileName);
				chat.setChatFilePath(filePath);
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date date = new Date();
				chat.setChatDate(sdf.format(date));
				
				//DB 등록
				int result = service.insertChat(chat);
				
				if(result > 0) {
					this.sendMsg(chat, empCode ,toEmpCode);				
				}
			}else if(type.equals("group")) {
				String empCode = jsonObj.get("empCode").getAsString();
				String groupCode = jsonObj.get("groupNo").getAsString();
				empGroup.put(empCode, groupCode);
			}
		}catch(NullPointerException e) {
			System.out.println("11111111111111");
			System.out.println(nullEx);
			WebSocketSession fromWs = map.get(nullEx);
			JsonObject json = new JsonObject();
			json.addProperty("type", "null");
			if(fromWs != null) {				
				try {
					System.out.println("2222222222");
					fromWs.sendMessage(new TextMessage(new Gson().toJson(json)));
				} catch (IOException ex) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
	
		
	}
	
	//연결된 사용자들에게 메세지 전송
	public void sendMsg(Chat chat, String fromEmpCode, String toEmpCode) {
			WebSocketSession fromWs = map.get(fromEmpCode);
			JsonObject json = new JsonObject();
			json.addProperty("type", "chat");
			json.addProperty("data",  new Gson().toJson(chat));
			if(fromWs != null) {				
				try {
					fromWs.sendMessage(new TextMessage(new Gson().toJson(json)));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			//사원이 접속 하지 않았거나 같은 그룹에 있지 않은 경우
			if(empGroup.get(toEmpCode) == null || !empGroup.get(toEmpCode).equals(empGroup.get(fromEmpCode))) {
				WebSocketSession toWs = map.get(toEmpCode);
				try {
					//채팅방에는 들어와있으므로 count를 증가시켜 준다 socket 유무에따라 db에만 넣을지 소켓으로 전달하여 실시간으로 카운트 증가
					if(toWs != null) {
							JsonObject jobject = new JsonObject();
							jobject.addProperty("type", "readCount");
							jobject.addProperty("empCode",  fromEmpCode);
							jobject.addProperty("groupNo",  empGroup.get(fromEmpCode));
							jobject.addProperty("socket",  true);
							toWs.sendMessage(new TextMessage(new Gson().toJson(jobject)));
					}else {
							//채팅방에 들어와 있지 않을경우에는 DB에만 저장
							JsonObject jobject = new JsonObject();
							jobject.addProperty("type", "readCount");
							jobject.addProperty("empCode",  fromEmpCode); //사원 번호
							jobject.addProperty("groupNo",  empGroup.get(fromEmpCode)); //그룹 번호
							fromWs.sendMessage(new TextMessage(new Gson().toJson(jobject)));
					}
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else {
				//사원에게 메시지 전달
				fromWs = map.get(toEmpCode);
				if(fromWs != null) {				
					try {
						fromWs.sendMessage(new TextMessage(new Gson().toJson(json)));
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		
	}
	
	//연결 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		 for (String key : map.keySet()) {
	            if (map.get(key) == session) {
	                empGroup.remove(key);
	                map.get(key).close();
	            }
	      }		
		emps.remove(session);
	}
}
