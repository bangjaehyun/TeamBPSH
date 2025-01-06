package kr.or.iei.vote.model.vo;

public class VoteList {
	private String voteListNo;
	private String voteNo;
	private String voteName;
	private int voteCount;
	private String empCode; // 투표 하였을 경우 누가 하였는지

	public VoteList() {
		super();
		// TODO Auto-generated constructor stub
	}

	public VoteList(String voteListNo, String voteNo, String voteName, int voteCount, String empCode) {
		super();
		this.voteListNo = voteListNo;
		this.voteNo = voteNo;
		this.voteName = voteName;
		this.voteCount = voteCount;
		this.empCode = empCode;
	}

	public String getVoteListNo() {
		return voteListNo;
	}

	public void setVoteListNo(String voteListNo) {
		this.voteListNo = voteListNo;
	}

	public String getVoteNo() {
		return voteNo;
	}

	public void setVoteNo(String voteNo) {
		this.voteNo = voteNo;
	}

	public String getVoteName() {
		return voteName;
	}

	public void setVoteName(String voteName) {
		this.voteName = voteName;
	}

	public int getVoteCount() {
		return voteCount;
	}

	public void setVoteCount(int voteCount) {
		this.voteCount = voteCount;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	@Override
	public String toString() {
		return "VoteList [voteListNo=" + voteListNo + ", voteNo=" + voteNo + ", voteName=" + voteName + ", voteCount="
				+ voteCount + ", empCode=" + empCode + "]";
	}

}
