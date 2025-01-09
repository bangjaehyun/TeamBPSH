package kr.or.iei.document.model.vo;

public class Spending {
	private String spendingCode;
	private String spendingDay;
	private String documentCode;
	private String spendingCost;
	private String spendingContent;
	private int approve;
	public Spending() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Spending(String spendingCode, String spendingDay, String documentCode, String spendingCost,
			String spendingContent, int approve) {
		super();
		this.spendingCode = spendingCode;
		this.spendingDay = spendingDay;
		this.documentCode = documentCode;
		this.spendingCost = spendingCost;
		this.spendingContent = spendingContent;
		this.approve = approve;
	}
	public String getSpendingCode() {
		return spendingCode;
	}
	public void setSpendingCode(String spendingCode) {
		this.spendingCode = spendingCode;
	}
	public String getSpendingDay() {
		return spendingDay;
	}
	public void setSpendingDay(String spendingDay) {
		this.spendingDay = spendingDay;
	}
	public String getDocumentCode() {
		return documentCode;
	}
	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
	}
	public String getSpendingCost() {
		return spendingCost;
	}
	public void setSpendingCost(String spendingCost) {
		this.spendingCost = spendingCost;
	}
	public String getSpendingContent() {
		return spendingContent;
	}
	public void setSpendingContent(String spendingContent) {
		this.spendingContent = spendingContent;
	}
	public int getApprove() {
		return approve;
	}
	public void setApprove(int approve) {
		this.approve = approve;
	}
	@Override
	public String toString() {
		return "Spending [spendingCode=" + spendingCode + ", spendingDay=" + spendingDay + ", documentCode="
				+ documentCode + ", spendingCost=" + spendingCost + ", spendingContent=" + spendingContent
				+ ", approve=" + approve + "]";
	}

	


}
