package kr.or.iei.emp.model.vo;

public class Chat {
	private String empCode;
	private String chatMsgBg;
	private String chatMsg;
	private String chatFileName;
	private String chatFilePath;
	private String chatDate;

	public Chat() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Chat(String empCode, String chatMsgBg, String chatMsg, String chatFileName, String chatFilePath,
			String chatDate) {
		super();
		this.empCode = empCode;
		this.chatMsgBg = chatMsgBg;
		this.chatMsg = chatMsg;
		this.chatFileName = chatFileName;
		this.chatFilePath = chatFilePath;
		this.chatDate = chatDate;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getChatMsgBg() {
		return chatMsgBg;
	}

	public void setChatMsgBg(String chatMsgBg) {
		this.chatMsgBg = chatMsgBg;
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

}
