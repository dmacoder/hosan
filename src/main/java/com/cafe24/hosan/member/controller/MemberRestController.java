package com.cafe24.hosan.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MutablePropertySources;
import org.springframework.core.io.support.ResourcePropertySource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cafe24.hosan.member.service.MemberService;
import com.cafe24.hosan.util.SearchMemberCriteria;

@RestController
public class MemberRestController {

	private static final Logger logger = LoggerFactory.getLogger(MemberRestController.class);

	@Inject
	private MemberService memberService;

	@RequestMapping(value = "/member/json/authkey_check.json")
	public HashMap<String, Object> authkeyCheck(HttpServletRequest req) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		memberService.checkAuthkey(req, map);
		return map;
	}

	@RequestMapping(value = "/member/json/id_check.json")
	public HashMap<String, Object> idCheck(HttpServletRequest req) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		memberService.hasId(req, map);
		return map;
	}
	
	@RequestMapping(value = "/member/json/email_check.json")
	public HashMap<String, Object> emailCheck(HttpServletRequest req) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		memberService.hasEmail(req, map);
		return map;
	}

	
	@RequestMapping(value = "/member/json/member_list.json")
	public ResponseEntity<Map<String, Object>> getMemberListSearch(HttpServletRequest req, Model model,
			@RequestParam(required = false, defaultValue = "1") Integer nowPage,
			@RequestParam(required = false) Integer pageSize, 
			@RequestParam(required = false) Integer blockPage,
			@RequestParam(required = false) Integer member_srl,
			@RequestParam(required = false, defaultValue = "") String user_id,
			@RequestParam(required = false, defaultValue = "") String user_name,
			@RequestParam(required = false, defaultValue = "") String email_address,
							
			@RequestParam(required = false, defaultValue = "") String searchType,
			@RequestParam(required = false, defaultValue = "") String keyword) {
			
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		try {
		
		
		if (pageSize == null || blockPage == null) {
			ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();

			ConfigurableEnvironment env = ctx.getEnvironment();

			MutablePropertySources propertySources = env.getPropertySources();

			try {
				propertySources.addLast(new ResourcePropertySource("classpath:Environment.properties"));
				pageSize = Integer.parseInt(env.getProperty("member.pageSize"));
				blockPage = Integer.parseInt(env.getProperty("member.blockPage"));
			} catch (Exception e) {
				
				e.printStackTrace();
			}

			ctx.close();
		}

		SearchMemberCriteria scri = new SearchMemberCriteria();

		if (member_srl != null && member_srl != 0)
		scri.setMember_srl(member_srl);
		
		scri.setUser_id(user_id);
		scri.setUser_name(user_name);
		scri.setEmail_address(email_address);
		
		scri.setPage(nowPage);
		scri.setPageSize(pageSize);
		scri.setBlockPage(blockPage);
		
		if(searchType != null && searchType.length() != 0)
		scri.setSearchType(searchType);
		if(keyword != null && keyword.length() != 0)
		scri.setKeyword(keyword);
		
		memberService.getSearchMemberList(scri, map);

	     HttpHeaders headers = new HttpHeaders();
	     
	     /*
	      * 헤더를 임의로 실을떄
	      
	      */
	     //json
	     //headers.setContentType(new MediaType("application","json",Charset.forName("UTF-8")));
	     
	     //xml
	     //headers.setContentType(new MediaType("text","xml",Charset.forName("UTF-8")));
	    
	     //user define header
	     //headers.set("My-Header", "MyHeaderTestValue");
	     
	     
		entity = new ResponseEntity<Map<String, Object>>(map, headers,HttpStatus.OK);
		
		//entity = new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);
    } catch (Exception e) {
      e.printStackTrace();
      entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
    }
		//todo errors 메시지 상태에 포함시켜서..errors.code errors.message

		 return entity;
	}
}
