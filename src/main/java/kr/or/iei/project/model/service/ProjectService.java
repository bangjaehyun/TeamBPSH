package kr.or.iei.project.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.project.model.dao.ProjectDao;
import kr.or.iei.project.model.vo.Comment;
import kr.or.iei.project.model.vo.Project;


@Service("projectService")
public class ProjectService {
	
	@Autowired
	@Qualifier("projectDao")
	private ProjectDao dao;

	//달력 프로젝트 List 불러오기
	public ArrayList<Project> getProjects(String teamCode) {
		
		return (ArrayList<Project>)dao.getProjects(teamCode);
	}

	public ArrayList<Project> projectList() {
		
		return  (ArrayList<Project>)dao.projectList();
	}

	public Project projectView(String projectNo) {
		
		return dao.projectView(projectNo);
	}

	public List<Emp> projectEmpList(String projectNo) {
		return  dao.projectEmpList(projectNo);
	}
	
	@Transactional
	public int projectWrite(Project project, List<String> teamCode) {
		String projectNo = dao.projectNo();
		project.setProjectNo(projectNo);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("projectNo", projectNo);
		map.put("teamCode", teamCode);
		
		
		int result = dao.projectWrite(project);
		if(result > 0) {
			result =  dao.projectTeam(map);
		}
		 
		return result;
	}
	@Transactional
	public boolean addComment(Comment comment) {
		String commentNo = dao.commentNo();
		comment.setCommNo(commentNo);
		int result = dao.addComent(comment);
		
		return result > 0;
	}

	public List<Comment> commList(String projectNo) {
		
		return dao.commList(projectNo);
	}

	public Comment getCommentNo(String commNo) {
	        Comment comment = dao.getCommentNo(commNo);
	        if (comment == null) {
	            System.out.println("🚨 getCommentNo 실패: commNo(" + commNo + ")에 해당하는 데이터 없음.");
	        } else {
	            System.out.println("✅ getCommentNo 성공: " + comment.getCommContent());
	        }
	        return comment;
	    }
	@Transactional
    public boolean updateComment(Comment comment) {
        int updatedRows = dao.updateComment(comment);
        System.out.println("✅ updateComment 결과: " + updatedRows + " 개 행이 업데이트됨.");
        return updatedRows > 0;
    }

}
