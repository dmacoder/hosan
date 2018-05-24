package com.cafe24.hosan.notice.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.hosan.notice.domain.NoticeVO;
import com.cafe24.hosan.util.common.SearchCriteria;

@Repository
public class NoticeDAOImpl implements NoticeDAO{
	@Inject
	private SqlSession sqlSession;
	private static String namespace = "com.kosmo.mapper.NoticeMapper";
	@Override
	public List<NoticeVO> getNoticeListJson(SearchCriteria scri) {
		
		return sqlSession.selectList(namespace + ".getNoticeListJson", scri);
	}
	@Override
	public int getTotalCount(SearchCriteria scri) {
		return sqlSession.selectOne(namespace+".getTotalCount",scri);
	}
	@Override
	public int deleteNotice(int notice_srl) {
		
		return sqlSession.delete(namespace + ".deleteNotice", notice_srl);
	}
	@Override
	public int modifyNotice(NoticeVO vo) {
	
		return sqlSession.delete(namespace + ".modifyNotice", vo);
		
	}
	@Override
	public int writeNotice(NoticeVO vo) {
		/*Map<String,Object> paramMap = new HashMap<String , Object>();
		paramMap.put("title", title);
		paramMap.put("contents", contents);*/
		return sqlSession.insert(namespace + ".writeNotice", vo);
	}
	@Override
	public NoticeVO readNotice(Integer notice_srl) {
		return sqlSession.selectOne(namespace+".readNotice",notice_srl);
	}
}
