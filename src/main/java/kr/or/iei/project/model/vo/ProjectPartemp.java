package kr.or.iei.project.model.vo;

public class ProjectPartemp {
	
	private String partempNo;
	private String projectNo;
	private String empCode;
	private String partempContent;
	
	public ProjectPartemp() {
		super();
	}

	public ProjectPartemp(String partempNo, String projectNo, String empCode, String partempContent) {
		super();
		this.partempNo = partempNo;
		this.projectNo = projectNo;
		this.empCode = empCode;
		this.partempContent = partempContent;
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

	@Override
	public String toString() {
		return "ProjectPartEmp [partempNo=" + partempNo + ", projectNo=" + projectNo + ", empCode=" + empCode
				+ ", partempContent=" + partempContent + "]";
	}
	
	
	
	

}
