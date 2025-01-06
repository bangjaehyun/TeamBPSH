package kr.or.iei.document.model.vo;

public class DocumentSelectDay {
	public String startDay;
	public String endDay;
	private String documentCode;
	public DocumentSelectDay() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DocumentSelectDay(String startDay, String endDay, String documentCode) {
		super();
		this.startDay = startDay;
		this.endDay = endDay;
		this.documentCode = documentCode;
	}
	public String getStartDay() {
		return startDay;
	}
	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}
	public String getEndDay() {
		return endDay;
	}
	public void setEndDay(String endDay) {
		this.endDay = endDay;
	}
	public String getDocumentCode() {
		return documentCode;
	}
	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
	}
	@Override
	public String toString() {
		return "DocumentSelectDay [startDay=" + startDay + ", endDay=" + endDay + ", documentCode=" + documentCode
				+ "]";
	}
	
	
	
	
	
}
