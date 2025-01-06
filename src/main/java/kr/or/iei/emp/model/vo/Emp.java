package kr.or.iei.emp.model.vo;

public class Emp {
	private String empCode;
	private String teamCode;
	private String rankCode;
	private String deptCode;
	private String empId;
	private String empPw;
	private String empName;
	private String empPhone;
	private String empRetire;
	private String empDate;
	private String rankName;
	private String deptName;
	private String salary; // 급여
	private String vacationTotal; // 휴가
	private String vacationUse;
	private boolean admin;
	private boolean login;
	private int readCount; // 읽지않은 채팅 갯수
	private int alarmCount;// 읽지 않은 알람 갯수

	public Emp() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Emp(String empCode, String teamCode, String rankCode, String deptCode, String empId, String empPw,
			String empName, String empPhone, String empRetire, String empDate, String rankName, String deptName,
			String salary, String vacationTotal, String vacationUse, boolean admin, boolean login, int readCount,
			int alarmCount) {
		super();
		this.empCode = empCode;
		this.teamCode = teamCode;
		this.rankCode = rankCode;
		this.deptCode = deptCode;
		this.empId = empId;
		this.empPw = empPw;
		this.empName = empName;
		this.empPhone = empPhone;
		this.empRetire = empRetire;
		this.empDate = empDate;
		this.rankName = rankName;
		this.deptName = deptName;
		this.salary = salary;
		this.vacationTotal = vacationTotal;
		this.vacationUse = vacationUse;
		this.admin = admin;
		this.login = login;
		this.readCount = readCount;
		this.alarmCount = alarmCount;
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

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
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

	public String getRankName() {
		return rankName;
	}

	public void setRankName(String rankName) {
		this.rankName = rankName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getVacationTotal() {
		return vacationTotal;
	}

	public void setVacationTotal(String vacationTotal) {
		this.vacationTotal = vacationTotal;
	}

	public String getVacationUse() {
		return vacationUse;
	}

	public void setVacationUse(String vacationUse) {
		this.vacationUse = vacationUse;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public boolean isLogin() {
		return login;
	}

	public void setLogin(boolean login) {
		this.login = login;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public int getAlarmCount() {
		return alarmCount;
	}

	public void setAlarmCount(int alarmCount) {
		this.alarmCount = alarmCount;
	}

	@Override
	public String toString() {
		return "Emp [empCode=" + empCode + ", teamCode=" + teamCode + ", rankCode=" + rankCode + ", deptCode="
				+ deptCode + ", empId=" + empId + ", empPw=" + empPw + ", empName=" + empName + ", empPhone=" + empPhone
				+ ", empRetire=" + empRetire + ", empDate=" + empDate + ", rankName=" + rankName + ", deptName="
				+ deptName + ", salary=" + salary + ", vacationTotal=" + vacationTotal + ", vacationUse=" + vacationUse
				+ ", admin=" + admin + ", login=" + login + ", readCount=" + readCount + ", alarmCount=" + alarmCount
				+ "]";
	}

}