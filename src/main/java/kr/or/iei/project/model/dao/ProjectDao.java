package kr.or.iei.project.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.emp.model.vo.Team;
import kr.or.iei.project.model.vo.Comment;

import kr.or.iei.project.model.vo.Project;
import kr.or.iei.project.model.vo.ProjectPartemp;

@Repository("projectDao")
public class ProjectDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	//달력 프로젝트 List 불러오기
	public List<Project> getProjects(String teamCode) {
		return sqlSession.selectList("project.apiProjectList",teamCode);
		
	}

	public List<Project> projectList() {
		
		return sqlSession.selectList("project.projectList");
	}

	public Project projectView(String projectNo) {
		
		return sqlSession.selectOne("project.projectView", projectNo);
	}

	public List<ProjectPartemp> projectEmpList(String projectNo) {
		
		return sqlSession.selectList("project.projectPartempList", projectNo);
	}

	public String projectNo() {
		
		return sqlSession.selectOne("project.projectNo");
	}

	public int projectWrite(Project project) {
		
		return sqlSession.insert("project.projectWrite", project);
	}

	public int projectTeam(HashMap<String, Object> map) {
		
		return sqlSession.insert("project.insertTeam",map);
	}

	public String commentNo() {
		
		return sqlSession.selectOne("project.commentNo");
	}

	public int addComent(Comment comment) {
		
		return sqlSession.insert("project.insertComment",comment);
	}

	public List<Comment> commList(String projectNo) {
		
		return sqlSession.selectList("project.selectProjectComm",projectNo);
	}

	public Comment getCommentNo(String commNo) {
	        Comment comment = sqlSession.selectOne("project.selectCommNo", commNo);
	        return comment;
	    }


	public int updateComment(Comment comment) {
        int result = sqlSession.update("project.updateComment", comment);
        return result;
    }

	public int deleteComment(String commNo) {
		return sqlSession.delete("project.deleteComment",commNo);
	}

	public List<Team> projectTeamList(String projectNo) {
		
		return sqlSession.selectList("project.projectTeamList",projectNo);
	}

	public List<Emp> addProjectEmp(HashMap<String, Object> params) {
		
		return sqlSession.selectList("project.addProjectList",params);
	}

	public int addProjectPartemp(HashMap<String, Object> params) {
		
		return sqlSession.insert("project.addProjectPartemp", params);
	}

	public int removeEmp(HashMap<String, Object> params) {
		
		return sqlSession.delete("project.removeEmp", params);
	}

	public int teamLeader(HashMap<String, Object> params) {
		
		return sqlSession.selectOne("project.teamLeader",params);
	}
	



	
	

}
