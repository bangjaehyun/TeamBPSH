package kr.or.iei.vote.model.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.vote.model.dao.VoteDao;
import kr.or.iei.vote.model.vo.Vote;
import kr.or.iei.vote.model.vo.VoteEmpList;
import kr.or.iei.vote.model.vo.VoteList;

@Service("voteService")
public class VoteService {

	@Autowired
	@Qualifier("voteDao")
	private VoteDao dao;

	public ArrayList<Vote> selectVoteList() {
		return (ArrayList<Vote>)dao.selectVoteList();
	}

	@Transactional
	public int insertVote(Vote vote, List<String> voteList) {
		String voteNo = dao.getVoteNo();
		
		vote.setVoteNo(voteNo);
		int result = dao.insertVote(vote);
		
		if(result > 0) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("voteNo", voteNo);
			for(String voteVal : voteList) {
				map.put("voteVal", voteVal);
				result = dao.insertVoteVal(map);
				if(result < 1) {
					break;
				}
			}
		}
		
		return result;
	}

	public Vote selectVote(Vote vote) {
		
		Vote v = dao.selectVote(vote);
		
		if(v != null) {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

		    LocalDate toDay = LocalDate.now();
		    LocalDate voteEndDay = LocalDate.parse(v.getVoteEnd(), formatter);

		    // 날짜 비교
		    if(voteEndDay.isBefore(toDay)) {
		    	ArrayList<VoteEmpList> voteEmpList = (ArrayList<VoteEmpList>)dao.selectVoteEmpList(v.getVoteNo());
		    	v.setVoteEmpList(voteEmpList);
		    }
			
		    //로그인한 사원이 투표를 하였는지
			String voteListNo = dao.selectDoVoteEmp(vote);
			v.setVoteListNo(voteListNo);
			
			//투표리스트 조회
			ArrayList<VoteList> list = (ArrayList<VoteList>)dao.selectVoteValList(vote);
			v.setVoteList(list);
		}
		
		return v;
	}
	
	@Transactional
	public int doVoteEmp(VoteList voteList) {
		int result = dao.insertDoVoteEmp(voteList);
		
		if(result > 0) {
			result = dao.voteListCountAdd(voteList);
		}
		
		return result;
	}
	
}
