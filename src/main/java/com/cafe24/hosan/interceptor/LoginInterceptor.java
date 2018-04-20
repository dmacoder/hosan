package com.cafe24.hosan.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//preHandle > 컨트롤러 수행 > postHandle > 컨트롤러 수행 완료 > afterCompletion
public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final String LOGIN = "loginUserInfo";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();

		
		
		/*
		 	if (session.getAttribute(LOGIN) != null) {
			logger.info("prehandle - 이전 로그인 데이터 삭제");
			session.removeAttribute(LOGIN);
		}
		return true;
		*/
		
		if(session.getAttribute(LOGIN)!=null) {
		    System.out.println("Interceptor : 세션 존재");
		    //response.sendRedirect(request.getContextPath()+"/");
		    //return false;
		   } 
		   else { 
		    System.out.println("Interceptor : 세션 없음");
		    //return true;
		   }
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		Object memberVO = modelMap.get("loginUserInfo");

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		// 로그인되서 객체가 있으면
		if (memberVO != null) {
			System.out.println(memberVO);
			logger.info("로그인 성공");
			session.setAttribute(LOGIN, memberVO);

			if (request.getParameter("useCookie") != null) {
				System.out.println("로그인 상태 유지");
				logger.info("로그인 상태 유지");
				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				loginCookie.setPath("/");
				// 쿠키 수명 : 하루동안 브라우저에 보관
				loginCookie.setMaxAge(60 * 60 * 24);
				response.addCookie(loginCookie);
			}

			String prev_url = (String)session.getAttribute("prev_url");
			System.out.println("로그인 후 postHandle prev_url : " +prev_url);
			
			if(prev_url==null || prev_url.length() == 0) {
				modelAndView.setViewName("member/member_login");
			}
			else {
				modelAndView.setViewName("redirect:"+prev_url);
			
			}
			//response.sendRedirect(prev_url != null ? (String) prev_url : request.getContextPath()+"/");

			// 로그인 비밀번호 불일치
		} else {
			logger.info("로그인 실패");
			
			//response.sendRedirect(request.getContextPath()+"/member/login");
			//modelAndView.setViewName("redirect:member/login");
			
			modelAndView.setViewName("member/member_login");
			
			//out.print("<script>" + "alert('로그인 정보를 확인하세요');" + "history.go(-1);" + "</script>");
			//out.flush();
			//out.close();
		}
		
		super.postHandle(request, response, handler, modelAndView);
		
	}

}