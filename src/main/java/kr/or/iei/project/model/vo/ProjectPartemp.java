package kr.or.iei.project.model.vo;

public class ProjectPartemp {
	
	private String partempNo;
	private String projectNo;
	private String empCode;
	private String partempContent;
	private String rankName;
	//종속 변수 추가
	private String teamCode;
	private String rankCode;
	private String empName;
	
	public ProjectPartemp() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProjectPartemp(String partempNo, String projectNo, String empCode, String partempContent, String rankName,
			String teamCode, String rankCode, String empName) {
		super();
		this.partempNo = partempNo;
		this.projectNo = projectNo;
		this.empCode = empCode;
		this.partempContent = partempContent;
		this.rankName = rankName;
		this.teamCode = teamCode;
		this.rankCode = rankCode;
		this.empName = empName;
	}

	public String getPartempNo() {
		return partempNo;
	}

	public void setPartempNo(String partempNo) {
		this.partempNo = partempNo;
	}

	public String getProjectNo() {
		return projectNo;
	}

	public void setProjectNo(String projectNo) {
		this.projectNo = projectNo;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getPartempContent() {
		return partempContent;
	}

	public void setPartempContent(String partempContent) {
		this.partempContent = partempContent;
	}

	public String getRankName() {
		return rankName;
	}

	public void setRankName(String rankName) {
		this.rankName = rankName;
	}

	public String getTeamCode() {
		return teamCode;
	}

	public void setTeamCode(String teamCode) {
		this.teamCode = teamCode;
	}

	public String getRankCode() {
		return rankCode;
	}

	public void setRankCode(String rankCode) {
		this.rankCode = rankCode;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	@Override
	public String toString() {
		return "ProjectPartemp [partempNo=" + partempNo + ", projectNo=" + projectNo + ", empCode=" + empCode
				+ ", partempContent=" + partempContent + ", rankName=" + rankName + ", teamCode=" + teamCode
				+ ", rankCode=" + rankCode + ", empName=" + empName + "]";
	}

	
	

}
