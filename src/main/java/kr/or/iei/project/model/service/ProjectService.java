package kr.or.iei.project.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.project.model.dao.ProjectDao;
import kr.or.iei.project.model.vo.Project;

@Service("projectService")
public class ProjectService {
	
	@Autowired
	@Qualifier("projectDao")
	private ProjectDao dao;

	//달력 프로젝트 List 불러오기
	public ArrayList<Project> getProjects(String teamCode) {
		
		return (ArrayList<Project>)dao.getProjects(teamCode);
	}

	public ArrayList<Project> projectList(String teamCode) {
		
		return  (ArrayList<Project>)dao.projectList(teamCode);
	}

	public Project projectView(String projectNo) {
		
		return dao.projectView(projectNo);
	}

	public List<Emp> projectEmpList(String projectNo) {
		return  dao.projectEmpList(projectNo);
	}


}
