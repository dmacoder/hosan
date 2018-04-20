package com.cafe24.hosan.comment.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MutablePropertySources;
import org.springframework.core.io.support.ResourcePropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.hosan.comment.domain.CommentVO;
import com.cafe24.hosan.comment.service.CommentService;
import com.cafe24.hosan.member.domain.MemberVO;
import com.cafe24.hosan.util.CommentCriteria;

@Controller
public class CommentController {

	@Inject
	private CommentService service;

	@ResponseBody
	@RequestMapping(value = "/comment/json/comment_list.json")
	public HashMap<String, Object> getCommentListJson(HttpServletRequest req, Model model,
			@RequestParam(required = false, defaultValue = "1") Integer nowPage,

			@RequestParam(required = false) Integer comment_srl,
			@RequestParam(required = false) Integer parent_board_srl,
			@RequestParam(required = false, defaultValue = "") String user_id,
			@RequestParam(required = false, defaultValue = "") String comment_type,
			
			@RequestParam(required = false) Integer pageSize, @RequestParam(required = false) Integer blockPage,

			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String keyword) {

		System.out.println("parent_board_srl :" + parent_board_srl);

		HashMap<String, Object> map = new HashMap<String, Object>();

		if (pageSize == null || blockPage == null) {
			ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();

			ConfigurableEnvironment env = ctx.getEnvironment();

			MutablePropertySources propertySources = env.getPropertySources();

			try {
				propertySources.addLast(new ResourcePropertySource("classpath:Environment.properties"));
				if (pageSize == null)
					pageSize = Integer.parseInt(env.getProperty("comment.pageSize"));
				if (blockPage == null)
					blockPage = Integer.parseInt(env.getProperty("comment.blockPage"));
			} catch (Exception e) {

				e.printStackTrace();
			}

			ctx.close();
		}

		CommentCriteria scri = new CommentCriteria();

		if (parent_board_srl != null) {
			scri.setParent_board_srl(parent_board_srl);
			System.out.println("parent_board_srl:" + parent_board_srl);
		}
		if (comment_srl != null)
			scri.setComment_srl(comment_srl);

		scri.setPage(nowPage);
		scri.setPageSize(pageSize);
		scri.setBlockPage(blockPage);
		scri.setUser_id(user_id);
		
		scri.setComment_type(comment_type);
		
		System.out.println("nowPage:" + nowPage);

		service.getCommentListJson(scri, map);

		return map;
	}

	// 댓글 쓰기
	@RequestMapping(value = "comment", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> writeActionBoard(HttpServletRequest req, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		ResponseEntity<Map<String, Object>> entity = null;

		try {
			if (session.getAttribute("loginUserInfo") == null) {
				map.put("result", "fail");
				map.put("errorMsg", "isNotLogin");

			} else {

				int result = service.addComment(req, map);

				if (result <= 0) {
					map.put("result", "fail");
					map.put("errorMsg", "sqlError");
				} else {
					map.put("result", "success");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
			map.put("layer_msg", "sqlError");
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}

		if (((String) map.get("result")).equals("fail")) {
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		} else if (((String) map.get("result")).equals("success")) {
			System.out.println("글수정 성공");
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}
		return entity;
	}

	
	//댓글 수정
	@RequestMapping(value = "comment/{comment_srl}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<Map<String, Object>> update(@PathVariable("comment_srl") Integer comment_srl,
			@RequestBody CommentVO vo, HttpSession session, Model model) {

		vo.setComment_srl(comment_srl);

		// 원본 객체를 가져와서
		CommentVO originVO = service.readComment(comment_srl, model);
		// 사용자 아이디를 저장후
		String origin_id = originVO.getUser_id();
		// 세션 아이디와 비교
		String user_id = ((MemberVO) session.getAttribute("loginUserInfo")).getUser_id();
		
		Map<String, Object> map = new HashMap<String, Object>();
		ResponseEntity<Map<String, Object>> entity = null;

		try {
			if (session.getAttribute("loginUserInfo") == null) {
				map.put("result", "fail");
				map.put("errorMsg", "isNotLogin");

			} else {

				if ((!user_id.equalsIgnoreCase(origin_id))&&!((MemberVO) session.getAttribute("loginUserInfo")).getIs_admin().equalsIgnoreCase("Y")) {
					map.put("result", "fail");
					map.put("errorMsg", "hasNotAuth");

				} else {

					int result = service.modifyComment(vo);

					if (result <= 0) {
						map.put("result", "fail");
						map.put("errorMsg", "sqlError");
					} else {
						map.put("result", "success");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", "fail");
			map.put("layer_msg", e.getMessage());
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}

		if (((String) map.get("result")).equals("fail")) {
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		} else if (((String) map.get("result")).equals("success")) {
			System.out.println("글 수정 성공");
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}
		return entity;
	}

	@RequestMapping(value = "comment/{comment_srl}", method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> remove(@PathVariable Integer comment_srl, HttpSession session, Model model) {

		Map<String, Object> map = new HashMap<String, Object>();
		ResponseEntity<Map<String, Object>> entity = null;

		CommentVO vo = service.readComment(comment_srl, model);
		
		vo.setComment_srl(comment_srl);

		// 원본 객체를 가져와서
		CommentVO originVO = service.readComment(comment_srl, model);
		// 사용자 아이디를 저장후
		String origin_id = originVO.getUser_id();
		// 세션 아이디와 비교
		String user_id = ((MemberVO) session.getAttribute("loginUserInfo")).getUser_id();
		
		
		try {
			if (session.getAttribute("loginUserInfo") == null) {
				map.put("result", "fail");
				map.put("errorMsg", "isNotLogin");
			} else {

				if ((!user_id.equalsIgnoreCase(origin_id))&&!((MemberVO) session.getAttribute("loginUserInfo")).getIs_admin().equalsIgnoreCase("Y")) {
					map.put("result", "fail");
					map.put("errorMsg", "hasNotAuth");

				} else {

					int result = service.deleteComment(comment_srl);

					if (result <= 0) {
						map.put("result", "fail");
						map.put("errorMsg", "sqlError");
					} else {
						map.put("result", "success");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("layer_msg", e.getMessage());
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}

		if (((String) map.get("result")).equals("fail")) {
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		} else if (((String) map.get("result")).equals("success")) {
			System.out.println("글 삭제 성공");
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		}
		return entity;

	}
}
