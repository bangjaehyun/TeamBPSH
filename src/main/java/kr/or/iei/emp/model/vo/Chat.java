package kr.or.iei.emp.model.vo;

public class Chat {
	private String groupNo;
	private String empCode;
	private String empName;
	private String chatMsgGb;
	private String chatMsg;
	private String chatFileName;
	private String chatFilePath;
	private String chatDate;

	public Chat() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Chat(String groupNo, String empCode, String empName, String chatMsgGb, String chatMsg, String chatFileName,
			String chatFilePath, String chatDate) {
		super();
		this.groupNo = groupNo;
		this.empCode = empCode;
		this.empName = empName;
		this.chatMsgGb = chatMsgGb;
		this.chatMsg = chatMsg;
		this.chatFileName = chatFileName;
		this.chatFilePath = chatFilePath;
		this.chatDate = chatDate;
	}

	public String getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(String groupNo) {
		this.groupNo = groupNo;
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

	public String getChatMsgGb() {
		return chatMsgGb;
	}

	public void setChatMsgGb(String chatMsgGb) {
		this.chatMsgGb = chatMsgGb;
	}

	public String getChatMsg() {
		return chatMsg;
	}

	public void setChatMsg(String chatMsg) {
		this.chatMsg = chatMsg;
	}

	public String getChatFileName() {
		return chatFileName;
	}

	public void setChatFileName(String chatFileName) {
		this.chatFileName = chatFileName;
	}

	public String getChatFilePath() {
		return chatFilePath;
	}

	public void setChatFilePath(String chatFilePath) {
		this.chatFilePath = chatFilePath;
	}

	public String getChatDate() {
		return chatDate;
	}

	public void setChatDate(String chatDate) {
		this.chatDate = chatDate;
	}

	@Override
	public String toString() {
		return "Chat [groupNo=" + groupNo + ", empCode=" + empCode + ", empName=" + empName + ", chatMsgGb=" + chatMsgGb
				+ ", chatMsg=" + chatMsg + ", chatFileName=" + chatFileName + ", chatFilePath=" + chatFilePath
				+ ", chatDate=" + chatDate + "]";
	}

}