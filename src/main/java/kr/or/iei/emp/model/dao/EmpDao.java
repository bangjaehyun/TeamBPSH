package kr.or.iei.emp.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.emp.model.vo.Emp;

@Repository("empDao")
public class EmpDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	public Emp login(Emp emp) {
		Emp loginEmp= sqlSession.selectOne("emp.loginEmp",emp);
		System.out.println(loginEmp);
		 if(loginEmp!=null) {
			boolean checkPw=BCrypt.checkpw(emp.getEmpPw(), loginEmp.getEmpPw());
			System.out.println(checkPw);
			if(checkPw) {
			loginEmp.setEmpPw(emp.getEmpPw());
			return loginEmp;
			
			}else {
				return null;
			}
		 }else {
			 return null;
		 }
		
	}

	public int selectAdmin(String empCode) {
		return sqlSession.selectOne("emp.adminChk",empCode);
	}

	public int idCheck(String empId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("emp.idCheck", empId);
	}

	public int join(Emp emp) {
		// TODO Auto-generated method stub
		return sqlSession.insert("emp.join",emp);
	}

	public List<Emp> empWaitList() {
		return sqlSession.selectList("emp.empWaitList");
	}

}
