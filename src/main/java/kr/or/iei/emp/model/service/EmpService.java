package kr.or.iei.emp.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.emp.model.dao.EmpDao;
import kr.or.iei.emp.model.vo.Emp;

@Service("empService")
public class EmpService {

	@Autowired
	@Qualifier("empDao")
	private EmpDao dao;

	public Emp login(Emp emp) {
		Emp loginEmp = dao.login(emp);

		if (loginEmp != null && loginEmp.getTeamCode().equals("G1")) {
			int adminChk = dao.selectAdmin(loginEmp.getEmpCode());
			
			if (adminChk > 0) {
				loginEmp.setAdmin(true);
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
}
