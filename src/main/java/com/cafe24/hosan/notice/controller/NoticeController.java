package com.cafe24.hosan.notice.controller;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.hosan.notice.domain.NoticeVO;
import com.cafe24.hosan.notice.service.NoticeService;
import com.cafe24.hosan.member.domain.MemberVO;
import com.cafe24.hosan.util.common.SearchCriteria;

@Controller
public class NoticeController {

	@Inject
	private NoticeService service;

	// notice 게시판 JSON
	@ResponseBody
	@RequestMapping(value = "/customercenter/notice/json/notice_list.json")
	public HashMap<String, Object> getNoticeListJson(HttpServletRequest req, Model model,
			@RequestParam(required = false, defaultValue = "1") Integer nowPage,

			@RequestParam(required = false) Integer pageSize,
			@RequestParam(required = false) Integer blockPage,
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String keyword) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();

		if (pageSize == null || blockPage == null) {
			ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();

			ConfigurableEnvironment env = ctx.getEnvironment();

			MutablePropertySources propertySources = env.getPropertySources();

			try {
				propertySources.addLast(new ResourcePropertySource("classpath:Environment.properties"));
				if(pageSize == null)
				pageSize = Integer.parseInt(env.getProperty("notice.pageSize"));
				if(blockPage == null)
				blockPage = Integer.parseInt(env.getProperty("notice.blockPage"));
			} catch (Exception e) {
				
				e.printStackTrace();
			}

			ctx.close();
		}

		SearchCriteria scri = new SearchCriteria();


		scri.setPage(nowPage);
		scri.setPageSize(pageSize);
		scri.setBlockPage(blockPage);
		

		
		if(searchType != null && searchType.length() != 0)
		scri.setSearchType(searchType);
		if(keyword != null && keyword.length() != 0)
		scri.setKeyword(keyword);		
		
		service.getNoticeListJson(scri, map);

		return map;
	}

	// 글 상세 보기
	@RequestMapping(value = "/customercenter/notice/{notice_srl}", method = RequestMethod.GET)
	public String viewNotice(@PathVariable Integer notice_srl,Model model) {
		//model.addAttribute("notice_srl",notice_srl);
		service.readNotice(notice_srl,model);
		return "customercenter/notice/customercenter_notice_view";
	}

	// 리스트 보기
	@RequestMapping(value = "/customercenter/notice", method = RequestMethod.GET)
	public String listNotice(Model model) {
		
		
		return "customercenter/notice/customercenter_notice_list";
	}

	// 글쓰기 폼 가져오기
	@RequestMapping(value = "/customercenter/notice/new", method = RequestMethod.GET)
	public String writeFormNotice() {
		return "customercenter/notice/customercenter_notice_write";
	}

	// 글쓰기 처리
	@ResponseBody
	@RequestMapping(value = "/customercenter/notice", method = RequestMethod.POST)
	public Map<String, Object> writeActionNotice(HttpServletRequest req, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();

		if (session.getAttribute("loginUserInfo") == null) {
			map.put("result", "fail");
			map.put("errorMsg", "isNotLogin");
			return map;
		}

		if (!((MemberVO) session.getAttribute("loginUserInfo")).getIsAdmin().equalsIgnoreCase("Y")) {
			map.put("result", "fail");
			map.put("errorMsg", "isNotAdmin");
			return map;
		}

		int result = service.writeNotice(req,map);

		if (result <= 0) {
			map.put("result", "fail");
			map.put("errorMsg", "sqlError");
		} else {
			map.put("result", "success");
		}
		return map;
	}

	// 글수정 폼
	@RequestMapping(value = "/customercenter/notice/{notice_srl}/edit", method = RequestMethod.GET)
	public String modifyFormNotice(@PathVariable Integer notice_srl,Model model) {
		//model.addAttribute("notice_srl",notice_srl);
		service.readNotice(notice_srl,model);
		return "customercenter/notice/customercenter_notice_modify";
	}

	// 글수정 처리
	@ResponseBody
	@RequestMapping(value = "/customercenter/notice/{notice_srl}", method= {RequestMethod.PUT, RequestMethod.PATCH})
	public Map<String, Object> modifyActionNotice(@PathVariable Integer notice_srl,HttpServletRequest req,HttpSession session,@RequestBody NoticeVO vo) {
		
		vo.setNotice_srl(notice_srl);
		/*
		System.out.println("service_srl:"+vo.getService_srl());
		System.out.println("notice_srl:"+notice_srl);
		System.out.println("category_srl:"+vo.getCategory_srl());
		System.out.println("title:"+vo.getTitle());
		System.out.println("contents:"+vo.getContents());
		*/
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (session.getAttribute("loginUserInfo") == null) {
			map.put("result", "fail");
			map.put("errorMsg", "isNotLogin");
			return map;
		}
		
		if (!((MemberVO) session.getAttribute("loginUserInfo")).getIsAdmin().equalsIgnoreCase("Y")) {
			map.put("result", "fail");
			map.put("errorMsg", "isNotAdmin");
			return map;
		}
		
		int result = service.modifyNotice(vo);

		if (result <= 0) {
			map.put("result", "fail");
			map.put("errorMsg", "sqlError");
		} else {
			map.put("result", "success");
		}

		return map;
	}

	// 해당 글 삭제
	@ResponseBody
	@RequestMapping(value = "/customercenter/notice/{notice_srl}", method = RequestMethod.DELETE)
	public Map<String, Object> deleteNotice(HttpServletRequest req, HttpSession session, Model model, @PathVariable Integer notice_srl) {
		Map<String, Object> map = new HashMap<String, Object>();

		if (session.getAttribute("loginUserInfo") == null) {
			map.put("result", "fail");
			map.put("errorMsg", "isNotLogin");
			return map;
		}
		
		if (!((MemberVO) session.getAttribute("loginUserInfo")).getIsAdmin().equalsIgnoreCase("Y")) {
			map.put("result", "fail");
			map.put("errorMsg", "isNotAdmin");
			return map;
		}
		
		int result = service.deleteNotice(notice_srl);

		if (result <= 0) {
			map.put("result", "fail");
			map.put("errorMsg", "sqlError");
		} else {
			map.put("result", "success");
		}

		return map;
	}
}
