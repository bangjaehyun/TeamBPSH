package kr.or.iei.document.model.vo;

import kr.or.iei.emp.model.vo.DevelopPrice;

public class Estimate {
	private String estEntity;
	
	private int workDays;
	private int people;
	private String documentCode;
	private String teamCode;
	private String rankCode;
	private int price;
	private String teamName;
	private String rankName;
	public Estimate() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Estimate(String estEntity, int workDays, int people, String documentCode, String teamCode, String rankCode,
			int price, String teamName, String rankName) {
		super();
		this.estEntity = estEntity;
		this.workDays = workDays;
		this.people = people;
		this.documentCode = documentCode;
		this.teamCode = teamCode;
		this.rankCode = rankCode;
		this.price = price;
		this.teamName = teamName;
		this.rankName = rankName;
	}
	public String getEstEntity() {
		return estEntity;
	}
	public void setEstEntity(String estEntity) {
		this.estEntity = estEntity;
	}
	public int getWorkDays() {
		return workDays;
	}
	public void setWorkDays(int workDays) {
		this.workDays = workDays;
	}
	public int getPeople() {
		return people;
	}
	public void setPeople(int people) {
		this.people = people;
	}
	public String getDocumentCode() {
		return documentCode;
	}
	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
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
		return "Estimate [estEntity=" + estEntity + ", workDays=" + workDays + ", people=" + people + ", documentCode="
				+ documentCode + ", teamCode=" + teamCode + ", rankCode=" + rankCode + ", price=" + price
				+ ", teamName=" + teamName + ", rankName=" + rankName + "]";
	}
	
	
}
