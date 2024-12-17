package kr.or.iei.project.model.vo;

public class Project {
	private String projectNo;
	private String documentTypeCode;
	private String projectTitle;
	private String projectContent;
	private String projectEnd;
	
	
	
	public Project() {
		super();
	}

	public Project(String projectNo, String documentTypeCode, String projectTitle, String projectContent,
			String projectEnd) {
		super();
		this.projectNo = projectNo;
		this.documentTypeCode = documentTypeCode;
		this.projectTitle = projectTitle;
		this.projectContent = projectContent;
		this.projectEnd = projectEnd;
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

	@Override
	public String toString() {
		return "Project [projectNo=" + projectNo + ", documentTypeCode=" + documentTypeCode + ", projectTitle="
				+ projectTitle + ", projectContent=" + projectContent + ", projectEnd=" + projectEnd + "]";
	}
	
	
}
