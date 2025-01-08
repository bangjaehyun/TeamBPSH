package kr.or.iei.emp.model.vo;

import java.util.ArrayList;

import kr.or.iei.document.model.vo.Sales;
import kr.or.iei.document.model.vo.Spending;

public class SalesSpending {
	private ArrayList<Sales> salesList;
	private ArrayList<Spending> spendingList;

	public SalesSpending() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SalesSpending(ArrayList<Sales> salesList, ArrayList<Spending> spendingList) {
		super();
		this.salesList = salesList;
		this.spendingList = spendingList;
	}

	public ArrayList<Sales> getSalesList() {
		return salesList;
	}

	public void setSalesList(ArrayList<Sales> salesList) {
		this.salesList = salesList;
	}

	public ArrayList<Spending> getSpendingList() {
		return spendingList;
	}

	public void setSpendingList(ArrayList<Spending> spendingList) {
		this.spendingList = spendingList;
	}

	@Override
	public String toString() {
		return "SalesSpending [salesList=" + salesList + ", spendingList=" + spendingList + "]";
	}

}
