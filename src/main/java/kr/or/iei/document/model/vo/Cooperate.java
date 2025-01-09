package kr.or.iei.document.model.vo;

public class Cooperate {
	private String documentCode;
	private String teamCode;
	private String teamName;
	public Cooperate() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Cooperate(String documentCode, String teamCode, String teamName) {
		super();
		this.documentCode = documentCode;
		this.teamCode = teamCode;
		this.teamName = teamName;
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
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	@Override
	public String toString() {
		return "Cooperate [documentCode=" + documentCode + ", teamCode=" + teamCode + ", teamName=" + teamName + "]";
	}
	
	
	
}
