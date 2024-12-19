package kr.or.iei.document.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import kr.or.iei.document.model.dao.DocumentDao;

@Service("documentService")
public class DocumentService {
	@Autowired
	@Qualifier("documentDao")
	private DocumentDao dao;
	
	
}
