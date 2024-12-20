package kr.or.iei.document.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.google.gson.Gson;

import kr.or.iei.document.model.service.DocumentService;
import kr.or.iei.document.model.vo.Document;
import kr.or.iei.emp.model.service.EmpService;
import kr.or.iei.emp.model.vo.Dept;
import kr.or.iei.emp.model.vo.Team;

@Controller("documentController")
@RequestMapping("/doc/")
public class DocumentController {
	
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
				break;
			}
			
			case("bt"):{
				file="writeBuisiness";	
				break;
			}
			
			case("sp"):{
				file="writeSpending";	
				break;
			}
		}
		String result=folder+file;
		return result;
	}
	
	@PostMapping("searchMan")
	public String searchMan(String option, Model m ) {
		
		return"document/searchMan";
	}
	
	@PostMapping("srchTeam")
	@ResponseBody
	public ArrayList<Team>filtTeam(String deptCode){
		EmpService service=new EmpService();
		 ArrayList<Team>filterTeam=new ArrayList<Team>();
		 ArrayList<Team>teamList=service.loadTeam();
		 for(int i=0;i<teamList.size();i++) {
			 if(teamList.get(i).getDeptCode().equals(deptCode)) {
				 filterTeam.add(teamList.get(i));
			 }
		 }
		 System.out.println(filterTeam);
		return filterTeam;
	}
	
	//달력에서 문서 List 조회 - 프로젝트제외
	@PostMapping(value="api/documentType.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public String apiDocumentList(String empCode) {
		ArrayList<Document> list = service.apiDocumentList(empCode);
		
		return new Gson().toJson(list);
	}
	
	
}
