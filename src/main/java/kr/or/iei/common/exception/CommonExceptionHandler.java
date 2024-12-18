package kr.or.iei.common.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

@ControllerAdvice
public class CommonExceptionHandler {
	
	
	//강제로 발생시킨 예외에 대해 처리
	@ExceptionHandler(CommonException.class)
	@ResponseBody
	public Object commonExceptionHandle(CommonException ex, HttpServletRequest request, HttpServletResponse response) {
		ex.printStackTrace();
		
		if(isAjaxRequest(request)) {
			//ajax - 예외 처리
			response.setContentType("application/json; charset=utf-8");
			
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("title", "오류 발생");
			jsonObj.addProperty("msg", ex.getUserMsg());
			jsonObj.addProperty("icon", "error");
			if(ex.getErrorCode().substring(0, 2).equals("MA")) {
				jsonObj.addProperty("loc", "/");
			}
			return new Gson().toJson(jsonObj);
		}else {
			
			ModelAndView model = new ModelAndView("error/errorMsg");
			model.addObject("title", "오류 발생");
			model.addObject("msg", ex.getUserMsg());
			model.addObject("icon", "error");
			
			if(ex.getErrorCode().substring(0, 2).equals("MA")) { //세션에 로그인 회원 미존재
				model.addObject("loc", "/");
			} else if(ex.getErrorCode().equals("MN101")) { //메뉴 권한 불충분				
				
			}
			
			return model;
		}
	}
	
	//Ajax 요청 여부 검증
	private boolean isAjaxRequest(HttpServletRequest request) {
		if(request.getHeader("X-Requested-With") != null) {
			return "xmlhttprequest".equals(request.getHeader("X-Requested-With").toLowerCase());			
		}else {
			return false;
		}
    }
	
	//CommonException으로 강제 예외처리한 경우 이외의 Exception 발생 시 처리 핸들러
	@ExceptionHandler(Exception.class)
	public String exception(Exception ex) {
		ex.printStackTrace();
		System.out.println("Exception Handler");
		return null;
	}
}
