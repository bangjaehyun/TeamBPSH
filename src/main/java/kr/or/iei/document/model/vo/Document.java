package kr.or.iei.document.model.vo;

import java.util.ArrayList;

public class Document {
	private String documentCode;
	private String documentTypeCode;
	private String empCode;
	private String empName;
	private String documentTitle;
	private String documentContent;
	private String documentDate;
	private String documentTypeName;
	
	//결재 비교해 상태 나타내는 변수
	private String progress;
	
	private ArrayList<DocumentFile>fileList;
	//결재자
	private ArrayList<DocumentSign>signList;
	//참조자
	private ArrayList<DocumentReference>refList;
	
	
	
	public Document() {
		super();
		
	}



	public Document(String documentCode, String documentTypeCode, String empCode, String empName, String documentTitle,
			String documentContent, String documentDate, String documentTypeName, String progress,
			ArrayList<DocumentFile> fileList, ArrayList<DocumentSign> signList, ArrayList<DocumentReference> refList) {
		super();
		this.documentCode = documentCode;
		this.documentTypeCode = documentTypeCode;
		this.empCode = empCode;
		this.empName = empName;
		this.documentTitle = documentTitle;
		this.documentContent = documentContent;
		this.documentDate = documentDate;
		this.documentTypeName = documentTypeName;
		this.progress = progress;
		this.fileList = fileList;
		this.signList = signList;
		this.refList = refList;
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



	public String getEmpName() {
		return empName;
	}



	public void setEmpName(String empName) {
		this.empName = empName;
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



	public String getDocumentTypeName() {
		return documentTypeName;
	}



	public void setDocumentTypeName(String documentTypeName) {
		this.documentTypeName = documentTypeName;
	}



	public String getProgress() {
		return progress;
	}



	public void setProgress(String progress) {
		this.progress = progress;
	}



	public ArrayList<DocumentFile> getFileList() {
		return fileList;
	}



	public void setFileList(ArrayList<DocumentFile> fileList) {
		this.fileList = fileList;
	}



	public ArrayList<DocumentSign> getSignList() {
		return signList;
	}



	public void setSignList(ArrayList<DocumentSign> signList) {
		this.signList = signList;
	}



	public ArrayList<DocumentReference> getRefList() {
		return refList;
	}



	public void setRefList(ArrayList<DocumentReference> refList) {
		this.refList = refList;
	}



	@Override
	public String toString() {
		return "Document [documentCode=" + documentCode + ", documentTypeCode=" + documentTypeCode + ", empCode="
				+ empCode + ", empName=" + empName + ", documentTitle=" + documentTitle + ", documentContent="
				+ documentContent + ", documentDate=" + documentDate + ", documentTypeName=" + documentTypeName
				+ ", progress=" + progress + ", fileList=" + fileList + ", signList=" + signList + ", refList="
				+ refList + "]";
	}
	
	

	
	
	
}
