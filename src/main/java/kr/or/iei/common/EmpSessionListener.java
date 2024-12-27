package kr.or.iei.common;

import java.io.IOException;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * Application Lifecycle Listener implementation class EmpSessionListener
 *
 */
@WebListener
public class EmpSessionListener implements HttpSessionBindingListener {

	// 싱글톤 객체를 담을 변수
	private static EmpSessionListener sessionListener = null;
	// 로그인한 접속자를 저장한 HashTable (데이터를 해시하여 테이블 내의 주소를 계산하고 데이터를 담는 것 , 해시함수 알고리즘은 나눗셈
	// 법. 자릿수 접기 등등)
	private static Hashtable<HttpSession, String> loginEmps = new Hashtable<HttpSession, String>();

	public static synchronized EmpSessionListener getInstance() {
		if (sessionListener == null) {
			sessionListener = new EmpSessionListener();
		}
		return sessionListener;
	}

	/**
	 * @see HttpSessionBindingListener#valueBound(HttpSessionBindingEvent)
	 */
	public void valueBound(HttpSessionBindingEvent event) {
		loginEmps.put(event.getSession(), event.getName());
		System.out.println(event.getName() + " 로그인 완료");
		System.out.println("현재 접속자 수 : " + getEmpCount());
		
		loginEmpChatChange(event.getName());
	}

	/**
	 * @see HttpSessionBindingListener#valueUnbound(HttpSessionBindingEvent)
	 */
	public void valueUnbound(HttpSessionBindingEvent event) {
		logoutEmpChatChange(event.getName());
		
		loginEmps.remove(event.getSession());
		System.out.println(event.getName() + " 로그아웃 완료");
		System.out.println("현재 접속자 수 : " + getEmpCount());
		
	}

	// 입력받은 아이디를 해시테이블에서 삭제
	public void removeSession(String empCode) {
		Enumeration<HttpSession> e = loginEmps.keys();
		HttpSession session = null;
		while (e.hasMoreElements()) {
			session = (HttpSession) e.nextElement();
			if (loginEmps.get(session).equals(empCode)) {
				// 세션이 invalidate될때 HttpSessionBindingListener를              
				// 구현하는 클레스의 valueUnbound()함수가 호출된다.                
				session.invalidate();
			}
		}
	}

	public boolean isUsing(String empCode) {
		return loginEmps.containsValue(empCode);
	}
	
	public void setSession(HttpSession session, String empCode){
		//이순간에 Session Binding이벤트가 일어나는 시점       
		//name값으로 userId, value값으로 자기자신(HttpSessionBindingListener를 구현하는 Object)       
		session.setAttribute(empCode, this);//login에 자기자신을 집어넣는다.   
	}
	
	public String getEmpCode(HttpSession session){
		return (String)loginEmps.get(session); 
	}

	public int getEmpCount() {
		return loginEmps.size();
	}
	
	public void printloginUsers(){ 
		Enumeration<HttpSession> e = loginEmps.keys(); 
		HttpSession session = null; 
		System.out.println("==========================================="); 
		int i = 0; 
		while(e.hasMoreElements()){ 
			session = (HttpSession)e.nextElement(); 
			System.out.println((++i) + ". 접속자 : " + loginEmps.get(session));
			}
		System.out.println("===========================================");
	}
	
	public Collection<String> getEmps(){
		Collection<String> collection = loginEmps.values();
		return collection; 
	}
	
	
	private void loginEmpChatChange(String loginEmpCode) {
		Collection<String> loginEmps = getEmps();
		
		for(String empCode : loginEmps) {
			WebSocketSession ws = SocketHandler.map.get(empCode);
			
			JsonObject json = new JsonObject();
			json.addProperty("type", "login");
			json.addProperty("empCode", loginEmpCode);
			
			if(ws != null) {				
				try {
					ws.sendMessage(new TextMessage(new Gson().toJson(json)));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
	private void logoutEmpChatChange(String logoutEmpCode) {
		Collection<String> loginEmps = getEmps();
		
		for(String empCode : loginEmps) {
			WebSocketSession ws = SocketHandler.map.get(empCode);
			
			JsonObject json = new JsonObject();
			json.addProperty("type", "logout");
			json.addProperty("empCode", logoutEmpCode);
			
			if(ws != null) {				
				try {
					ws.sendMessage(new TextMessage(new Gson().toJson(json)));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	

}
