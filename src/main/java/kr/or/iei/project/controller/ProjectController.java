package kr.or.iei.project.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.project.model.service.ProjectService;
import kr.or.iei.project.model.vo.Comment;
import kr.or.iei.project.model.vo.Project;
import kr.or.iei.project.model.vo.ProjectPartemp;
import oracle.jdbc.proxy.annotation.Post;


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
	public String projectListPage(Model model) {
		ArrayList<Project> project = service.projectList();
		model.addAttribute("projectList",project);
		
		return "project/projectList";
	}
	
	@PostMapping("view.do")
	public String projectView(HttpSession session, Model model, String projectNo, String teamCode) {
		
		
		Project project = service.projectView(projectNo);
		List<Emp> addProjectEmp = service.addProjectEmp(teamCode, projectNo);
		ArrayList<ProjectPartemp> projectPartempList = service.projectEmpList(projectNo);
	    model.addAttribute("addProjectEmp", addProjectEmp);
		model.addAttribute("project", project);
		model.addAttribute("projectPartempList",projectPartempList);
	     
	    return "project/projectView";
	}

	
	@PostMapping("writeFrm.do")
	public String projectWriteFrm(Model model) {
		return "project/writeProject";
	}
	
	@PostMapping(value="write.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public String projectWrite(Project project,@RequestParam(name="teamCode") List<String> teamCode) {
		int result = service.projectWrite(project,teamCode);
		return String.valueOf(result);
	}
	
	@PostMapping(value="submitComment.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public boolean submitComment(HttpServletRequest request,
			String projectNo, //required = 값이 빈 값이면 null 을 반환
            String empCode,
            String commGb,
            String commContent,
            @RequestParam(value = "fileUpload", required = false) MultipartFile[] fileUpload)  {
		
		Comment comment = new Comment();
		comment.setProjectNo(projectNo);
		comment.setEmpCode(empCode);
		comment.setCommGb(commGb);
		comment.setCommContent(commContent);
		
		
		 if (fileUpload != null && fileUpload.length > 0) {
		        for (MultipartFile file : fileUpload) {
		            if (!file.isEmpty()) {  // 🚨 조건문 수정 (파일이 있을 경우만 실행)
		                String savePath = request.getSession().getServletContext().getRealPath("/resources/projectUpload");

		                // 디렉토리가 없으면 생성
		                File uploadDir = new File(savePath);
		                if (!uploadDir.exists()) {
		                    uploadDir.mkdirs();
		                }

		                // 파일명 가공
		                String originalFileName = file.getOriginalFilename();
		                String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
		                String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		                String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
		                int ranNum = new Random().nextInt(10000) + 1;
		                String newFileName = fileName + "_" + toDay + "_" + ranNum + extension;

		                // 저장될 파일 경로
		                String fullSavePath = savePath + File.separator + newFileName;
		                String relativePath = newFileName;  //DB에는 상대경로 저장
		                
		                // 파일 저장
		                try {
							file.transferTo(new File(fullSavePath));
							
							 // 파일 정보를 Comment 객체에 저장
		                    comment.setFileName(originalFileName);
		                    comment.setFilePath(relativePath);
						}  catch (IOException e) {
							e.printStackTrace();
							return false;
						}

		                   
		                
		            }
		        }
		    }
		
		 
		return service.addComment(comment);
	}
	
	@PostMapping(value="commList.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<Comment> getProjectComm(String projectNo){
		List<Comment> comments = service.commList(projectNo);
		
		return service.commList(projectNo);
	}
	
    @GetMapping(value="downloadFile.do", produces="application/octet-stream;")
    public void filedownload(HttpServletRequest request, HttpServletResponse response, String fileName, String filePath) {
		//System.out.println("NoticeController fileName : " + fileName);
		//System.out.println("NoticeController filePath : " + filePath);
		
		//파일 위치 절대 경로 : C드라이브 부터 해당 경로까지
		String savePath = request.getSession().getServletContext().getRealPath("/resources/projectUpload/");
		    
		//파일 다운로드를 위한 보조스트림 선언  ///프로그램 기준
		BufferedOutputStream bos = null;	//읽어들인 파일을 사용자에게 내보내기(다운로드) 위한 보조스트림
		BufferedInputStream bis = null;		//서버에서 파일을 읽어들이기 위한 보조스트림
		
		try {
			FileInputStream fis = new FileInputStream(savePath + filePath);
			
			//보조스트림과 주스트림 연결
			bis = new BufferedInputStream(fis);
			
			//파일을 내보내기 위한 스트림 생성
			ServletOutputStream sos = response.getOutputStream();
			
			//보조스트림과 주스트림 연결
			bos = new BufferedOutputStream(sos);
			
			//다운로드 파일명 설정  ///+사용자 환경을 고려해 바이트 단위로 쪼개서 UTF-8로 인코딩 후 다시 합침
			String resFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
			
			//브라우저에게 다운로드 지시 및 다운로드 파일명 지정
			response.setHeader("Content-Disposition", "attachment; filename="+resFileName);
			
			while(true) {
				int read = bis.read();	//바이트 단위로 파일 데이터 read
				if(read == -1) {	//읽을 데이터가 존재하지 않을 때 반복문 종료
					break;
				} else {
					bos.write(read);
				}
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				bos.close();
				bis.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
    
    @PostMapping("updateComment.do")
    @ResponseBody
    public Map<String, Boolean> updateComment(
            HttpServletRequest request,
            @RequestParam String commNo,
            @RequestParam String commContent,
            @RequestParam String deleteFile,
            @RequestParam String commGb, // comm_gb 값 추가
            @RequestParam(value = "newFile", required = false) MultipartFile newFile) {

        Map<String, Boolean> response = new HashMap<>();

        // 댓글 조회 (예외 처리)
        Comment comment = service.getCommentNo(commNo);
        if (comment == null) {
            response.put("success", false);
            return response;
        }
        
        
        
        comment.setCommContent(commContent);

     // 기존 파일 삭제 처리 (deleteFile 값이 "1"일 경우)
        if ("1".equals(deleteFile) && comment.getFilePath() != null) {
        	String realPath = request.getSession().getServletContext().getRealPath(comment.getFilePath());
        	File oldFile = new File(request.getSession().getServletContext().getRealPath(comment.getFilePath()));
            if (oldFile.exists()) {
                boolean deleted = oldFile.delete();
                if (!deleted) {
                    System.out.println("파일 삭제 실패: " + realPath);
                }
            } else {
                System.out.println("파일이 존재하지 않음: " + realPath);
            }
                
            comment.setFileName(null);
            comment.setFilePath(null);
            comment.setCommGb("0"); // 파일 삭제 시 comm_gb 값을 0으로 변경
            }
        

        //새로운 파일 업로드 처리
        if (newFile != null && !newFile.isEmpty()) {
            String savePath = request.getSession().getServletContext().getRealPath("/resources/projectUpload");
            File uploadDir = new File(savePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            String originalFileName = newFile.getOriginalFilename();
            String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
            int ranNum = new Random().nextInt(10000) + 1;
            String newFileName = fileName + "_" + toDay + "_" + ranNum + extension;
            
            String fullSavePath = savePath + File.separator + newFileName;
            
			
            try {
                newFile.transferTo(new File(fullSavePath));
                comment.setFileName(originalFileName);
                comment.setFilePath(newFileName);
                comment.setCommGb("1"); // 새로운 파일 추가 시 comm_gb = 1
            } catch (IOException e) {
                e.printStackTrace();
                response.put("success", false);
                return response;
            }
        }

        //기존 파일이 삭제되었고, 새 파일도 없는 경우 comm_gb = 0
        if (comment.getFilePath() == null) {
            comment.setCommGb("0");
        }

        boolean result = service.updateComment(comment);
        response.put("success", result);
        

        return response;
    }
    
    @PostMapping("deleteComment.do")
    @ResponseBody
    public Map<String, Boolean> deleteComment(@RequestParam String commNo, HttpServletRequest request) {
        Map<String, Boolean> response = new HashMap<>();
        Comment comment = service.getCommentNo(commNo);
        if (comment == null) {
            response.put("success", false);
            return response;
        }

        //기존 파일 삭제 처리 (첨부파일이 있을 경우)
        if (comment.getFilePath() != null && !comment.getFilePath().isEmpty()) {
            String realPath = request.getSession().getServletContext().getRealPath("/resources/projectUpload/"+comment.getFilePath());
            File file = new File(realPath);

            if (file.exists()) {
                boolean deleted = file.delete();
                System.out.println("파일 삭제 성공 여부: " + deleted);
            } else {
                System.out.println("파일이 존재하지 않음: " + realPath);
            }
        }


        boolean result = service.deleteComment(commNo);

        

        response.put("success", result);
        return response;
    }
    
    @PostMapping("addProjectPartemp.do")
    @ResponseBody
    public String addProjectEmp(String projectNo, String empCode, String partempContent) {
    	int result = service.addProjectPartemp(partempContent, projectNo, empCode);
    	
    	return String.valueOf(result);
    }
    
    @PostMapping("removeEmp.do")
    @ResponseBody
    public String removeEmp(String projectNo, String empCode) {
    	int result = service.removeEmp(projectNo, empCode);
    	return String.valueOf(result);
    }
}
    
		
	
	
	

	


