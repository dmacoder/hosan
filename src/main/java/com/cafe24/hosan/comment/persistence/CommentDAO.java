package com.cafe24.hosan.comment.persistence;

import java.util.List;

import com.cafe24.hosan.comment.domain.CommentVO;
import com.cafe24.hosan.util.CommentCriteria;

public interface CommentDAO {
	public List<CommentVO> getCommentListJson(CommentCriteria scri);

	public int getTotalCount(CommentCriteria scri);

	public int count(Integer bno) throws Exception;

	public int addComment(CommentVO vo);

	public int modifyComment(CommentVO vo);

	public int deleteComment(Integer comment_srl);

	public CommentVO readComment(Integer comment_srl);

}
