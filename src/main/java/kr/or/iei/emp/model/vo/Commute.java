package kr.or.iei.emp.model.vo;

public class Commute {
	private String attDate;
	private String empCode;
	private String onWork;
	private String offWork;
	private String checkNote;

	public Commute() {
		super();
	}

	public Commute(String attDate, String empCode, String onWork, String offWork, String checkNote) {
		super();
		this.attDate = attDate;
		this.empCode = empCode;
		this.onWork = onWork;
		this.offWork = offWork;
		this.checkNote = checkNote;
	}

	public String getAttDate() {
		return attDate;
	}

	public void setAttDate(String attDate) {
		this.attDate = attDate;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getOnWork() {
		return onWork;
	}

	public void setOnWork(String onWork) {
		this.onWork = onWork;
	}

	public String getOffWork() {
		return offWork;
	}

	public void setOffWork(String offWork) {
		this.offWork = offWork;
	}

	public String getCheckNote() {
		return checkNote;
	}

	public void setCheckNote(String checkNote) {
		this.checkNote = checkNote;
	}

	@Override
	public String toString() {
		return "Commute [attDate=" + attDate + ", empCode=" + empCode + ", onWork=" + onWork + ", offWork=" + offWork
				+ ", checkNote=" + checkNote + "]";
	}

}
