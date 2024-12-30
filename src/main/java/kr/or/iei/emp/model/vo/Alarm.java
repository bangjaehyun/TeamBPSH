package kr.or.iei.emp.model.vo;

public class Alarm {
	private String alarmNo;
	private String alarmComment;
	private String refUrl;
	private String urlParam;
	private String alarmRead;
	private String alarmDate;

	public Alarm() {
		super();
	}

	public Alarm(String alarmComment, String refUrl, String urlParam, String alarmDate) {
		super();
		this.alarmComment = alarmComment;
		this.refUrl = refUrl;
		this.urlParam = urlParam;
		this.alarmDate = alarmDate;
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

	public String getAlarmDate() {
		return alarmDate;
	}

	public void setAlarmDate(String alarmDate) {
		this.alarmDate = alarmDate;
	}

	@Override
	public String toString() {
		return "Alarm [alarmComment=" + alarmComment + ", refUrl=" + refUrl + ", urlParam=" + urlParam + ", alarmDate="
				+ alarmDate + "]";
	}

}
