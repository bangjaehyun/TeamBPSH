package kr.or.iei.document.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.document.model.dao.DocumentDao;
import kr.or.iei.document.model.vo.Document;
import kr.or.iei.document.model.vo.DocumentFile;
import kr.or.iei.document.model.vo.DocumentReference;
import kr.or.iei.document.model.vo.DocumentSelectDay;
import kr.or.iei.document.model.vo.DocumentSign;
import kr.or.iei.document.model.vo.DocumentType;
import kr.or.iei.document.model.vo.Spending;
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
	
	//리스트조회
		public ArrayList<Document> selectList(String type, int page) {
			// TODO Auto-generated method stub
			
			HashMap<String,String>paging=new HashMap<String, String>();
			paging.put("type", type);
			
			
			ArrayList<Document>list=(ArrayList<Document>)dao.selectDocList(paging);
			System.out.println(list);
			for(int i=0;i<list.size();i++) {
				int check=1;
				ArrayList<DocumentSign>signList=(ArrayList<DocumentSign>)dao.selectDocSign(list.get(i).getDocumentCode());
				System.out.println(signList);
				list.get(i).setSignList(signList);
				System.out.println(list);
				for(int j=0;j<signList.size();j++) {
					
					int res=Integer.parseInt(signList.get(j).getSignYn());
					if(res==-1) {
						check=-1;
						break;
					}else if(res==0) {
						check=0;
						break;
					}
				}
				if(check==0) {
					list.get(i).setProgress("진행중");
				}else if(check==-1) {
					list.get(i).setProgress("기각");
				}else {
					list.get(i).setProgress("승인");
				}
			}
			
			
			
			//전체 카운트
		
				
					
						
			
			return list;
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
				return result;
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
					result+=1;
				}else {
					return result;
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
	public Document viewDocOne(HashMap<String, Object> map) {
		 Document document =  dao.viewDocOne(map);
		 
		if(document != null) {
			/*
			ArrayList<DocumentFile> fileList = (ArrayList<DocumentFile>) dao.selectFileList(map);
			document.setFileList(fileList);
			*/
			ArrayList<DocumentSign> signList = (ArrayList<DocumentSign>) dao.selectSignList(map);
			document.setSignList(signList);
		}
		
		
		return document;

	}

	//지출결의서 작성
	@Transactional
	public int insertSpending(Document document, List<String> spendingList) {
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
				return result;
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
			}
		
		if(result>2) {
			check=0;
			String documentCode=document.getDocumentCode();
			System.out.println(documentCode);
			for(String spend:spendingList) {
				String spendingCode=dao.getSpendingCode();
				
				   
				        String[] details = spend.split(" "); // 세부 정보 분리
				        String spendingDay = details[0].replace("-", "");
				        String spendingCost = details[1];
				        String spendingContent = details[2];
				       
				    
				HashMap<String, String> map=new HashMap<String, String>();
				map.put("spendingCode", spendingCode);
				map.put("documentCode", documentCode);
				map.put("spendingDay", spendingDay);
				map.put("spendingCost", spendingCost);
				map.put("spendingContent", spendingContent);
				check+=dao.insertSpending(map);
			}
			if(check<spendingList.size()) {
				
			}else {
				result+=1;
			}
			}
		
		return result;
	}

	public ArrayList<DocumentType> apiPageDocType(String empCode) {
		
		return (ArrayList<DocumentType>) dao.apiPageDocType(empCode);
	}


	public ArrayList<DocumentType> selectDocType() {
		// TODO Auto-generated method stub
		return (ArrayList<DocumentType>)dao.selectDocType();
		
	}


	
}
