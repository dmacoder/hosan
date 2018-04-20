package com.cafe24.hosan.interceptor;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.cafe24.hosan.member.service.MemberService;

public class PasswordInterceptor extends HandlerInterceptorAdapter{

	private static final String LOGIN = "loginUserInfo";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Inject
	private MemberService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
							 Object Handler) throws Exception{
		
		//HttpSession session = request.getSession();
		
		savePrevURL(request);
		
		response.sendRedirect(request.getContextPath()+"/member/confirmPassword");
		return false;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
	
	private void savePrevURL(HttpServletRequest request) {
		
		String uri = request.getRequestURI();
		
		String query = request.getQueryString();
		
		if(query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}
		
		if(request.getMethod().equals("GET")) {
			System.out.println("비밀번호 확인이 필요한 페이지 prev_url : " + (uri + query));
			logger.info("비밀번호 확인이 필요한 페이지 prev_url : " + (uri + query));			
			//referer_FullContextURL = "http://" + req.getServerName() + ":" + req.getServerPort() + contextPath;
			
			request.getSession().setAttribute("password_confirm_prev_url", "http://" + request.getServerName() + ":" + request.getServerPort()+uri + query);
		}
	}
	
	
}
