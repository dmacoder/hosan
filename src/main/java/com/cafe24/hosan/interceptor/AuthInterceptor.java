package com.cafe24.hosan.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.cafe24.hosan.member.domain.MemberVO;
import com.cafe24.hosan.member.service.MemberService;

public class AuthInterceptor extends HandlerInterceptorAdapter{

	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Inject
	private MemberService service;
	
	private void savePrevURL(HttpServletRequest request) {
		
		String uri = request.getRequestURI();
		
		String query = request.getQueryString();
		
		if(query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}
		
		if(request.getMethod().equals("GET")) {
			logger.info("로그인 필요한 페이지 prev_url : " + (uri + query));
			//referer_FullContextURL = "http://" + req.getServerName() + ":" + req.getServerPort() + contextPath;			
			request.getSession().setAttribute("auth_prev_url", "http://" + request.getServerName() + ":" + request.getServerPort()+uri + query);
		}
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
							 Object Handler) throws Exception{
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginUserInfo")==null) {
			logger.info("로그인이 필요한 페이지 입니다.현재 로그인된 사용자 없음");
			savePrevURL(request);
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				MemberVO vo = service.checkLoginBefore(loginCookie.getValue());
				
				logger.info("MemberVO : " + vo);
				
				if(vo != null) {
					session.setAttribute("loginUserInfo", vo);
					return true;
				}
			}
			
			/*
			 관리자 페이지의 경우 관리자 전용 로그인으로..
			 */
			String uri = request.getRequestURI();
			
			String query = request.getQueryString();
			
			if(query == null || query.equals("null")) {
				query = "";
			} else {
				query = "?" + query;
			}
			String reqURL =  (uri + query);
			if(reqURL.matches(".*admin.*"))
			{
				response.sendRedirect(request.getContextPath()+"/admin/login");
			}
			else {
				response.sendRedirect(request.getContextPath()+"/member/login");
			}
			
			
			return false;
		}
		return true;
	}
}