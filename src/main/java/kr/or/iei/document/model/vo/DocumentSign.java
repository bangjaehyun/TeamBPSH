package kr.or.iei.document.model.vo;

public class DocumentSign {
	private String documentCode;
	private String empCode;
	private String signYn;
	private String empRank;
	private String empName;
	private String documentSeq;
	public DocumentSign() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DocumentSign(String documentCode, String empCode, String signYn, String empRank, String empName,
			String documentSeq) {
		super();
		this.documentCode = documentCode;
		this.empCode = empCode;
		this.signYn = signYn;
		this.empRank = empRank;
		this.empName = empName;
		this.documentSeq = documentSeq;
	}
	public String getDocumentCode() {
		return documentCode;
	}
	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
	}
	public String getEmpCode() {
		return empCode;
	}
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}
	public String getSignYn() {
		return signYn;
	}
	public void setSignYn(String signYn) {
		this.signYn = signYn;
	}
	public String getEmpRank() {
		return empRank;
	}
	public void setEmpRank(String empRank) {
		this.empRank = empRank;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getDocumentSeq() {
		return documentSeq;
	}
	public void setDocumentSeq(String documentSeq) {
		this.documentSeq = documentSeq;
	}
	@Override
	public String toString() {
		return "DocumentSign [documentCode=" + documentCode + ", empCode=" + empCode + ", signYn=" + signYn
				+ ", empRank=" + empRank + ", empName=" + empName + ", documentSeq=" + documentSeq + "]";
	}
	
	
	
}
