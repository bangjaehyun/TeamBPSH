package kr.or.iei.vote.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.emp.model.vo.Alarm;
import kr.or.iei.emp.model.vo.Emp;
import kr.or.iei.vote.model.vo.Vote;
import kr.or.iei.vote.model.vo.VoteEmpList;
import kr.or.iei.vote.model.vo.VoteList;
import kr.or.iei.vote.model.vo.VotePaging;

@Repository("voteDao")
public class VoteDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	public List<Vote> selectVoteList(VotePaging votePaging) {
		return sqlSession.selectList("vote.selectList", votePaging);
	}

	public String getVoteNo() {
		return sqlSession.selectOne("vote.getVoteNo");
	}

	public int insertVote(Vote vote) {
		return sqlSession.insert("vote.insertVote", vote);
	}

	public int insertVoteVal(HashMap<String, String> map) {
		return sqlSession.insert("vote.insertVoteVal", map);
	}

	public Vote selectVote(Vote vote) {
		return sqlSession.selectOne("vote.selectVote", vote);
	}

	public List<VoteList> selectVoteValList(Vote vote) {
		return sqlSession.selectList("vote.selectVoteValList", vote);
	}

	public int insertDoVoteEmp(VoteList voteList) {
		return sqlSession.insert("vote.insertDoVoteEmp", voteList);
	}

	public int voteListCountAdd(VoteList voteList) {
		return sqlSession.update("vote.voteListCountAdd", voteList);
	}

	public String selectDoVoteEmp(Vote vote) {
		return sqlSession.selectOne("vote.selectDoVoteEmp", vote);
	}

	public List<VoteEmpList> selectVoteEmpList(String voteNo) {
		return sqlSession.selectList("vote.selectVoteEmpList", voteNo);
	}

	public List<String> selectAllEmp(String empCode) {
		return sqlSession.selectList("vote.selectEmpNoList", empCode);
	}

	public int insertAlarm(Alarm alarm) {
		return sqlSession.insert("vote.insertAlarm", alarm);
	}

	public int selectVoteListCount() {
		return sqlSession.selectOne("vote.selectVoteListCount");
	}

	public int updateVote(Vote vote) {
		return sqlSession.update("vote.updateVote", vote);
	}

	public int deleteVoteValList(String voteNo) {
		return sqlSession.delete("vote.deleteVoteValList",voteNo);
	}

}
