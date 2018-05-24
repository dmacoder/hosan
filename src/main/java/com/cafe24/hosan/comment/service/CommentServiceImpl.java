package com.cafe24.hosan.comment.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.cafe24.hosan.comment.domain.CommentVO;
import com.cafe24.hosan.comment.persistence.CommentDAO;
import com.cafe24.hosan.member.domain.MemberVO;
import com.cafe24.hosan.util.CommentCriteria;
import com.cafe24.hosan.util.PagingUtil;

@Service
public class CommentServiceImpl implements CommentService{

	@Inject
	private CommentDAO dao;
	
	@Override
	public void getCommentListJson(CommentCriteria scri, HashMap<String, Object> map) {
		List<CommentVO> lists = new ArrayList<CommentVO>();
		lists = dao.getCommentListJson(scri);
		
/*		
		for(CommentVO list:lists) {
			
			//싱글 쿼테이션 더블 쿼테이션 변경
			list.setContents(list.getContents().replaceAll("'", "\"").replaceAll("’", "\"").replaceAll("‘", "\"").replaceAll("\"", "\""));
			//줄바꿈 처리
			//list.setContents(list.getContents().replaceAll("\r\n", "<br/>"));
			list.setContents(list.getContents().replaceAll(System.getProperty("line.separator"), "<br/>"));
		}
	*/
		
		int totalRecordCount = dao.getTotalCount(scri);
		String pagingDiv = PagingUtil.pagingAjaxComment(totalRecordCount, scri, "commentPaging");
		
		map.put("commentLists", lists);
		map.put("pagingDiv", pagingDiv);
	}
	
	
	  @Override
	  public int count(Integer bno) throws Exception {

	    return dao.count(bno);
	  }




	@Override
	public int addComment(CommentVO vo) throws Exception {
		 return dao.addComment(vo);
	}


	@Override
	public int modifyComment(CommentVO vo) {
		// TODO Auto-generated method stub
		return dao.modifyComment(vo);
	}


	@Override
	public int deleteComment(Integer comment_srl) {
		// TODO Auto-generated method stub
		return dao.deleteComment(comment_srl);
	}


	@Override
	public CommentVO readComment(Integer comment_srl, Model model) {
		CommentVO vo = new CommentVO();
		vo = dao.readComment(comment_srl);
		//싱글 쿼테이션 더블 쿼테이션 변경
		vo.setComments(vo.getComments().replaceAll("'", "\"").replaceAll("’", "\"").replaceAll("‘", "\"").replaceAll("\"", "\""));
		//줄바꿈 처리
		vo.setComments(vo.getComments().replaceAll("\r\n", "<br/>"));
		//vo.setContents(vo.getContents().replaceAll(System.getProperty("line.separator"), "<br/>"));
		model.addAttribute("commentVO", vo);
		return vo;
	}


	@Override
	public int addComment(HttpServletRequest req, Map<String, Object> map) {
		
		HttpSession session = req.getSession();
		MemberVO memVO = (MemberVO)session.getAttribute("loginUserInfo");
		CommentVO vo = new CommentVO();
		String user_id = memVO.getUserId();
		String comments = req.getParameter("comments");
		int parent_board_srl = Integer.parseInt(req.getParameter("parent_board_srl"));
		String comment_type = req.getParameter("comment_type");
		vo.setComment_type(comment_type);
		vo.setParent_board_srl(parent_board_srl);
		vo.setUser_id(user_id);
		vo.setComments(comments);
		return dao.addComment(vo);
	}
}