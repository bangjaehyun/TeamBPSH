package kr.or.iei.document.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.document.model.vo.Document;
import kr.or.iei.emp.model.vo.Emp;

@Repository("documentDao")
public class DocumentDao {
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;


	public List<Document> apiDocumentList(String empCode) {
		
		return sqlSession.selectList("document.apiDocumentList",empCode);
	}

	public List<Emp> filterEmp(String teamCode) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("emp.filterEmp",teamCode);
	}
	
	

}
