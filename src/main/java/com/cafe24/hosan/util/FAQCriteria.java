package com.cafe24.hosan.util;

import com.cafe24.hosan.util.common.Criteria;

public class FAQCriteria extends Criteria{
	
	private int faqSrl;
	private int categorySrl;
	private int serviceSrl;
	private String title;
	private String content;
	
	public int getFaqSrl() {
		return faqSrl;
	}
	public void setFaqSrl(int faqSrl) {
		this.faqSrl = faqSrl;
	}
	public int getCategorySrl() {
		return categorySrl;
	}
	public void setCategorySrl(int categorySrl) {
		this.categorySrl = categorySrl;
	}
	public int getServiceSrl() {
		return serviceSrl;
	}
	public void setServiceSrl(int serviceSrl) {
		this.serviceSrl = serviceSrl;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	
}
