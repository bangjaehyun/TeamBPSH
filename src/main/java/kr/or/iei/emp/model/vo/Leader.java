package kr.or.iei.emp.model.vo;

import java.util.ArrayList;

public class Leader {
	private ArrayList<Emp> leaderList;
	private ArrayList<Emp> empList;

	public Leader() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Leader(ArrayList<Emp> leaderList, ArrayList<Emp> empList) {
		super();
		this.leaderList = leaderList;
		this.empList = empList;
	}

	public ArrayList<Emp> getLeaderList() {
		return leaderList;
	}

	public void setLeaderList(ArrayList<Emp> leaderList) {
		this.leaderList = leaderList;
	}

	public ArrayList<Emp> getEmpList() {
		return empList;
	}

	public void setEmpList(ArrayList<Emp> empList) {
		this.empList = empList;
	}

	@Override
	public String toString() {
		return "DeptLeader [leaderList=" + leaderList + ", empList=" + empList + "]";
	}

}
