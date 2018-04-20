package com.cafe24.hosan.comment.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.cafe24.hosan.comment.domain.CommentVO;
import com.cafe24.hosan.util.CommentCriteria;

public interface CommentService {
	void getCommentListJson(CommentCriteria scri, HashMap<String, Object> map);
	
	 public int addComment(CommentVO vo) throws Exception;

	public int modifyComment(CommentVO vo);

	int deleteComment(Integer comment_srl);

	  public int count(Integer bno) throws Exception;

	CommentVO readComment(Integer comment_srl, Model model);

	int addComment(HttpServletRequest req, Map<String, Object> map);





	  
}
