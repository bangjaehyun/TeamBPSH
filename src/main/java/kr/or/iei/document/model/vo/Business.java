package kr.or.iei.document.model.vo;

public class Business {

	private String documentCode;
	private String businessTo;
	private String businessPurpose;
	private String businessStart;
	private String businessEnd;
	public Business(String documentCode, String businessTo, String businessPurpose, String businessStart,
			String businessEnd) {
		super();
		this.documentCode = documentCode;
		this.businessTo = businessTo;
		this.businessPurpose = businessPurpose;
		this.businessStart = businessStart;
		this.businessEnd = businessEnd;
	}
	public Business() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getDocumentCode() {
		return documentCode;
	}
	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
	}
	public String getBusinessTo() {
		return businessTo;
	}
	public void setBusinessTo(String businessTo) {
		this.businessTo = businessTo;
	}
	public String getbusinessPurpose() {
		return businessPurpose;
	}
	public void setbusinessPurpose(String businessPurpose) {
		this.businessPurpose = businessPurpose;
	}
	public String getBusinessStart() {
		return businessStart;
	}
	public void setBusinessStart(String businessStart) {
		this.businessStart = businessStart;
	}
	public String getBusinessEnd() {
		return businessEnd;
	}
	public void setBusinessEnd(String businessEnd) {
		this.businessEnd = businessEnd;
	}
	@Override
	public String toString() {
		return "Business [documentCode=" + documentCode + ", businessTo=" + businessTo + ", businessPurpose="
				+ businessPurpose + ", businessStart=" + businessStart + ", businessEnd=" + businessEnd + "]";
	}
	
	
}
