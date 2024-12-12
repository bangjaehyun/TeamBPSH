package kr.or.iei.emp.model.vo;

public class Emp {
	private String empCode;
	private String teamCode;
	private String rankCode;
	private String empId;
	private String empPw;
	private String empName;
	private String empPhone;
	private String empRetire;
	private String empDate;
	private boolean admin;

	public Emp() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Emp(String empCode, String teamCode, String rankCode, String empId, String empPw, String empName,
			String empPhone, String empRetire, String empDate, boolean admin) {
		super();
		this.empCode = empCode;
		this.teamCode = teamCode;
		this.rankCode = rankCode;
		this.empId = empId;
		this.empPw = empPw;
		this.empName = empName;
		this.empPhone = empPhone;
		this.empRetire = empRetire;
		this.empDate = empDate;
		this.admin = admin;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
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

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmpPw() {
		return empPw;
	}

	public void setEmpPw(String empPw) {
		this.empPw = empPw;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getEmpPhone() {
		return empPhone;
	}

	public void setEmpPhone(String empPhone) {
		this.empPhone = empPhone;
	}

	public String getEmpRetire() {
		return empRetire;
	}

	public void setEmpRetire(String empRetire) {
		this.empRetire = empRetire;
	}

	public String getEmpDate() {
		return empDate;
	}

	public void setEmpDate(String empDate) {
		this.empDate = empDate;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	@Override
	public String toString() {
		return "Emp [empCode=" + empCode + ", teamCode=" + teamCode + ", rankCode=" + rankCode + ", empId=" + empId
				+ ", empPw=" + empPw + ", empName=" + empName + ", empPhone=" + empPhone + ", empRetire=" + empRetire
				+ ", empDate=" + empDate + ", admin=" + admin + "]";
	}
	
	

}
