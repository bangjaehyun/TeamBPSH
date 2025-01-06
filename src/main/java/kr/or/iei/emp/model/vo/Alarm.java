package kr.or.iei.emp.model.vo;

public class Alarm {
	private String alarmNo;
	private String empCode;
	private String alarmComment;
	private String refUrl;
	private String urlParam;
	private String alarmRead;
	private String alarmDate;

	public Alarm() {
		super();
	}

	public Alarm(String alarmNo, String empCode, String alarmComment, String refUrl, String urlParam, String alarmRead,
			String alarmDate) {
		super();
		this.alarmNo = alarmNo;
		this.empCode = empCode;
		this.alarmComment = alarmComment;
		this.refUrl = refUrl;
		this.urlParam = urlParam;
		this.alarmRead = alarmRead;
		this.alarmDate = alarmDate;
	}

	public String getAlarmNo() {
		return alarmNo;
	}

	public void setAlarmNo(String alarmNo) {
		this.alarmNo = alarmNo;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getAlarmComment() {
		return alarmComment;
	}

	public void setAlarmComment(String alarmComment) {
		this.alarmComment = alarmComment;
	}

	public String getRefUrl() {
		return refUrl;
	}

	public void setRefUrl(String refUrl) {
		this.refUrl = refUrl;
	}

	public String getUrlParam() {
		return urlParam;
	}

	public void setUrlParam(String urlParam) {
		this.urlParam = urlParam;
	}

	public String getAlarmRead() {
		return alarmRead;
	}

	public void setAlarmRead(String alarmRead) {
		this.alarmRead = alarmRead;
	}

	public String getAlarmDate() {
		return alarmDate;
	}

	public void setAlarmDate(String alarmDate) {
		this.alarmDate = alarmDate;
	}

	@Override
	public String toString() {
		return "Alarm [alarmNo=" + alarmNo + ", empCode=" + empCode + ", alarmComment=" + alarmComment + ", refUrl="
				+ refUrl + ", urlParam=" + urlParam + ", alarmRead=" + alarmRead + ", alarmDate=" + alarmDate + "]";
	}

}
