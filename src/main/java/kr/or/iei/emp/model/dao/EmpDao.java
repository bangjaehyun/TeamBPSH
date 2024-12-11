package kr.or.iei.emp.model.dao;

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
		return sqlSession.selectOne("emp.loginEmp",emp);
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
}
