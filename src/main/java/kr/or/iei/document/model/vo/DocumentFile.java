package kr.or.iei.document.model.vo;

public class DocumentFile {
	private String fileNo;
	private String documentCode;
	private String fileName;
	private String filePath;
	public DocumentFile() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DocumentFile(String fileNo, String documentCode, String fileName, String filePath) {
		super();
		this.fileNo = fileNo;
		this.documentCode = documentCode;
		this.fileName = fileName;
		this.filePath = filePath;
	}
	public String getFileNo() {
		return fileNo;
	}
	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}
	public String getDocumentCode() {
		return documentCode;
	}
	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
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
	@Override
	public String toString() {
		return "DocumentFile [fileNo=" + fileNo + ", documentCode=" + documentCode + ", fileName=" + fileName
				+ ", filePath=" + filePath + "]";
	}
	
	
	
	
}
