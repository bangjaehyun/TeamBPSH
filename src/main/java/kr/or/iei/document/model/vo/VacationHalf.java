package kr.or.iei.document.model.vo;

public class VacationHalf {
	private boolean half;
	private String halfTime;
	private String vacDate;
	private String documentCode;
	public VacationHalf() {
		super();
		// TODO Auto-generated constructor stub
	}
	public VacationHalf(boolean half, String halfTime, String vacDate, String documentCode) {
		super();
		this.half = half;
		this.halfTime = halfTime;
		this.vacDate = vacDate;
		this.documentCode = documentCode;
	}
	public boolean isHalf() {
		return half;
	}
	public void setHalf(boolean half) {
		this.half = half;
	}
	public String getHalfTime() {
		return halfTime;
	}
	public void setHalfTime(String halfTime) {
		this.halfTime = halfTime;
	}
	public String getVacDate() {
		return vacDate;
	}
	public void setVacDate(String vacDate) {
		this.vacDate = vacDate;
	}
	public String getDocumentCode() {
		return documentCode;
	}
	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
	}
	@Override
	public String toString() {
		return "VacationHalf [half=" + half + ", halfTime=" + halfTime + ", vacDate=" + vacDate + ", documentCode="
				+ documentCode + "]";
	}
	
	
	
}
