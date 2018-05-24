package com.cafe24.hosan.notice.persistence;

import java.util.List;

import com.cafe24.hosan.notice.domain.NoticeVO;
import com.cafe24.hosan.util.common.SearchCriteria;

public interface NoticeDAO {
	public List<NoticeVO> getNoticeListJson(SearchCriteria scri);
	
	public int getTotalCount(SearchCriteria scri);
	
	public int deleteNotice(int notice_srl);
	
	public int modifyNotice(NoticeVO vo);

	public int writeNotice(NoticeVO vo);

	public NoticeVO readNotice(Integer notice_srl);
}
