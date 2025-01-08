package kr.or.iei.project.model.vo;

public class ProjectTeam {
	
	private String projectNo;
	private String teamCode;
	
	public ProjectTeam() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ProjectTeam(String projectNo, String teamCode) {
		super();
		this.projectNo = projectNo;
		this.teamCode = teamCode;
	}

	public String getProjectNo() {
		return projectNo;
	}

	public void setProjectNo(String projectNo) {
		this.projectNo = projectNo;
	}

	public String getTeamCode() {
		return teamCode;
	}

	public void setTeamCode(String teamCode) {
		this.teamCode = teamCode;
	}

	@Override
	public String toString() {
		return "ProjectTeam [projectNo=" + projectNo + ", teamCode=" + teamCode + "]";
	}
	
	
}
