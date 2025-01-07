package kr.or.iei.project.model.vo;

public class Comment {
	private String commNo;
	private String projectNo;
	private String empCode;
	private String commGb;
	private String commContent;
	private String fileName;
	private String filePath;
	private String commDate;
	
	private String empName;
	private String rankName;
	private String teamName;
	
	public Comment() {
		super();
	
	}

	public Comment(String commNo, String projectNo, String empCode, String commGb, String commContent, String fileName,
			String filePath, String commDate, String empName, String rankName, String teamName) {
		super();
		this.commNo = commNo;
		this.projectNo = projectNo;
		this.empCode = empCode;
		this.commGb = commGb;
		this.commContent = commContent;
		this.fileName = fileName;
		this.filePath = filePath;
		this.commDate = commDate;
		this.empName = empName;
		this.rankName = rankName;
		this.teamName = teamName;
	}

	public String getCommNo() {
		return commNo;
	}

	public void setCommNo(String commNo) {
		this.commNo = commNo;
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

	public String getCommGb() {
		return commGb;
	}

	public void setCommGb(String commGb) {
		this.commGb = commGb;
	}

	public String getCommContent() {
		return commContent;
	}

	public void setCommContent(String commContent) {
		this.commContent = commContent;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getCommDate() {
		return commDate;
	}

	public void setCommDate(String commDate) {
		this.commDate = commDate;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getRankName() {
		return rankName;
	}

	public void setRankName(String rankName) {
		this.rankName = rankName;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	@Override
	public String toString() {
		return "Comment [commNo=" + commNo + ", projectNo=" + projectNo + ", empCode=" + empCode + ", commGb=" + commGb
				+ ", commContent=" + commContent + ", fileName=" + fileName + ", filePath=" + filePath + ", commDate="
				+ commDate + ", empName=" + empName + ", rankName=" + rankName + ", teamName=" + teamName + "]";
	}

	

	
	
	
}
