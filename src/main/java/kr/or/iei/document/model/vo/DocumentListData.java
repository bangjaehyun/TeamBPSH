package kr.or.iei.document.model.vo;

import java.util.ArrayList;

//내일 추가
public class DocumentListData {
	private ArrayList<Document>documentList;
	
	private String pageNavi;

	public DocumentListData(ArrayList<Document> documentList, String pageNavi) {
		super();
		this.documentList = documentList;
		this.pageNavi = pageNavi;
	}

	public DocumentListData() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ArrayList<Document> getDocumentList() {
		return documentList;
	}

	public void setDocumentList(ArrayList<Document> documentList) {
		this.documentList = documentList;
	}

	public String getPageNavi() {
		return pageNavi;
	}

	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}

	@Override
	public String toString() {
		return "DocumentListData [documentList=" + documentList + ", pageNavi=" + pageNavi + "]";
	}
	
}
