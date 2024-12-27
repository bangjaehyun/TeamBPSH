package kr.or.iei.common;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.or.iei.emp.model.service.EmpService;
import kr.or.iei.emp.model.vo.Chat;


@Component("socketHandler")
public class SocketHandler extends TextWebSocketHandler{
	
	@Autowired
	@Qualifier("empService")
	private EmpService service;
	
	private ArrayList<WebSocketSession> emps;
	public static HashMap<String, WebSocketSession> map;
	
	public SocketHandler() {
		emps = new ArrayList<WebSocketSession>();
		map = new HashMap<String, WebSocketSession>();
	}
	
	//소켓이 생성되어 연결되었을 때 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("연결 성공");
		emps.add(session); //신규 접속자 정보 저장
	}
	
	
	//메세지를 송신 시 동작하는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		//수신 받은 메시지 형식 == Json 형식 => 파싱 처리
		JsonElement element = JsonParser.parseString(message.getPayload());
		JsonObject jsonObj = element.getAsJsonObject();
		String type= jsonObj.get("type").getAsString();
		
		if(type.equals("connect")) {
			//최초 연결 시, 연결 정보 등록
			String empCode = jsonObj.get("empCode").getAsString();
			map.put(empCode, session);
			
		}else if(type.equals("chat")) {
			//메시지 송신
			String groupNo   = jsonObj.get("groupNo").getAsString();
			String toEmpCode   = jsonObj.get("toEmp").getAsString();
			String empCode = jsonObj.get("empCode").getAsString();
			String empName = jsonObj.get("empName").getAsString();
			String msg      = jsonObj.get("msg").getAsString();
			String fileName = jsonObj.get("fileName") != null ? jsonObj.get("fileName").getAsString() : null;
			String filePath = jsonObj.get("filePath") != null ? jsonObj.get("filePath").getAsString() : null;
			
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
		}
	
		
	}
	
	//연결된 사용자들에게 메세지 전송
	public void sendMsg(Chat chat, String fromEmpCode, String toEmpCode) {
			WebSocketSession ws = map.get(fromEmpCode);
			
			JsonObject json = new JsonObject();
			json.addProperty("type", "chat");
			json.addProperty("data",  new Gson().toJson(chat));
			
			if(ws != null) {				
				try {
					ws.sendMessage(new TextMessage(new Gson().toJson(json)));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			ws = map.get(toEmpCode);
			if(ws != null) {				
				try {
					ws.sendMessage(new TextMessage(new Gson().toJson(json)));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		
	}
	
	//연결 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("연결 종료");
		emps.remove(session);
	}
}
