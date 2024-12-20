package kr.or.iei.project.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.maven.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.iei.project.model.service.ProjectService;
import kr.or.iei.project.model.vo.Project;

@Controller("projectController")
@RequestMapping("/project/")
public class ProjectController {
	
	@Autowired
	@Qualifier("projectService")
	private ProjectService service;
	
	//달력 프로젝트 List 불러오기
	@PostMapping(value="api/projectList.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public String getProject(String teamCode){
		
		ArrayList<Project> project = service.getProjects(teamCode);
		 return new Gson().toJson(project); 
		 
	}
}
