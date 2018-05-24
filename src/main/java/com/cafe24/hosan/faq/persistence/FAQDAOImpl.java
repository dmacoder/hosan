package com.cafe24.hosan.faq.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.hosan.faq.domain.FAQVO;
import com.cafe24.hosan.util.SearchFAQCriteria;

@Repository
public class FAQDAOImpl implements FAQDAO{
	@Inject
	private SqlSession sqlSession;
	private static String namespace = "com.kosmo.mapper.FAQMapper";
	@Override
	public List<FAQVO> getFAQListJson(SearchFAQCriteria scri) {
		
		return sqlSession.selectList(namespace + ".getFAQListJson", scri);
	}
	@Override
	public int getTotalCount(SearchFAQCriteria scri) {
		return sqlSession.selectOne(namespace+".getTotalCount",scri);
	}
	@Override
	public int deleteFAQ(int faq_srl) {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace + ".deleteFAQ", faq_srl);
	}
	@Override
	public int modifyFAQ(FAQVO vo) {
	
		return sqlSession.update(namespace + ".modifyFAQ", vo);
		
	}
	@Override
	public int writeFAQ(FAQVO vo) {
		/*Map<String,Object> paramMap = new HashMap<String , Object>();
		paramMap.put("title", title);
		paramMap.put("contents", contents);*/
		return sqlSession.insert(namespace + ".writeFAQ", vo);
	}
	@Override
	public FAQVO readFAQ(Integer faq_srl) {
		return sqlSession.selectOne(namespace+".readFAQ",faq_srl);
	}
	
	
}
