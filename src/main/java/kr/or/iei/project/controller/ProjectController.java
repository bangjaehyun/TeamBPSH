package kr.or.iei.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.project.model.service.ProjectService;
import kr.or.iei.project.model.vo.Project;
import kr.or.iei.project.model.vo.ProjectPartemp;

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
	
	@PostMapping("list.do")
	public String projectListPage(Model model, String teamCode) {
		ArrayList<Project> project = service.projectList(teamCode);
		model.addAttribute("projectList",project);
		return "project/projectList";
	}
	
	@PostMapping("view.do")
	public String projectView(Model model, String projectNo) {
		Project project = service.projectView(projectNo);
		List<Emp> projectPartempList = service.projectEmpList(projectNo);
		 model.addAttribute("project", project);
		 model.addAttribute("projectPartempList", projectPartempList);
	    
	    return "project/projectView";
	}
	
	@PostMapping("writeFrm.do")
	public String projectWriteFrm(Model model) {
		return "project/writeProject";
	}
	
	@PostMapping("write.do")
	public String projectWrite(Project project,@RequestParam(name="teamCode") List<String> teamCode) {
		int result = service.projectWrite(project,teamCode);
		System.out.println(teamCode);
		return "project/projectList";
	}
	

}
