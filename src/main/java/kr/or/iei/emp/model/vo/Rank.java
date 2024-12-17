package kr.or.iei.emp.model.vo;

public class Rank {
	private String rankCode;
	private String rankName;

	public Rank() {
		super();
	}

	public Rank(String rankCode, String rankName) {
		super();
		this.rankCode = rankCode;
		this.rankName = rankName;
	}

	public String getRankCode() {
		return rankCode;
	}

	public void setRankCode(String rankCode) {
		this.rankCode = rankCode;
	}

	public String getRankName() {
		return rankName;
	}

	public void setRankName(String rankName) {
		this.rankName = rankName;
	}

	@Override
	public String toString() {
		return "Rank [rankCode=" + rankCode + ", rankName=" + rankName + "]";
	}

}
