package kr.or.iei.emp.model.vo;

import java.util.ArrayList;

public class AlarmPaging {
	private String empCode;
	private int totalCount;
	private int startCount;
	private int endCount;
	private ArrayList<Alarm> alarmList;

	public AlarmPaging() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AlarmPaging(String empCode, int totalCount, int startCount, int endCount, ArrayList<Alarm> alarmList) {
		super();
		this.empCode = empCode;
		this.totalCount = totalCount;
		this.startCount = startCount;
		this.endCount = endCount;
		this.alarmList = alarmList;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getStartCount() {
		return startCount;
	}

	public void setStartCount(int startCount) {
		this.startCount = startCount;
	}

	public int getEndCount() {
		return endCount;
	}

	public void setEndCount(int endCount) {
		this.endCount = endCount;
	}

	public ArrayList<Alarm> getAlarmList() {
		return alarmList;
	}

	public void setAlarmList(ArrayList<Alarm> alarmList) {
		this.alarmList = alarmList;
	}

	@Override
	public String toString() {
		return "AlarmPaging [empCode=" + empCode + ", totalCount=" + totalCount + ", startCount=" + startCount
				+ ", endCount=" + endCount + ", alarmList=" + alarmList + "]";
	}

}
