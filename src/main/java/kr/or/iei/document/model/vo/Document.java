package kr.or.iei.document.model.vo;

public class Document {
	private String documentCode;
	private String documentTypeCode;
	private String empCode;
	private String documentTitle;
	private String documentContent;
	private String documentDate;
	
	public Document() {
		super();
		
	}

	public Document(String documentCode, String documentTypeCode, String empCode, String documentTitle,
			String documentContent, String documentDate) {
		super();
		this.documentCode = documentCode;
		this.documentTypeCode = documentTypeCode;
		this.empCode = empCode;
		this.documentTitle = documentTitle;
		this.documentContent = documentContent;
		this.documentDate = documentDate;
	}

	public String getDocumentCode() {
		return documentCode;
	}

	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
	}

	public String getDocumentTypeCode() {
		return documentTypeCode;
	}

	public void setDocumentTypeCode(String documentTypeCode) {
		this.documentTypeCode = documentTypeCode;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getDocumentTitle() {
		return documentTitle;
	}

	public void setDocumentTitle(String documentTitle) {
		this.documentTitle = documentTitle;
	}

	public String getDocumentContent() {
		return documentContent;
	}

	public void setDocumentContent(String documentContent) {
		this.documentContent = documentContent;
	}

	public String getDocumentDate() {
		return documentDate;
	}

	public void setDocumentDate(String documentDate) {
		this.documentDate = documentDate;
	}

	@Override
	public String toString() {
		return "Document [documentCode=" + documentCode + ", documentTypeCode=" + documentTypeCode + ", empCode="
				+ empCode + ", documentTitle=" + documentTitle + ", documentContent=" + documentContent
				+ ", documentDate=" + documentDate + "]";
	}
	
	
}
