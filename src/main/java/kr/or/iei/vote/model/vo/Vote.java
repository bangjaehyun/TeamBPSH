package kr.or.iei.vote.model.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class Vote {
	private String voteNo; // 투표번호
	private String empCode; // 작성자코드
	private String empName; // 작성자
	private String voteTitle; // 투표제목
	private String voteContent; // 투표내용
	private String voteStart;// 투표등록 일자
	private String voteEnd;// 투표마감 일자

	private ArrayList<VoteList> voteList; // 투표 리스트
	private String voteListNo; // 어디에 투표하였는지 null일 경우 투표하지 않았다
	private ArrayList<VoteEmpList> voteEmpList; // 투표한 사원 리스트

	public Vote() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Vote(String voteNo, String empCode, String empName, String voteTitle, String voteContent, String voteStart,
			String voteEnd, ArrayList<VoteList> voteList, String voteListNo, ArrayList<VoteEmpList> voteEmpList) {
		super();
		this.voteNo = voteNo;
		this.empCode = empCode;
		this.empName = empName;
		this.voteTitle = voteTitle;
		this.voteContent = voteContent;
		this.voteStart = voteStart;
		this.voteEnd = voteEnd;
		this.voteList = voteList;
		this.voteListNo = voteListNo;
		this.voteEmpList = voteEmpList;
	}

	public String getVoteNo() {
		return voteNo;
	}

	public void setVoteNo(String voteNo) {
		this.voteNo = voteNo;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getVoteTitle() {
		return voteTitle;
	}

	public void setVoteTitle(String voteTitle) {
		this.voteTitle = voteTitle;
	}

	public String getVoteContent() {
		return voteContent;
	}

	public void setVoteContent(String voteContent) {
		this.voteContent = voteContent;
	}

	public String getVoteStart() {
		return voteStart;
	}

	public void setVoteStart(String voteStart) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		
		try {
			Date date = sdf.parse(voteStart);
			
			this.voteStart = sdf.format(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getVoteEnd() {
		return voteEnd;
	}

	public void setVoteEnd(String voteEnd) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		try {
			Date date = sdf.parse(voteEnd);
			
			this.voteEnd = sdf.format(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<VoteList> getVoteList() {
		return voteList;
	}

	public void setVoteList(ArrayList<VoteList> voteList) {
		this.voteList = voteList;
	}

	public String getVoteListNo() {
		return voteListNo;
	}

	public void setVoteListNo(String voteListNo) {
		this.voteListNo = voteListNo;
	}

	public ArrayList<VoteEmpList> getVoteEmpList() {
		return voteEmpList;
	}

	public void setVoteEmpList(ArrayList<VoteEmpList> voteEmpList) {
		this.voteEmpList = voteEmpList;
	}

	@Override
	public String toString() {
		return "Vote [voteNo=" + voteNo + ", empCode=" + empCode + ", empName=" + empName + ", voteTitle=" + voteTitle
				+ ", voteContent=" + voteContent + ", voteStart=" + voteStart + ", voteEnd=" + voteEnd + ", voteList="
				+ voteList + ", voteListNo=" + voteListNo + ", voteEmpList=" + voteEmpList + "]";
	}

}
