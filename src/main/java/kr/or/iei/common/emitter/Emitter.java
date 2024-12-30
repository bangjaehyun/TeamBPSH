package kr.or.iei.common.emitter;

import java.io.IOException;
import java.util.HashMap;

import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Controller("emitter")
public class Emitter {
	
	private HashMap<String,SseEmitter> emps;
	public Emitter() {
		emps = new HashMap<String, SseEmitter>();
	}
	
	 // UTF-8 데이터만 보낼 수 있음, 바이너리 데이터 지원 x 
    @GetMapping(path = "/emitter", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter subscribe(String empCode){
        //SseEmitter는 서버에서 클라이언트로 이벤트를 전달할 수 있습니다.
        SseEmitter emitter = connect(empCode);
        
        return emitter;
    }
    
    public SseEmitter connect(String empCode) {
        SseEmitter sseEmitter = new SseEmitter(100_000L); //초기화및 타임아웃 설정

        emps.put(empCode, sseEmitter);
				sseEmitter.onCompletion(() -> {
					emps.remove(empCode);
        });
				
        return sseEmitter;
    }

   public void sendEvent(String empCode, String msg) {
	   		SseEmitter sseEmitter = emps.get(empCode);
	   		if(sseEmitter != null) {
	   			try {
	   				sseEmitter.send(msg);
	   			} catch (IOException e) {
	   				sseEmitter.complete();
	   			}
	   		}
	    }
}
