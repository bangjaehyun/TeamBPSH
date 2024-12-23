package kr.or.iei.document.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import kr.or.iei.document.model.vo.Document;

@Repository("documentDao")
public class DocumentDao {
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	//달력에서 출력할 문서 List
    public List<Document> apiDocumentList(String empCode) {        
        return sqlSession.selectList("document.apiDocumentList",empCode);
    }
}
