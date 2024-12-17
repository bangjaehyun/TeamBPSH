package kr.or.iei.common;

import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import kr.or.iei.emp.model.service.EmpService;
import kr.or.iei.emp.model.vo.Dept;
import kr.or.iei.emp.model.vo.Rank;
import kr.or.iei.emp.model.vo.Team;

@Component
public class LoadData implements ApplicationContextAware {

	  	@Resource
	    private ServletContext servletContext;

	    @Override
	    public void setApplicationContext(ApplicationContext applicationContext) {
	    	EmpService service = applicationContext.getBean(EmpService.class);
	    	
	    	service.chkAdmin();
	    	
	    	ArrayList<Dept> deptList = service.loadDept();
	        ArrayList<Team> teamList = service.loadTeam();
	        ArrayList<Rank> rankList = service.loadRank();
	           
	        servletContext.setAttribute("deptList", deptList);
	        servletContext.setAttribute("teamList", teamList);
	        servletContext.setAttribute("rankList", rankList);
	    }

}
