package kr.or.iei.document.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.document.model.dao.DocumentDao;
import kr.or.iei.document.model.vo.Document;
import kr.or.iei.document.model.vo.DocumentFile;
import kr.or.iei.document.model.vo.DocumentReference;
import kr.or.iei.document.model.vo.DocumentSelectDay;
import kr.or.iei.document.model.vo.DocumentSign;
import kr.or.iei.document.model.vo.VacationHalf;
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


	public String selectDocumentCode() {
		// TODO Auto-generated method stub
		String documentCode=dao.selectDocumentCode();
		return documentCode;
	}

	@Transactional
	public int insertVacation(Document document, DocumentSelectDay selDay, VacationHalf vacHalf) {
		// TODO Auto-generated method stub
		int result=0;
		int check=0;
		result+=dao.insertDocument(document);
		
		if(result>0) {
			for(int i=0;i<document.getFileList().size();i++){
				DocumentFile file=document.getFileList().get(i);
				check+=dao.insertFile(file);
			}
			if(check<document.getFileList().size()) {
				//파일삽입에 문제가 발생할 경우 추가 삽입 X
				
			}else {
				result+=1;//다음 기능 실행
			}
		}
		if(result>1) {
			//결재자, 참조자 삽입
			check=0;
			//참조자가 있는가 없는가의 차이
			if(document.getRefList().size()>0) {
				for(int i=0;i<document.getSignList().size();i++) {
					DocumentSign sign=document.getSignList().get(i);
					sign.setDocumentSeq(String.valueOf(i+1));
					check+=dao.insertDocumentSign(sign);
				}
				for(int i=0;i<document.getRefList().size();i++) {
					DocumentReference ref=document.getRefList().get(i);
					check+=dao.insertDocumentRef(ref);
				}
				//참조자 포함 삽입결과가 목록의 합계와 동일한가?
				if(check<document.getSignList().size()+document.getRefList().size()) {
					
				}else {
					result+=1;
				}
			}else {
				for(int i=0;i<document.getSignList().size();i++) {
					DocumentSign sign=document.getSignList().get(i);
					sign.setDocumentSeq(String.valueOf(i+1));
					check+=dao.insertDocumentSign(sign);
				}
					if(check<document.getSignList().size()) {
						
					}else {
						result+=1;
					}
			}
			
			//결재자, 참조차 삽입에 문제가 없을시 휴가 or 반차 입력
			if(result>2) {
				
				if(vacHalf.isHalf()==true) {
					result+=dao.insertVacationHalf(vacHalf);
				}else {
					result+=dao.insertVacationAnnual(selDay);
				}
				
			}
			
			
			
			
		}
		
		
		
		return result;
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
