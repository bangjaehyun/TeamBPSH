package kr.or.iei.document.model.vo;

public class Spending {
	private String spendingCode;
	private String spendingDay;
	private String documentCode;
	private int SpendingCost;
	private String spendingContent;
	public Spending() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Spending(String spendingCode, String spendingDay, String documentCode, int spendingCost,
			String spendingContent) {
		super();
		this.spendingCode = spendingCode;
		this.spendingDay = spendingDay;
		this.documentCode = documentCode;
		SpendingCost = spendingCost;
		this.spendingContent = spendingContent;
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
	public int getSpendingCost() {
		return SpendingCost;
	}
	public void setSpendingCost(int spendingCost) {
		SpendingCost = spendingCost;
	}
	public String getSpendingContent() {
		return spendingContent;
	}
	public void setSpendingContent(String spendingContent) {
		this.spendingContent = spendingContent;
	}
	@Override
	public String toString() {
		return "Spending [spendingCode=" + spendingCode + ", spendingDay=" + spendingDay + ", documentCode="
				+ documentCode + ", SpendingCost=" + SpendingCost + ", spendingContent=" + spendingContent + "]";
	}
	
	
	
}
