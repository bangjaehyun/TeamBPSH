package kr.or.iei.common.aop;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
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
@Order(2) //@Aspect가 작성된 클래스 중, 1번째로 실행
public class AddminAOPClass {

	@Autowired
	@Qualifier("messageSource")
	private MessageSource message;
	
	
	//어노테이션 설정
	@Pointcut("@annotation(kr.or.iei.common.annotation.AdminChk)")
	public void adminChkPointCut() {}
	
	//AdminChk 어노테이션이 있는 경우 체크
		@Around(" adminChkPointCut()")
		public Object adminChk(ProceedingJoinPoint pjp) throws Throwable {
			//클라이언트 세션
			HttpSession session = ((ServletRequestAttributes) (RequestContextHolder.currentRequestAttributes())).getRequest().getSession();
			
			//세션에 로그인 정보
			Emp loginEmp = (Emp) session.getAttribute("loginEmp");
			
			if(!loginEmp.getEmpId().equals("admin")) {
				//사용자 예외 발생
				CommonException ex = new CommonException("not admin");
				ex.setErrorCode("EC001");
				ex.setUserMsg(message.getMessage(ex.getErrorCode(), null, Locale.KOREA));
				throw ex;
				
			} else {
				//요청 Controller 메소드 실행
				return pjp.proceed();
			}
		}
}
