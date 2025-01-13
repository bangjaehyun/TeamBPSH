package kr.or.iei.document.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.catalina.connector.Response;
import org.apache.commons.collections.map.HashedMap;
import org.apache.maven.classrealm.ClassRealmRequest;
import org.apache.tomcat.jni.Mmap;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.socket.messaging.SubProtocolWebSocketHandler;

import com.google.gson.Gson;

import kr.or.iei.common.emitter.Emitter;
import kr.or.iei.document.model.service.DocumentService;
import kr.or.iei.document.model.vo.Business;
import kr.or.iei.document.model.vo.Cooperate;
import kr.or.iei.document.model.vo.Document;
import kr.or.iei.document.model.vo.DocumentFile;
import kr.or.iei.document.model.vo.DocumentReference;
import kr.or.iei.document.model.vo.DocumentSelectDay;
import kr.or.iei.document.model.vo.DocumentSign;
import kr.or.iei.document.model.vo.DocumentType;
import kr.or.iei.document.model.vo.Estimate;
import kr.or.iei.document.model.vo.Spending;
import kr.or.iei.document.model.vo.VacationHalf;
import kr.or.iei.emp.model.service.EmpService;
import kr.or.iei.emp.model.vo.Alarm;
import kr.or.iei.emp.model.vo.Commute;
import kr.or.iei.emp.model.vo.Dept;
import kr.or.iei.emp.model.vo.DevelopPrice;
import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.emp.model.vo.Rank;
import kr.or.iei.emp.model.vo.Team;

@Controller("documentController")
@RequestMapping("/doc/")
public class DocumentController {
	@Resource
	private ServletContext servletContext;
	
	@Autowired
	@Qualifier("documentService")
	private DocumentService service;
	
	
	@Autowired
	@Qualifier("emitter")
	private Emitter emitter;
	@PostMapping("writeDoc.do")//작성창 이동 메소드
	public String writeDoc(String type,Model m) {
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
				 ArrayList<Team> teamList = (ArrayList<Team>) servletContext.getAttribute("teamList");
				 ArrayList<Rank> rankList=(ArrayList<Rank>)servletContext.getAttribute("rankList");
				 ArrayList<DevelopPrice>priceList=(ArrayList<DevelopPrice>)service.selectPriceList();
				 m.addAttribute("rankList", rankList);
				 m.addAttribute("teamList",teamList);
				 m.addAttribute("priceList", priceList);
				return folder + file;
			}
			
			case("bt"):{
				file="writeBusiness";	
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
			
			ArrayList<Document> documentList=service.selectList(type);
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
		
		return filterTeam;
	}
	
	@PostMapping("srchEmp.do")
	@ResponseBody
	public ArrayList<Emp>filterEmp(String teamCode,String empCode){
		HashMap<String,String>srchMap=new HashMap<String, String>();
		srchMap.put("teamCode",teamCode);
		srchMap.put("empCode", empCode);
		ArrayList<Emp>list=service.filterEmp(srchMap);
		
		
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
				
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	        	
	        return new Gson().toJson(savePath);
	
	}

	
	//휴가신청서
		@PostMapping(value="writeVacation.do",produces="application/json; charset=utf-8")
		@ResponseBody
		public int writeVacation(HttpSession session,HttpServletRequest request,Document document,@RequestParam MultipartFile[] files,@RequestParam List<String> signEmpList, @RequestParam List<String> refEmpList,DocumentSelectDay selDay,VacationHalf vacHalf,Model m ) {
	
			if(vacHalf.isHalf()==true) {
				double remainVac=service.selectRemainRealVac(document.getEmpCode());
				if(remainVac==0.0) {
					return -1;
				}
			}else {
				try {
					
					Date startDay = new SimpleDateFormat("yyyyMMdd").parse(selDay.getStartDay().replace("-", ""));
					Date endDay = new SimpleDateFormat("yyyyMMdd").parse(selDay.getEndDay().replace("-", ""));
					long diffInMillies = endDay.getTime() - startDay.getTime();
					int time = (int) (diffInMillies / (1000 * 60 * 60 * 24))+1; 
					double remainVac=service.selectRemainVac(document.getEmpCode());
					if(time>remainVac) {
						return -1;
					}
				} catch (ParseException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			
			
			
			
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
			
			    //참조자
			    ArrayList<DocumentReference> refList = new ArrayList<>();
			    for (String refCode : refEmpList) {
			        DocumentReference ref = new DocumentReference();
			        ref.setEmpCode(refCode);
			        ref.setDocumentCode(documentCode);
			        refList.add(ref);
			    }
			    document.setRefList(refList);
			
			   
			   
			    		String start= selDay.getStartDay().replace("-","");
			    				

			if(vacHalf.isHalf()==true) {
				vacHalf.setDocumentCode(documentCode);
				vacHalf.setVacDate(start);
			}else {
				String end= selDay.getEndDay().replace("-", "");
				selDay.setStartDay(start);
				selDay.setEndDay(end);
				selDay.setDocumentCode(documentCode);
				
			}
			
				
				
			int result=service.insertVacation(document,selDay, vacHalf);
			
			
			ArrayList<DocumentSign> signs=service.selectSignList(documentCode);
			
			Alarm alarm = new Alarm();
			alarm.setAlarmComment(signs.get(0).getEmpName()+"님 결재할 차례입니다");
			alarm.setEmpCode(signs.get(0).getEmpCode());
			alarm.setRefUrl("/doc/selectOneVa.do");
			
			JSONObject json=new JSONObject();
			json.put("documentCode", documentCode);
			alarm.setUrlParam(json.toJSONString());
			
			int res=service.insertAlarm(alarm);
			if(res>0&&result>0) {
				emitter.sendEvent(signs.get(0).getEmpCode(), alarm.getAlarmComment());
			}
			
			ArrayList<DocumentReference>refs=service.selectRefList(documentCode);
			
			for(int i=0;i<refs.size();i++) {
				Alarm refAlarm=new Alarm();
				refAlarm.setAlarmComment("참조할 문서가 있습니다.");
				refAlarm.setEmpCode(refs.get(i).getEmpCode());
				refAlarm.setRefUrl("/doc/selectOneVa.do");
				JSONObject json2=new JSONObject();
				json2.put("documentCode", documentCode);
				refAlarm.setUrlParam(json2.toJSONString());
				 int res2=service.insertAlarm(refAlarm);
				if(res2>0&&result>0) {
					emitter.sendEvent(refs.get(i).getEmpCode(), refAlarm.getAlarmComment());
				}
				
				}
			
			
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
			
			
			
			ArrayList<DocumentSign> signs=service.selectSignList(documentCode);
			Alarm alarm = new Alarm();
			alarm.setAlarmComment(signs.get(0).getEmpName()+"님 결재할 차례입니다");
			alarm.setEmpCode(signs.get(0).getEmpCode());
			alarm.setRefUrl("/doc/selectOneSp.do");
			
			JSONObject json=new JSONObject();
			json.put("documentCode", documentCode);
			alarm.setUrlParam(json.toJSONString());
			
			int res=service.insertAlarm(alarm);
			if(result>0&&res>0) {
				emitter.sendEvent(signs.get(0).getEmpCode(), alarm.getAlarmComment());
			}
			
			ArrayList<DocumentReference>refs=service.selectRefList(documentCode);
			
			for(int i=0;i<refs.size();i++) {
				Alarm refAlarm=new Alarm();
				refAlarm.setAlarmComment("참조할 문서가 있습니다.");
				refAlarm.setEmpCode(refs.get(i).getEmpCode());
				refAlarm.setRefUrl("/doc/selectOneSp.do");
				JSONObject json2=new JSONObject();
				json2.put("documentCode", documentCode);
				refAlarm.setUrlParam(json2.toJSONString());
				 int res2=service.insertAlarm(refAlarm);
				if(res2>0&&result>0) {
					emitter.sendEvent(refs.get(i).getEmpCode(), refAlarm.getAlarmComment());
				}
				
				}
			
			return result;
		}
		
		//출장보고서 작성
		@PostMapping(value="writeBusiness.do",produces="application/json; charset=utf-8")
		@ResponseBody
		public int writeBusiness(HttpSession session,HttpServletRequest request,Document document,@RequestParam MultipartFile[] files,@RequestParam List<String> signEmpList, @RequestParam List<String> refEmpList,Business business,Model m ) {
			
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
			
			    //참조자
			    ArrayList<DocumentReference> refList = new ArrayList<>();
			    for (String refCode : refEmpList) {
			        DocumentReference ref = new DocumentReference();
			        ref.setEmpCode(refCode);
			        ref.setDocumentCode(documentCode);
			        refList.add(ref);
			    }
			    document.setRefList(refList);
			
			    business.setDocumentCode(documentCode);
			    String startdate=business.getBusinessStart().replace("-", "");
				String endDate=business.getBusinessEnd().replace("-", "");
	    		business.setBusinessStart(startdate);
			    business.setBusinessEnd(endDate);		
				
				
			int result=service.insertBusiness(document,business);
			
			//처음 지정된 결재자
			ArrayList<DocumentSign> signs=service.selectSignList(documentCode);
			
			Alarm alarm = new Alarm();
			alarm.setAlarmComment(signs.get(0).getEmpName()+"님 결재할 차례입니다");
			alarm.setEmpCode(signs.get(0).getEmpCode());
			alarm.setRefUrl("/doc/selectOneBt.do");
			
			JSONObject json=new JSONObject();
			json.put("documentCode", documentCode);
			alarm.setUrlParam(json.toJSONString());
			
			
			int res=service.insertAlarm(alarm);
			if(res>0&&result>0) {
				emitter.sendEvent(signs.get(0).getEmpCode(), alarm.getAlarmComment());
			}
			
			//모든 참조자
			ArrayList<DocumentReference>refs=service.selectRefList(documentCode);
			
			for(int i=0;i<refs.size();i++) {
				Alarm refAlarm=new Alarm();
				refAlarm.setAlarmComment("참조할 문서가 있습니다.");
				refAlarm.setEmpCode(refs.get(i).getEmpCode());
				refAlarm.setRefUrl("/doc/selectOneBt.do");
				JSONObject json2=new JSONObject();
				json2.put("documentCode", documentCode);
				
				refAlarm.setUrlParam(json2.toJSONString());
				 int res2=service.insertAlarm(refAlarm);
				if(res2>0&&result>0) {
					emitter.sendEvent(refs.get(i).getEmpCode(), refAlarm.getAlarmComment());
				}
				
				}
			
			
			return result;
		}
		
		
		
		//견적서작성
		@PostMapping(value="writeEstimate.do",produces="application/json; charset=utf-8")
		@ResponseBody
		public int writeEstimate(HttpSession session,HttpServletRequest request,Document document,@RequestParam MultipartFile[] files,@RequestParam List<String> signEmpList, @RequestParam List<String> refEmpList,@RequestParam List<String> estimateList,Model m ) {
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

			int result=service.insertEstimate(document,estimateList);
			
			
			
			ArrayList<DocumentSign> signs=service.selectSignList(documentCode);
			Alarm alarm = new Alarm();
			alarm.setAlarmComment(signs.get(0).getEmpName()+"님 결재할 차례입니다");
			alarm.setEmpCode(signs.get(0).getEmpCode());
			alarm.setRefUrl("/doc/selectOneEs.do");
			
			JSONObject json=new JSONObject();
			json.put("documentCode", documentCode);
			alarm.setUrlParam(json.toJSONString());
			
			int res=service.insertAlarm(alarm);
			if(result>0&&res>0) {
				emitter.sendEvent(signs.get(0).getEmpCode(), alarm.getAlarmComment());
			}
			
			ArrayList<DocumentReference>refs=service.selectRefList(documentCode);
			
			for(int i=0;i<refs.size();i++) {
				Alarm refAlarm=new Alarm();
				refAlarm.setAlarmComment("참조할 문서가 있습니다.");
				refAlarm.setEmpCode(refs.get(i).getEmpCode());
				refAlarm.setRefUrl("/doc/selectOneEs.do");
				JSONObject json2=new JSONObject();
				json2.put("documentCode", documentCode);
				refAlarm.setUrlParam(json2.toJSONString());
				 int res2=service.insertAlarm(refAlarm);
				if(res2>0&&result>0) {
					emitter.sendEvent(refs.get(i).getEmpCode(), refAlarm.getAlarmComment());
				}
				
				}
			
			return result;
		}
		
		//협조전작성
		@PostMapping(value="writeCooperate.do",produces="application/json; charset=utf-8")
		@ResponseBody
		public int writeCooperate(HttpSession session,HttpServletRequest request,Document document,@RequestParam MultipartFile[] files,@RequestParam List<String> signEmpList, @RequestParam List<String> refEmpList,@RequestParam List<String> cooperateList,Model m ) {
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

			int result=service.insertCooperate(document,cooperateList);
			
			
			
			ArrayList<DocumentSign> signs=service.selectSignList(documentCode);
			Alarm alarm = new Alarm();
			alarm.setAlarmComment(signs.get(0).getEmpName()+"님 결재할 차례입니다");
			alarm.setEmpCode(signs.get(0).getEmpCode());
			alarm.setRefUrl("/doc/selectOneSp.do");
			
			JSONObject json=new JSONObject();
			json.put("documentCode", documentCode);
			alarm.setUrlParam(json.toJSONString());
			
			int res=service.insertAlarm(alarm);
			if(result>0&&res>0) {
				emitter.sendEvent(signs.get(0).getEmpCode(), alarm.getAlarmComment());
			}
			
			ArrayList<DocumentReference>refs=service.selectRefList(documentCode);
			
			for(int i=0;i<refs.size();i++) {
				Alarm refAlarm=new Alarm();
				refAlarm.setAlarmComment("참조할 문서가 있습니다.");
				refAlarm.setEmpCode(refs.get(i).getEmpCode());
				refAlarm.setRefUrl("/doc/selectOneSp.do");
				JSONObject json2=new JSONObject();
				json2.put("documentCode", documentCode);
				refAlarm.setUrlParam(json2.toJSONString());
				 int res2=service.insertAlarm(refAlarm);
				if(res2>0&&result>0) {
					emitter.sendEvent(refs.get(i).getEmpCode(), refAlarm.getAlarmComment());
				}
				
				}
			
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

	
	//휴가신청서 불러오기
	@PostMapping("selectOneVa.do")
	public String SelectOneVacation(String documentCode, Model model) {
		Document doc=service.selectOneDoc(documentCode);
		ArrayList<DocumentSign>signList=service.selectSignList(documentCode);
		ArrayList<DocumentFile>fileList=service.selectOneDocFile(documentCode);
		doc.setFileList(fileList);
		model.addAttribute("signList",signList);
		model.addAttribute("doc",doc);
		model.addAttribute("documentCode", documentCode);
		
		DocumentSelectDay selDay=service.selectAnnual(documentCode);
		
		String signableEmp="";
		for(int i=0;i<signList.size();i++) {
			if(Integer.parseInt(signList.get(i).getSignYn())==0) {
				signableEmp=signList.get(i).getEmpCode();
				break;
			}else if(Integer.parseInt(signList.get(i).getSignYn())==-1) {
				break;
			}
		}
		model.addAttribute("signableEmp",signableEmp);
		
		String vacType;
		if(selDay!=null) {
			
			vacType="annual";
			model.addAttribute("vacType",vacType);
			try {
				SimpleDateFormat format = new SimpleDateFormat("yyyy년 M월 d일", Locale.KOREAN);
				Date writeDay=new SimpleDateFormat("yyyyMMdd").parse(doc.getDocumentDate());
				String writeDate=format.format(writeDay);
				doc.setDocumentDate(writeDate);
				Date startDay = new SimpleDateFormat("yyyyMMdd").parse(selDay.getStartDay());
				Date endDay = new SimpleDateFormat("yyyyMMdd").parse(selDay.getEndDay());
				String StartDay = format.format(startDay);
				String EndDay = format.format(endDay);
				model.addAttribute("endDay", EndDay);
				model.addAttribute("startDay",StartDay);
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
		
			
			
		}else {
			SimpleDateFormat format = new SimpleDateFormat("yyyy년 M월 d일", Locale.KOREAN);
			vacType="half";
			VacationHalf half=service.selectHalf(documentCode);
			
			model.addAttribute("vacType",vacType);
			
			try {
				Date vacDate = new SimpleDateFormat("yyyyMMdd").parse(half.getVacDate());
				String VacDate=format.format(vacDate);
				model.addAttribute("vacDate", VacDate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String time=half.getHalfTime();
			model.addAttribute("time",time);
			
		}
		return "document/viewVacation";
	}
	
	//지출결의서 불러오기
	@PostMapping("selectOneSp.do")
	public String SelectOneSpending(String documentCode, Model model) {
		Document doc=service.selectOneDoc(documentCode);
		
		ArrayList<Spending>spendingList= service.selectOneDocSpending(documentCode);
		
		ArrayList<DocumentFile>fileList=service.selectOneDocFile(documentCode);
		
		ArrayList<DocumentSign>signList=service.selectSignList(documentCode);
		String signableEmp="";
		for(int i=0;i<signList.size();i++) {
			if(Integer.parseInt(signList.get(i).getSignYn())==0) {
				signableEmp=signList.get(i).getEmpCode();
				break;//결재할 순서인 사람
			}else if(Integer.parseInt(signList.get(i).getSignYn())==-1) {
				break; //반려된 상황
			}
		}
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 M월 d일", Locale.KOREAN);
	        
			
			try {
				Date writeDay=new SimpleDateFormat("yyyyMMdd").parse(doc.getDocumentDate());
				
				String writeDate=format.format(writeDay);
				doc.setDocumentDate(writeDate);
				for (int i=0;i<spendingList.size();i++) {
					String spending = spendingList.get(i).getSpendingDay();
					Date spendingDay = new SimpleDateFormat("yyyyMMdd").parse(spending);
					String spendDay = format.format(spendingDay);
					spendingList.get(i).setSpendingDay(spendDay);
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
	
		}
			int total=0;
			for(int i=0;i<spendingList.size();i++) {
				total+=Integer.parseInt(spendingList.get(i).getSpendingCost());
			}
		doc.setFileList(fileList);
		model.addAttribute("documentCode",documentCode);
		model.addAttribute("signableEmp",signableEmp);
		model.addAttribute("doc",doc);
		model.addAttribute("signList", signList);
		model.addAttribute("spendingList",spendingList);
		model.addAttribute("total",total);
		//결재 정보 불러와야 함.
		
		return "document/viewSpending";
	}
	
	//출장보고서 불러오기
	@PostMapping("selectOneBt.do")
	public String SelectOneBusinessTrip(String documentCode,Model model) {
		Document doc=service.selectOneDoc(documentCode);
		ArrayList<DocumentSign>signList=service.selectSignList(documentCode);
		ArrayList<DocumentFile>fileList=service.selectOneDocFile(documentCode);
		Business business=service.selectOneBt(documentCode);
		String signableEmp="";
		for(int i=0;i<signList.size();i++) {
			if(Integer.parseInt(signList.get(i).getSignYn())==0) {
				signableEmp=signList.get(i).getEmpCode();
				break;//결재할 순서인 사람
			}else if(Integer.parseInt(signList.get(i).getSignYn())==-1) {
				break; //반려된 상황
			}
		}
		
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 M월 d일", Locale.KOREAN);
		
		try {
			Date writeDay=new SimpleDateFormat("yyyyMMdd").parse(doc.getDocumentDate());
			String writeDate=format.format(writeDay);
			doc.setDocumentDate(writeDate);
			Date startDay = new SimpleDateFormat("yyyyMMdd").parse(business.getBusinessStart());
			Date endDay = new SimpleDateFormat("yyyyMMdd").parse(business.getBusinessEnd());
			String start = format.format(startDay);
			String end = format.format(endDay);
			business.setBusinessStart(start);
			business.setBusinessEnd(end);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		doc.setFileList(fileList);
		model.addAttribute("signList",signList);
		model.addAttribute("documentCode",documentCode);
		model.addAttribute("signableEmp",signableEmp);
		model.addAttribute("doc",doc);
		model.addAttribute("business",business);
		
		
		return "document/viewBusiness";
	}
	
	//협조전 불러오기
	@PostMapping("selectOneCo.do")
	public String SelectOneCooperation(String documentCode,Model model) {
		Document doc=service.selectOneDoc(documentCode);
		ArrayList<DocumentSign>signList=service.selectSignList(documentCode);
		ArrayList<DocumentFile>fileList=service.selectOneDocFile(documentCode);
		ArrayList<Cooperate>coopList=service.selectCoopList(documentCode);
		String signableEmp="";
		for(int i=0;i<signList.size();i++) {
			if(Integer.parseInt(signList.get(i).getSignYn())==0) {
				signableEmp=signList.get(i).getEmpCode();
				break;//결재할 순서인 사람
			}else if(Integer.parseInt(signList.get(i).getSignYn())==-1) {
				break; //반려된 상황
			}
		}
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 M월 d일", Locale.KOREAN);
		
		try {
			Date writeDay=new SimpleDateFormat("yyyyMMdd").parse(doc.getDocumentDate());
			String writeDate=format.format(writeDay);
			doc.setDocumentDate(writeDate);
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("documentCode",documentCode);
		model.addAttribute("signableEmp",signableEmp);
		model.addAttribute("signList",signList);
		model.addAttribute("coopList",coopList);
		model.addAttribute("fileList",fileList);
		model.addAttribute("doc",doc);
		
		
		return "document/viewCooperate";
	}
	
	//견적서 불러오기
	@PostMapping("selectOneEs.do")
	public String SelectOneEstimate(String documentCode,Model model) {
	
		Document doc=service.selectOneDoc(documentCode);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 M월 d일", Locale.KOREAN);
		
		try {
			Date writeDay=new SimpleDateFormat("yyyyMMdd").parse(doc.getDocumentDate());
			String writeDate=format.format(writeDay);
			doc.setDocumentDate(writeDate);
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<DocumentSign>signList=service.selectSignList(documentCode);
		ArrayList<DocumentFile>fileList=service.selectOneDocFile(documentCode);
		String signableEmp="";
		for(int i=0;i<signList.size();i++) {
			if(Integer.parseInt(signList.get(i).getSignYn())==0) {
				signableEmp=signList.get(i).getEmpCode();
				break;//결재할 순서인 사람
			}else if(Integer.parseInt(signList.get(i).getSignYn())==-1) {
				break; //반려된 상황
			}
		}
		ArrayList<Estimate> estimateList=service.selectOneEstimateList(documentCode);
		int totalPrice=0;
		int workDay=estimateList.get(0).getWorkDays();
		for(int i=0;i<estimateList.size();i++) {
			int price=estimateList.get(i).getPrice();
			
			totalPrice+=price;
		}
		totalPrice=totalPrice*workDay;
		
		model.addAttribute("signList",signList);
		model.addAttribute("fileLsst",fileList);
		model.addAttribute("doc",doc);
		model.addAttribute("documentCode",documentCode);
		model.addAttribute("signableEmp",signableEmp);
		model.addAttribute("estimateList",estimateList);
		model.addAttribute("totalPrice",totalPrice);
		
		return "document/viewEstimate";
	}
	
//	프로젝트 관련 문서 불러오기 (태욱형님 기능에 따라 달라질 예정)
//	@PostMapping("selectOneVa.do")
//	public String SelectOneVacation(String documentCode) {
//		
//		return "";
//	}
	
	
	
	//결재하기(결재 최종여부시 문서마다 기능 추가중) sysout은 알람 기능으로 변경예정
	@PostMapping("approveDoc.do")
	@ResponseBody
	public int approveDoc(String check,String empCode,String documentCode, String type,String writer) {
		HashMap<String, String>map=new HashMap<String, String>();
		map.put("empCode", empCode);
		map.put("check",check );
		map.put("documentCode", documentCode);
		int result=service.approveDoc(map);
		
		//결재가 기각인가?
		if(result>0 &&Integer.parseInt(check)==-1) {
			Alarm alarm = new Alarm();
			alarm.setAlarmComment("요청하신 서류가 반려되었습니다");
			alarm.setEmpCode(writer);
			
			switch(type) {
			case("va"):{
				alarm.setRefUrl("/doc/selectOneVa.do");
				break;
			}
			
			case("co"):{
				alarm.setRefUrl("/doc/selectOneCo.do");			
				break;
			}
			
			case("es"):{
				alarm.setRefUrl("/doc/selectOneEs.do");
				break;
			}
			
			case("bt"):{
				alarm.setRefUrl("/doc/selectOneBt.do");
				break;
			}
			
			case("sp"):{
				alarm.setRefUrl("/doc/selectOneSp.do");
				break;
			}
			
			}
			
			JSONObject json=new JSONObject();
			json.put("documentCode", documentCode);
			alarm.setUrlParam(json.toJSONString());
			
			int res=service.insertAlarm(alarm);
			if(result>0) {
				emitter.sendEvent(writer, alarm.getAlarmComment());
			}
			
		}else {
		ArrayList<DocumentSign>signList=service.selectSignList(documentCode);
		
		int find=1;
		for(int i=0;i<signList.size();i++) {
			find=Integer.parseInt(signList.get(i).getSignYn());
			if(find==-1) {
				//이미 반려된 서류일 경우
				break;
			}else if(find==0) {
				//결재를 하지 않은 사람을 발견할 경우 해당 결재자에게 알림 송신
				
				Alarm alarm = new Alarm();
				alarm.setAlarmComment(signList.get(i).getEmpName()+"님 결재할 차례입니다");
				alarm.setEmpCode(signList.get(i).getEmpCode());
				
				switch(type) {
				case("va"):{
					alarm.setRefUrl("/doc/selectOneVa.do");
					break;
				}
				
				case("co"):{
					alarm.setRefUrl("/doc/selectOneCo.do");			
					break;
				}
				
				case("es"):{
					alarm.setRefUrl("/doc/selectOneEs.do");
					break;
				}
				
				case("bt"):{
					alarm.setRefUrl("/doc/selectOneBt.do");
					break;
				}
				
				case("sp"):{
					alarm.setRefUrl("/doc/selectOneSp.do");
					break;
				}
				
				}
				JSONObject json=new JSONObject();
				json.put("documentCode", documentCode);
				alarm.setUrlParam(json.toJSONString());
				
				int res=service.insertAlarm(alarm);
				if(result>0) {
					emitter.sendEvent(signList.get(i).getEmpCode(), alarm.getAlarmComment());
				}
				
				
			}
		}
		
		//최종승인인 경우
		if(find==1) {
			

			Alarm alarm = new Alarm();
			alarm.setAlarmComment("최종 승인되었습니다.");
			alarm.setEmpCode(writer);
			
			switch(type) {
			case("va"):{
				alarm.setRefUrl("/doc/selectOneVa.do");
				break;
			}
			
			case("co"):{
				alarm.setRefUrl("/doc/selectOneCo.do");			
				break;
			}
			
			case("es"):{
				alarm.setRefUrl("/doc/selectOneEs.do");
				break;
			}
			
			case("bt"):{
				alarm.setRefUrl("/doc/selectOneBt.do");
				break;
			}
			
			case("sp"):{
				alarm.setRefUrl("/doc/selectOneSp.do");
				break;
			}
			
			}
			JSONObject json=new JSONObject();
			json.put("documentCode", documentCode);
			alarm.setUrlParam(json.toJSONString());
			
			int res=service.insertAlarm(alarm);
			if(result>0) {
				emitter.sendEvent(writer, alarm.getAlarmComment());
			}
			
			
			//최종승인 시 각 문서에 따른 추가기능
			switch(type) {
			case "sp":{
				//최종승인시 지출내역 승인여부 전환
				int spChk=service.approveSpending(documentCode);
				break;
			}
			case "va":{
				//최종승인시 휴가 적용 및 출퇴근 비고 정리
				DocumentSelectDay selDay=service.selectAnnual(documentCode);
				if(selDay!=null) {
					//연차일 시 적용.
					
					try {
						Date startDay = new SimpleDateFormat("yyyyMMdd").parse(selDay.getStartDay());
						Date endDay = new SimpleDateFormat("yyyyMMdd").parse(selDay.getEndDay());
						
						long diffInMillies = endDay.getTime() - startDay.getTime();
						int days = (int) (diffInMillies / (1000 * 60 * 60 * 24))+1;
						
						HashMap<String, String>vacMap=new HashMap<String, String>();
						vacMap.put("writer", writer);
						vacMap.put("days",String.valueOf(days));
						
						int chk1=service.updateVac(vacMap);
						
						if(chk1>0) {
						int chk2=0;
						DateTimeFormatter formatter=DateTimeFormatter.ofPattern("yyyyMMdd");
						
						LocalDate startDate = LocalDate.parse(selDay.getStartDay(),formatter);
						LocalDate endDate = LocalDate.parse(selDay.getEndDay(),formatter);
						 ArrayList<Commute> vacList=new ArrayList<Commute>();
						    while (!startDate.isAfter(endDate)) {
						    	Commute comm= new Commute();
						    	comm.setAttDate(startDate.format(formatter));
						        comm.setCheckNote("연차");
						        comm.setEmpCode(writer);
						        vacList.add(comm);
						        startDate = startDate.plusDays(1); // 하루씩 추가
						    }
						    for(int i=0;i<vacList.size();i++) {
						    	Commute commute=vacList.get(i);
						    	//연차일시 잘 적용되는가?
						    	chk2+=service.insertAttVacation(commute);
						    }
						}
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
				}else {
					//반차일 시
					VacationHalf half=service.selectHalf(documentCode);
					Commute commute=new Commute();
					commute.setEmpCode(writer);
					commute.setAttDate(half.getVacDate());
					if(half.getHalfTime().equals("a")) {
							commute.setCheckNote("오전반차");
					}else {
						commute.setCheckNote("오후반차");
					}
					
					int insHalf=service.useHalf(writer);
					int insAttHalf=service.insertAttHalf(commute);
				}
				
				break;
			}
			
			case "bt":{
				
				Business business=service.selectOneBt(documentCode);
				
				int btChk=0;
				try {
					DateTimeFormatter formatter=DateTimeFormatter.ofPattern("yyyyMMdd");
					
					LocalDate startDate = LocalDate.parse(business.getBusinessStart(),formatter);
					LocalDate endDate = LocalDate.parse(business.getBusinessEnd(),formatter);
					ArrayList<Commute>btList=new ArrayList<Commute>();
					while(!startDate.isAfter(endDate)) {
						Commute comm=new Commute();
						comm.setAttDate(startDate.format(formatter));
						comm.setCheckNote("출장");
						comm.setEmpCode(writer);
						
						btList.add(comm);
						startDate = startDate.plusDays(1); 
					}
					
					for(int i=0;i<btList.size();i++) {
						Commute commute=btList.get(i);
						btChk+=service.insertAttBt(commute);
					}
					
					
				}catch(Exception e) {
					e.printStackTrace();
				}
				break;
			}
			
			case "es":{
				ArrayList<Estimate>estList=service.selectOneEstimateList(documentCode);
				Document doc=service.selectOneDoc(documentCode);
				
				
				
				try {
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
					Date documentDate = new SimpleDateFormat("yyyyMMdd").parse(doc.getDocumentDate());
					String writeDay = dateFormat.format(documentDate);
					String content=doc.getDocumentContent();
					long totalPrice=0;
					int date = estList.get(0).getWorkDays();
					for (int i = 0; i < estList.size(); i++) {
					    long price = estList.get(i).getPrice();
					   
					    totalPrice += price* date; // 각 행에서 date를 곱함
					   
					}
					
					HashMap<String, String> estimateMap=new HashMap<String, String>();
					map.put("documentCode", documentCode);
					map.put("salesDay", writeDay);
					map.put("salesCost", String.valueOf(totalPrice));
					map.put("salesContent", content);
					int esChk=service.insertSales(map);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				break;
			}
			
			
			}
		}
	}
		return result;
	}
	
	@GetMapping("fileDown.do")
	@ResponseBody
	public int downloadFile(HttpServletRequest request, HttpServletResponse response, String fileName, String filePath) {
	    String root = request.getSession().getServletContext().getRealPath("/resources/");
	    String target = "_";
	    int startIdx = filePath.indexOf(target) + 1;
	    String writedate = filePath.substring(startIdx, startIdx + 8);
	    String savePath = root + "/documentFiles/" + writedate + "/";

	    File file = new File(savePath + filePath);
	    if (!file.exists()) {
	        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	        return -1; // 파일이 없는 경우
	    }

	    try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
	         BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream())) {

	        

	        // 파일명 설정
	        String resFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
	        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", resFileName));

	        // 파일 데이터 전송
	        byte[] buffer = new byte[4096];
	        int bytesRead;
	        while ((bytesRead = bis.read(buffer)) != -1) {
	            bos.write(buffer, 0, bytesRead);
	        }

	    } catch (IOException e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        return -1;
	    }

	    return 1; // 성공
	}

	
	

}
