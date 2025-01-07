package kr.or.iei.vote.model.vo;

import java.util.ArrayList;

public class VotePaging {
	private String totalCount;
	private String startCount;
	private String endCount;
	private ArrayList<Vote> voteList;

	public VotePaging() {
		super();
		// TODO Auto-generated constructor stub
	}

	public VotePaging(String totalCount, String startCount, String endCount, ArrayList<Vote> voteList) {
		super();
		this.totalCount = totalCount;
		this.startCount = startCount;
		this.endCount = endCount;
		this.voteList = voteList;
	}

	public String getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}

	public String getStartCount() {
		return startCount;
	}

	public void setStartCount(String startCount) {
		this.startCount = startCount;
	}

	public String getEndCount() {
		return endCount;
	}

	public void setEndCount(String endCount) {
		this.endCount = endCount;
	}

	public ArrayList<Vote> getVoteList() {
		return voteList;
	}

	public void setVoteList(ArrayList<Vote> voteList) {
		this.voteList = voteList;
	}

	@Override
	public String toString() {
		return "VotePaging [totalCount=" + totalCount + ", startCount=" + startCount + ", endCount=" + endCount
				+ ", voteList=" + voteList + "]";
	}

}
