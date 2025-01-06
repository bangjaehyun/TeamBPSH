package kr.or.iei.vote.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.iei.common.exception.CommonException;
import kr.or.iei.vote.model.service.VoteService;
import kr.or.iei.vote.model.vo.Vote;
import kr.or.iei.vote.model.vo.VoteList;

@Controller("voteController")
@RequestMapping("/vote/")
public class VoteController {

	@Autowired
	@Qualifier("voteService")
	private VoteService service;
	
	@Autowired
	@Qualifier("messageSource")
	private MessageSource message;
	
	
	@PostMapping("list.do")
	public String voteList(Model model) {
		ArrayList<Vote> list = service.selectVoteList();
		
		model.addAttribute("voteList", list);
		return "vote/voteList";
	}
	
	@PostMapping("createVote.do")
	public String createVote() {
		
		return "vote/createVote";
	}
	
	@PostMapping(value="insertVote.do")
	public String insertVote(Vote vote, @RequestParam(name= "voteVal")List<String> voteList) {
		int result = service.insertVote(vote, voteList);
		
		return String.valueOf(result);
	}
	
	@PostMapping(value="voteDetail.do")
	public String voteDetail(Vote vote, Model model) {
		Vote selectVote = service.selectVote(vote);
		
		if(selectVote != null) {
			model.addAttribute("vote",selectVote);
		}else {
			  CommonException ex = new CommonException("페이지 이동중 오류 발생");
              ex.setErrorCode("SE002");
              Object msgParam[] = {"투표"};
              ex.setUserMsg(message.getMessage(ex.getErrorCode(), msgParam, Locale.KOREA));
              throw ex;
		}
		
		if(selectVote.getVoteEmpList() == null) {
			return "vote/voteDetail";
		}else {
			return "vote/voteDetailComplete";
		}
	}
	
	@PostMapping(value="doVoteEmp.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public String doVoteEmp(VoteList voteList) {
		int result = service.doVoteEmp(voteList);
		System.out.println(result);
		return String.valueOf(result);
	}
	
}
