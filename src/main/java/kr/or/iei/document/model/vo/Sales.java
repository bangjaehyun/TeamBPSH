package kr.or.iei.document.model.vo;

public class Sales {
	private String documnetCode;
	private String salesDay;
	private String salesCost;
	private String salesContent;
	private int approve;
	public Sales() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Sales(String documnetCode, String salesDay, String salesCost, String salesContent, int approve) {
		super();
		this.documnetCode = documnetCode;
		this.salesDay = salesDay;
		this.salesCost = salesCost;
		this.salesContent = salesContent;
		this.approve = approve;
	}
	public String getDocumnetCode() {
		return documnetCode;
	}
	public void setDocumnetCode(String documnetCode) {
		this.documnetCode = documnetCode;
	}
	public String getSalesDay() {
		return salesDay;
	}
	public void setSalesDay(String salesDay) {
		this.salesDay = salesDay;
	}
	public String getSalesCost() {
		return salesCost;
	}
	public void setSalesCost(String salesCost) {
		this.salesCost = salesCost;
	}
	public String getSalesContent() {
		return salesContent;
	}
	public void setSalesContent(String salesContent) {
		this.salesContent = salesContent;
	}
	public int getApprove() {
		return approve;
	}
	public void setApprove(int approve) {
		this.approve = approve;
	}
	@Override
	public String toString() {
		return "Sales [documnetCode=" + documnetCode + ", salesDay=" + salesDay + ", salesCost=" + salesCost
				+ ", salesContent=" + salesContent + ", approve=" + approve + "]";
	}

	

}
