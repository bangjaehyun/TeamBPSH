package kr.or.iei.emp.model.vo;

public class Disciplinary {
	private String disciplinaryNo;
	private String typeCode;
	private String empCode;
	private String disReason;
	private String disEnd;
	private String value;

	public Disciplinary() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Disciplinary(String disciplinaryNo, String typeCode, String empCode, String disReason, String disEnd,
			String value) {
		super();
		this.disciplinaryNo = disciplinaryNo;
		this.typeCode = typeCode;
		this.empCode = empCode;
		this.disReason = disReason;
		this.disEnd = disEnd;
		this.value = value;
	}

	public String getDisciplinaryNo() {
		return disciplinaryNo;
	}

	public void setDisciplinaryNo(String disciplinaryNo) {
		this.disciplinaryNo = disciplinaryNo;
	}

	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getDisReason() {
		return disReason;
	}

	public void setDisReason(String disReason) {
		this.disReason = disReason;
	}

	public String getDisEnd() {
		return disEnd;
	}

	public void setDisEnd(String disEnd) {
		this.disEnd = disEnd;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return "Disciplinary [disciplinaryNo=" + disciplinaryNo + ", typeCode=" + typeCode + ", empCode=" + empCode
				+ ", disReason=" + disReason + ", disEnd=" + disEnd + ", value=" + value + "]";
	}

}
