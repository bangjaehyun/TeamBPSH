package kr.or.iei.emp.model.vo;

public class DevelopPrice {
	private String teamCode;
	private String rankCode;
	private String price;
	private String teamName;
	private String rankName;

	public DevelopPrice() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DevelopPrice(String teamCode, String rankCode, String price, String teamName, String rankName) {
		super();
		this.teamCode = teamCode;
		this.rankCode = rankCode;
		this.price = price;
		this.teamName = teamName;
		this.rankName = rankName;
	}

	public String getTeamCode() {
		return teamCode;
	}

	public void setTeamCode(String teamCode) {
		this.teamCode = teamCode;
	}

	public String getRankCode() {
		return rankCode;
	}

	public void setRankCode(String rankCode) {
		this.rankCode = rankCode;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getTeamName() {
		return teamName;
	}

	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}

	public String getRankName() {
		return rankName;
	}

	public void setRankName(String rankName) {
		this.rankName = rankName;
	}

	@Override
	public String toString() {
		return "DevelopPrice [teamCode=" + teamCode + ", rankCode=" + rankCode + ", price=" + price + ", teamName="
				+ teamName + ", rankName=" + rankName + "]";
	}

}
