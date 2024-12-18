package kr.or.iei.common.aop;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.or.iei.common.exception.CommonException;
import kr.or.iei.emp.model.vo.Emp;

@Aspect
@Component	
@Order(1) //@Aspect가 작성된 클래스 중, 1번째로 실행
public class LoginAOPClass {
	
	@Autowired
	@Qualifier("messageSource")
	private MessageSource message;
		
//1) 로그인 체킹
	
	//kr.or.iei 하위 모든 Controller 메소드를 타겟으로 지정.
	@Pointcut("execution(* kr.or.iei..controller..*(..))")
	public void allControllerPointCut() {}
	
	//어노테이션 설정
	@Pointcut("@annotation(kr.or.iei.common.annotation.NoLoginChk)")
	public void noLoginChkPointCut() {}
	
	//모든 Controller 메소드 중, 사용자 정의 어노테이션(NoLoginChk)이 선언되지 않은 메소드의 실행 전,후에 로직 처리
	@Around("allControllerPointCut() && !noLoginChkPointCut()")
	public Object noLoginChk(ProceedingJoinPoint pjp) throws Throwable {
		//클라이언트 세션
		HttpSession session = ((ServletRequestAttributes) (RequestContextHolder.currentRequestAttributes())).getRequest().getSession();
		
		//세션에 로그인 정보
		Emp loginEmp = (Emp) session.getAttribute("loginEmp");
		
		if(loginEmp == null) {
			//사용자 예외 발생
			CommonException ex = new CommonException("loginEmp Session is null");
			ex.setErrorCode("MA001");
			ex.setUserMsg(message.getMessage(ex.getErrorCode(), null, Locale.KOREA));
			throw ex;
			
		} else {
			//요청 Controller 메소드 실행
			return pjp.proceed();
		}
	}


}
