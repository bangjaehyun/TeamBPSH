package kr.or.iei.emp.model.vo;

public class Salary {
	private String empName;
	private String rankName;
	private String day;
	private String salary;
	private String salaryType;

	public Salary() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Salary(String empName, String rankName, String day, String salary, String salaryType) {
		super();
		this.empName = empName;
		this.rankName = rankName;
		this.day = day;
		this.salary = salary;
		this.salaryType = salaryType;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getRankName() {
		return rankName;
	}

	public void setRankName(String rankName) {
		this.rankName = rankName;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getSalaryType() {
		return salaryType;
	}

	public void setSalaryType(String salaryType) {
		this.salaryType = salaryType;
	}

	@Override
	public String toString() {
		return "Salary [empName=" + empName + ", rankName=" + rankName + ", day=" + day + ", salary=" + salary
				+ ", salaryType=" + salaryType + "]";
	}

}
