package kr.or.iei.project.model.vo;


public class Project {
	private String projectNo;
	private String documentTypeCode;
	private String projectTitle;
	private String projectContent;
	private String projectEnd;
	
	//종속 변수
	private String empCode;
	private String documentDate;
	
	
	public Project() {
		super();
	}


	public Project(String projectNo, String documentTypeCode, String projectTitle, String projectContent,
			String projectEnd, String empCode, String documentDate) {
		super();
		this.projectNo = projectNo;
		this.documentTypeCode = documentTypeCode;
		this.projectTitle = projectTitle;
		this.projectContent = projectContent;
		this.projectEnd = projectEnd;
		this.empCode = empCode;
		this.documentDate = documentDate;
	}


	public String getProjectNo() {
		return projectNo;
	}


	public void setProjectNo(String projectNo) {
		this.projectNo = projectNo;
	}


	public String getDocumentTypeCode() {
		return documentTypeCode;
	}


	public void setDocumentTypeCode(String documentTypeCode) {
		this.documentTypeCode = documentTypeCode;
	}


	public String getProjectTitle() {
		return projectTitle;
	}


	public void setProjectTitle(String projectTitle) {
		this.projectTitle = projectTitle;
	}


	public String getProjectContent() {
		return projectContent;
	}


	public void setProjectContent(String projectContent) {
		this.projectContent = projectContent;
	}


	public String getProjectEnd() {
		return projectEnd;
	}


	public void setProjectEnd(String projectEnd) {
		this.projectEnd = projectEnd;
	}


	public String getEmpCode() {
		return empCode;
	}


	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}


	public String getDocumentDate() {
		return documentDate;
	}


	public void setDocumentDate(String documentDate) {
		this.documentDate = documentDate;
	}


	@Override
	public String toString() {
		return "Project [projectNo=" + projectNo + ", documentTypeCode=" + documentTypeCode + ", projectTitle="
				+ projectTitle + ", projectContent=" + projectContent + ", projectEnd=" + projectEnd + ", empCode="
				+ empCode + ", documentDate=" + documentDate + "]";
	}

	
	
	
}
