package kr.or.iei.document.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.catalina.connector.Response;
import org.apache.commons.collections.map.HashedMap;
import org.apache.maven.classrealm.ClassRealmRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import com.google.gson.Gson;
import kr.or.iei.document.model.service.DocumentService;
import kr.or.iei.document.model.vo.Document;
import kr.or.iei.document.model.vo.DocumentFile;
import kr.or.iei.document.model.vo.DocumentReference;
import kr.or.iei.document.model.vo.DocumentSelectDay;
import kr.or.iei.document.model.vo.DocumentSign;
import kr.or.iei.document.model.vo.DocumentType;
import kr.or.iei.document.model.vo.Spending;
import kr.or.iei.document.model.vo.VacationHalf;
import kr.or.iei.emp.model.service.EmpService;
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
	
	//전체리스트 추가
		@PostMapping("selectList.do")
		public String selectList(String type,String reqPage,Model m) {
			int page=reqPage==null?1:Integer.parseInt(reqPage);
			ArrayList<Document> documentList=service.selectList(type,page);
			ArrayList<DocumentType> docTypeList=service.selectDocType();
			m.addAttribute("docList", documentList);
			m.addAttribute("docTypeList",docTypeList);
			return "document/documentList";
		}
		
		//type으로 보낸 값(결재자 or 참조자)구분
		@PostMapping(value="searchMan.do", produces ="application/text; charset=utf-8")
		public String srchMan( String type, Model m) {

		   

		    // 모델에 값 추가
		    m.addAttribute("type", type);
		   

		    return "document/searchMan";
		}
	
	
	
	//type으로 보낸 값(결재자 or 참조자)구분
	@PostMapping("searchMan.do")
	public String searchMan( String type, Model m) {

	   

	    // 모델에 값 추가
	    m.addAttribute("type", type);
	   

	    return "document/searchMan";
	}
	
	@PostMapping("srchTeam.do")
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
	
	@PostMapping("srchEmp.do")
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

	//이미지 넣기
	@PostMapping(value="documentImage.do",produces="application/json;charset=utf-8")
	@ResponseBody
	public String insertDocumentImage(HttpServletRequest request,HttpServletResponse response,  MultipartFile uploadFile ) {
		String today=new SimpleDateFormat("yyyyMMdd").format(new Date());
		String savePath="/resources/documentImages/"+today+"/";
		String root=request.getSession().getServletContext().getRealPath(savePath);
		
		
		
		File directory=new File(root);
		if(!directory.exists()) {
			directory.mkdirs();
		}
		today=new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String originalFileName =((MultipartFile) uploadFile).getOriginalFilename();
		String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		
		
		String filePath=fileName+"_"+today+extension;
		root+=filePath;
		savePath+=filePath;
		 File savedFile = new File(root);
	        try {
				uploadFile.transferTo(savedFile);
				System.out.println(savedFile);
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		System.out.println(savePath);
	        	
	        return new Gson().toJson(savePath);
	
	}

	
	//휴가신청서
		@PostMapping(value="writeVacation.do",produces="application/json; charset=utf-8")
		@ResponseBody
		public int writeVacation(HttpSession session,HttpServletRequest request,Document document,@RequestParam MultipartFile[] files,@RequestParam List<String> signEmpList, @RequestParam List<String> refEmpList,DocumentSelectDay selDay,VacationHalf vacHalf,Model m ) {
			String root=request.getSession().getServletContext().getRealPath("/resources/");
			
			//파일관련 기능
			ArrayList<DocumentFile>fileList=new ArrayList<DocumentFile>();
			
			String documentCode=service.selectDocumentCode();
			document.setDocumentCode(documentCode);
			Date date=new Date();
			String today=new SimpleDateFormat("yyyyMMdd").format(date);
			
			String savePath = root + "documentFiles" + File.separator + today + File.separator;

			
			File directory=new File(savePath);
			if(!directory.exists()) {
				directory.mkdir();
			}
			today=new SimpleDateFormat("yyyyMMddHHmmss").format(date);
			for (int i=0;i<files.length;i++) {
				MultipartFile file=files[i];
				
				if(!file.isEmpty()) {
					
					String originalFileName =file.getOriginalFilename();
					String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
					String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
					
					
					
					String filePath=fileName+"_"+today+extension;
					savePath+=filePath;
					
					BufferedOutputStream bos=null;
					
					try {
							byte []bytes=file.getBytes();
							FileOutputStream fos=new FileOutputStream(new File(savePath));
							bos = new BufferedOutputStream(fos);
							bos.write(bytes);
							
							DocumentFile docFile=new DocumentFile();
							docFile.setFileName(originalFileName);
							docFile.setFilePath(filePath);
							docFile.setDocumentCode(documentCode);
							fileList.add(docFile);
					}catch(IOException e) {
						e.printStackTrace();
					}finally {
						try {
							bos.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
			}
			document.setFileList(fileList);
			
			
			//결재자
			 ArrayList<DocumentSign> signList = new ArrayList<>();
			    for (int i = 0; i < signEmpList.size(); i++) {
			        DocumentSign sign = new DocumentSign();
			        sign.setEmpCode(signEmpList.get(i));
			        sign.setDocumentSeq(String.valueOf(i + 1));
			        sign.setDocumentCode(documentCode);
			        signList.add(sign);
			    }
			    document.setSignList(signList);
			
			    ArrayList<DocumentReference> refList = new ArrayList<>();
			    for (String refCode : refEmpList) {
			        DocumentReference ref = new DocumentReference();
			        ref.setEmpCode(refCode);
			        ref.setDocumentCode(documentCode);
			        refList.add(ref);
			    }
			    document.setRefList(refList);
			
			   
			   
			    		String start= selDay.getStart().replace("-","");
			    				

			if(vacHalf.isHalf()==true) {
				vacHalf.setDocumentCode(documentCode);
				vacHalf.setVacDate(start);
			}else {
				String end= selDay.getEnd().replace("-", "");
				selDay.setStart(start);
				selDay.setEnd(end);
				selDay.setDocumentCode(documentCode);
				
			}
			
				
				
			int result=service.insertVacation(document,selDay, vacHalf);
			return result;
		}
		
		
		//지출결의서 작성
		@PostMapping(value="writeSpending.do",produces="application/json; charset=utf-8")
		@ResponseBody
		public int writeSpending(HttpSession session,HttpServletRequest request,Document document,@RequestParam MultipartFile[] files,@RequestParam List<String> signEmpList, @RequestParam List<String> refEmpList,@RequestParam List<String> spendingList,Model m ) {
			String root=request.getSession().getServletContext().getRealPath("/resources/");
			
			//파일관련 기능
			ArrayList<DocumentFile>fileList=new ArrayList<DocumentFile>();
			
			String documentCode=service.selectDocumentCode();
			document.setDocumentCode(documentCode);
			Date date=new Date();
			String today=new SimpleDateFormat("yyyyMMdd").format(date);
			
			String savePath = root + "documentFiles" + File.separator + today + File.separator;

			File directory=new File(savePath);
			if(!directory.exists()) {
				directory.mkdir();
			}
			today=new SimpleDateFormat("yyyyMMddHHmmss").format(date);
			for (int i=0;i<files.length;i++) {
				MultipartFile file=files[i];
				
			
				if(!file.isEmpty()) {
					
					String originalFileName =file.getOriginalFilename();
					String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
					String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
					
					
					int ranNum = new Random().nextInt(9999)+1;
					String filePath=fileName+"_"+today+"_"+ranNum+extension;
					savePath+=filePath;
					
					BufferedOutputStream bos=null;
					
					try {
							byte []bytes=file.getBytes();
							FileOutputStream fos=new FileOutputStream(new File(savePath));
							bos = new BufferedOutputStream(fos);
							bos.write(bytes);
							
							DocumentFile docFile=new DocumentFile();
							docFile.setFileName(originalFileName);
							docFile.setFilePath(filePath);
							docFile.setDocumentCode(documentCode);
							fileList.add(docFile);
					}catch(IOException e) {
						e.printStackTrace();
					}finally {
						try {
							bos.close();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}
			}
			document.setFileList(fileList);
			
			
			//결재자
			 ArrayList<DocumentSign> signList = new ArrayList<>();
			    for (int i = 0; i < signEmpList.size(); i++) {
			        DocumentSign sign = new DocumentSign();
			        sign.setEmpCode(signEmpList.get(i));
			        sign.setDocumentSeq(String.valueOf(i + 1));
			        sign.setDocumentCode(documentCode);
			        signList.add(sign);
			    }
			    document.setSignList(signList);
			
			    ArrayList<DocumentReference> refList = new ArrayList<>();
			    for (String refCode : refEmpList) {
			        DocumentReference ref = new DocumentReference();
			        ref.setEmpCode(refCode);
			        ref.setDocumentCode(documentCode);
			        refList.add(ref);
			    }
			    document.setRefList(refList);

			int result=service.insertSpending(document,spendingList);
			
			return result;
		}
		


	@PostMapping("apiPageDocType")
	@ResponseBody
	public List<DocumentType> apiPageDocType(String empCode) {
		ArrayList<DocumentType> documentList = service.apiPageDocType(empCode);
		
		
		return documentList;
	}
	
	@PostMapping("viewDocOne.do")
	public String viewDocOne(Model model,String documentTypeCode,String documentCode) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("documentTypeCode", documentTypeCode);
		map.put("documentCode", documentCode);
		Document document = service.viewDocOne(map);
		model.addAttribute("document",document);
		
		return "document/viewDocOne";
	}

}
