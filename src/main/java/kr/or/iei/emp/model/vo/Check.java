package kr.or.iei.emp.model.vo;

public class Check {
	private String day;
	private String empCode;
	private String empName;
	private String checkIn;
	private String checkOut;
	private String checkNote;

	public Check() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Check(String day, String empCode, String empName, String checkIn, String checkOut, String checkNote) {
		super();
		this.day = day;
		this.empCode = empCode;
		this.empName = empName;
		this.checkIn = checkIn;
		this.checkOut = checkOut;
		this.checkNote = checkNote;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
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

	public String getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public String getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public String getCheckNote() {
		return checkNote;
	}

	public void setCheckNote(String checkNote) {
		this.checkNote = checkNote;
	}

	@Override
	public String toString() {
		return "Check [day=" + day + ", empCode=" + empCode + ", empName=" + empName + ", checkIn=" + checkIn
				+ ", checkOut=" + checkOut + ", checkNote=" + checkNote + "]";
	}

}
