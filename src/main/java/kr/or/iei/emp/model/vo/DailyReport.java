package kr.or.iei.emp.model.vo;

public class DailyReport {
	private String dailyDate;
	private String empCode;
	private String reportContent;
	
	public DailyReport() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DailyReport(String dailyDate, String empCode, String reportContent) {
		super();
		this.dailyDate = dailyDate;
		this.empCode = empCode;
		this.reportContent = reportContent;
	}

	public String getDailyDate() {
		return dailyDate;
	}

	public void setDailyDate(String dailyDate) {
		this.dailyDate = dailyDate;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getReportContent() {
		return reportContent;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	@Override
	public String toString() {
		return "DailyReport [dailyDate=" + dailyDate + ", empCode=" + empCode + ", reportContent=" + reportContent
				+ "]";
	}
	
	
	
	
}
