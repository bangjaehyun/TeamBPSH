package kr.or.iei.document.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.document.model.dao.DocumentDao;
import kr.or.iei.document.model.vo.Document;
import kr.or.iei.emp.model.vo.Emp;

@Service("documentService")
public class DocumentService {
	@Autowired
	@Qualifier("documentDao")
	private DocumentDao dao;

	public ArrayList<Document> apiDocumentList(String empCode) {
		
		return (ArrayList<Document>) dao.apiDocumentList(empCode);
	}

	public ArrayList<Emp> filterEmp(String teamCode) {
		// TODO Auto-generated method stub
		return (ArrayList<Emp>)dao.filterEmp(teamCode);
	}

	public Document viewDocOne(String documentCode) {
		Document document = dao.viewDocOne(documentCode);
		/*
		if(document != null) {
		//파일 LIST CHECK	
		}
		*/
		
		return document;
	}
	
	
}
