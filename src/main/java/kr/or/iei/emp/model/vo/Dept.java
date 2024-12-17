package kr.or.iei.emp.model.vo;

public class Dept {

	private String deptCode;
	private String deptName;

	public Dept() {
		super();
	}

	public Dept(String deptCode, String deptName) {
		super();
		this.deptCode = deptCode;
		this.deptName = deptName;
	}

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	@Override
	public String toString() {
		return "Dept [deptCode=" + deptCode + ", deptName=" + deptName + "]";
	}

}
