package kr.or.iei.vote.model.vo;

public class VoteEmpList {
	private String voteListNo;
	private String empName;

	public VoteEmpList() {
		super();
		// TODO Auto-generated constructor stub
	}

	public VoteEmpList(String voteListNo, String empName) {
		super();
		this.voteListNo = voteListNo;
		this.empName = empName;
	}

	public String getVoteListNo() {
		return voteListNo;
	}

	public void setVoteListNo(String voteListNo) {
		this.voteListNo = voteListNo;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	@Override
	public String toString() {
		return "VoteEmpList [voteListNo=" + voteListNo + ", empName=" + empName + "]";
	}

}
