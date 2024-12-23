package kr.or.iei.emp.model.vo;

import java.util.ArrayList;

public class ChatGroup {
	private String groupNo;
	private ArrayList<Chat> chatList;

	public ChatGroup() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChatGroup(String groupNo, ArrayList<Chat> chatList) {
		super();
		this.groupNo = groupNo;
		this.chatList = chatList;
	}

	public String getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(String groupNo) {
		this.groupNo = groupNo;
	}

	public ArrayList<Chat> getChatList() {
		return chatList;
	}

	public void setChatList(ArrayList<Chat> chatList) {
		this.chatList = chatList;
	}

	@Override
	public String toString() {
		return "ChatGroup [groupNo=" + groupNo + ", chatList=" + chatList + "]";
	}

}
