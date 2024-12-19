package kr.or.iei.document.model.vo;

public class DocumentReference {
	private String documentCode;
	private String empCode;
	public DocumentReference() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DocumentReference(String documentCode, String empCode) {
		super();
		this.documentCode = documentCode;
		this.empCode = empCode;
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
	@Override
	public String toString() {
		return "DocumentReference [documentCode=" + documentCode + ", empCode=" + empCode + "]";
	}
	
	
}
