package kr.or.iei.project.controller;

import java.util.List;
import java.util.Map;

import org.apache.maven.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.iei.project.model.service.ProjectService;

@Controller("projectController")
@RequestMapping("/emp/")
public class ProjectController {
	
	@Autowired
	@Qualifier("projectService")
	private ProjectService service;
	
	@PostMapping(value="/api/events")
	public List<Map<String, Object>> getProject(Model model){
		 return service.getProjects();
		 
		 
		 
		 
	}
}
