package com.cafe24.hosan.faq.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.cafe24.hosan.faq.domain.FAQVO;
import com.cafe24.hosan.util.SearchFAQCriteria;


public interface FAQService {

	void getFAQListJson(SearchFAQCriteria scri, HashMap<String, Object> map);

	int deleteFAQ(int faqSrl);

	int writeFAQ(HttpServletRequest req, Map<String, Object> map);

	void readFAQ(Integer faqSrl, Model model);

	int modifyFAQ(FAQVO vo);
	
}
