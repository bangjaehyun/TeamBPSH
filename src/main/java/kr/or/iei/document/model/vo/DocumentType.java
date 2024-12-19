package kr.or.iei.document.model.vo;

public class DocumentType {
	
	private String documentTypeCode;
	private String documentTypeName;
	
	
	public DocumentType(String documentTypeCode, String documentTypeName) {
		super();
		this.documentTypeCode = documentTypeCode;
		this.documentTypeName = documentTypeName;
	}


	public DocumentType() {
		super();
		
	}


	public String getDocumentTypeCode() {
		return documentTypeCode;
	}


	public void setDocumentTypeCode(String documentTypeCode) {
		this.documentTypeCode = documentTypeCode;
	}


	public String getDocumentTypeName() {
		return documentTypeName;
	}


	public void setDocumentTypeName(String documentTypeName) {
		this.documentTypeName = documentTypeName;
	}


	@Override
	public String toString() {
		return "DocumentType [documentTypeCode=" + documentTypeCode + ", documentTypeName=" + documentTypeName + "]";
	}
	
	
	
	

}
