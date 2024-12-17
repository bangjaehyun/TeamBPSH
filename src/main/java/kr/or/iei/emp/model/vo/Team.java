package kr.or.iei.emp.model.vo;

public class Team {
	private String teamCode;
	private String deptCode;
	private String teamName;

	public Team() {
		super();
	}

	public Team(String teamCode, String deptCode, String teamName) {
		super();
		this.teamCode = teamCode;
		this.deptCode = deptCode;
		this.teamName = teamName;
	}

	public String getTeamCode() {
		return teamCode;
	}

	public void setTeamCode(String teamCode) {
		this.teamCode = teamCode;
	}

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	@Override
	public String toString() {
		return "Team [teamCode=" + teamCode + ", deptCode=" + deptCode + ", teamName=" + teamName + "]";
	}

}
