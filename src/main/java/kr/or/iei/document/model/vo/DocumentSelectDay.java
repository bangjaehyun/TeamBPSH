package kr.or.iei.document.model.vo;

public class DocumentSelectDay {
	public String start;
	public String end;
	private String documentCode;
	public DocumentSelectDay() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DocumentSelectDay(String start, String end, String documentCode) {
		super();
		this.start = start;
		this.end = end;
		this.documentCode = documentCode;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getDocumentCode() {
		return documentCode;
	}
	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
	}
	@Override
	public String toString() {
		return "DocumentSelectDay [start=" + start + ", end=" + end + ", documentCode=" + documentCode + "]";
	}
	
	
	
	
}
