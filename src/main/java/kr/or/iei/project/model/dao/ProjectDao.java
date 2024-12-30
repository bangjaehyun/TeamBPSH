package kr.or.iei.project.model.dao;

import java.util.ArrayList;
import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.project.model.vo.Project;

@Repository("projectDao")
public class ProjectDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	//달력 프로젝트 List 불러오기
	public List<Project> getProjects(String teamCode) {
		return sqlSession.selectList("project.apiProjectList",teamCode);
		
	}

	public List<Project> projectList(String teamCode) {
		
		return sqlSession.selectList("project.projectList", teamCode);
	}

	public Project projectView(String projectNo) {
		
		return sqlSession.selectOne("project.projectView", projectNo);
	}

	public List<Emp> projectEmpList(String projectNo) {
		
		return sqlSession.selectList("project.projectPartempList", projectNo);
	}

	
	

}
