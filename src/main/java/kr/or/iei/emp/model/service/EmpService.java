package kr.or.iei.emp.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.emp.model.dao.EmpDao;
import kr.or.iei.emp.model.vo.Dept;
import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.emp.model.vo.Rank;
import kr.or.iei.emp.model.vo.Team;

@Service("empService")
public class EmpService {

	@Autowired
	@Qualifier("empDao")
	private EmpDao dao;

	public Emp login(Emp emp) {
		Emp loginEmp = dao.login(emp);
		if (loginEmp != null &&loginEmp.getTeamCode()!=null){
		if (loginEmp != null && loginEmp.getTeamCode().equals("G1")) {
			int adminChk = dao.selectAdmin(loginEmp.getEmpCode());
			
			if (adminChk > 0) {
				loginEmp.setAdmin(true);
			}
		}else {
			
		}
		}
		return loginEmp;
	}

	public int idCheck(String empId) {
		// TODO Auto-generated method stub
		
		return dao.idCheck(empId);
	}

	public int join(Emp emp) {
		// TODO Auto-generated method stub
		return dao.join(emp);
	}

	public ArrayList<Emp> empWaitList() {
		return (ArrayList<Emp>) dao.empWaitList();
	}
	
	public ArrayList<Dept> loadDept() {
		return (ArrayList<Dept>)dao.loadDept();
	}

	public ArrayList<Team> loadTeam() {
		return (ArrayList<Team>)dao.loadTeam();
	}

	public ArrayList<Rank> loadRank() {
		return (ArrayList<Rank>)dao.loadRank();
	}

	@Transactional
	public int approval(Emp emp, int salary) {
		int result = dao.approvalEmp(emp);
		
		if(result > 0) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("empCode", emp.getEmpCode());
			map.put("salary", String.valueOf(salary));
			
			result = dao.insertSalary(map);
			
			if(result > 0) {
				result = dao.deleteWait(emp.getEmpCode());
			}
		}
		return result;
	}

	public void chkAdmin() {
		int result = dao.idCheck("admin");
		if(result == 0) {
			String pw = BCrypt.hashpw("1234", BCrypt.gensalt());
			Emp emp = new Emp();
			emp.setEmpId("admin");
			emp.setEmpPw(pw);
			emp.setTeamCode("G1");
			emp.setRankCode("J6");
			emp.setEmpName("배재현");
			emp.setEmpPhone("01012341234");
			emp.setEmpRetire("n");
			result = dao.insertAdmin(emp);
			if(result > 0) {
				dao.deleteWait(emp.getDeptCode());
			}
		}
	}
}
