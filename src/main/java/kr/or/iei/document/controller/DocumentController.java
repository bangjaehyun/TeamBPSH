package kr.or.iei.document.controller;

import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.google.gson.Gson;

import kr.or.iei.document.model.service.DocumentService;
import kr.or.iei.document.model.vo.Document;

import kr.or.iei.emp.model.vo.Dept;
import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.emp.model.vo.Team;

@Controller("documentController")
@RequestMapping("/doc/")
public class DocumentController {
	@Resource
	private ServletContext servletContext;
	
	@Autowired
	@Qualifier("documentService")
	private DocumentService service;
	
	@PostMapping("writeDoc.do")//작성창 이동 메소드
	public String writeDoc(String type) {
		String folder="/document/";
		
		String file="";
		switch(type) {
			case("va"):{
				file="writeVacation";
				break;
			}
			
			case("co"):{
				file="writeCooperate";				
				break;
			}
			
			case("es"):{
				file="writeEstimate";	
				return folder + file;
			}
			
			case("bt"):{
				file="writeBuisiness";	
				break;
			}
			
			case("sp"):{
				file="writeSpending";	
				return folder + file;
			}
		}
		String result=folder+file;
		return result;
	}
	
	//type으로 보낸 값(결재자 or 참조자)구분
	@PostMapping("searchMan")
	public String searchMan(String type, Model m) {
		
		m.addAttribute("type",type);
		
		return"document/searchMan";
	}
	
	@PostMapping("srchTeam")
	@ResponseBody
	public ArrayList<Team>filterTeam(String deptCode){
		
		
		 ArrayList<Team>filterTeam=new ArrayList<Team>();
		 //팀 리스트, 부서리스트는 어플리케이션 스코프에 저장되어있어 별도의 sql없이 불러옴.
		 ArrayList<Team> teamList = (ArrayList<Team>) servletContext.getAttribute("teamList");
		 
		 for(int i=0;i<teamList.size();i++) {
			 Team team=new Team();
			 team=teamList.get(i);
			 
			 if(team.getDeptCode().equals(deptCode)) {
				 filterTeam.add(teamList.get(i));
			 }
		 }
		 System.out.println(filterTeam);
		return filterTeam;
	}
	
	@PostMapping("srchEmp")
	@ResponseBody
	public ArrayList<Emp>filterEmp(String teamCode){
		ArrayList<Emp>list=service.filterEmp(teamCode);
		
		return list;
		
	}
	
	
	
	//달력에서 문서 List 조회 - 프로젝트제외
	@PostMapping(value="api/documentType.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public String apiDocumentList(String empCode) {
		ArrayList<Document> list = service.apiDocumentList(empCode);
		
		return new Gson().toJson(list);
	}
	
	@GetMapping("detailDoc")
	public String detailDoc(Model model,Document document) {
		
		model.addAttribute(document.getDocumentCode());
		return "document/detailDoc";
	}
	
	//문서 상세보기 페이지
	@PostMapping("viewDocOne")
	public String viewDocOne(Model model, String documentCode) {
		Document document = service.viewDocOne(documentCode);
		model.addAttribute(document);
		return "document/viewDocOne";
	}
	
}
