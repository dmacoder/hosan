package com.cafe24.hosan.util.common;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;


public class PageMaker {

	private int totalResults; //조건에 맞는 전체 게시글 수
	private int startPage; //게시글 번호에 따른 보여지는 페이지의 시작 번호
	private int endPage; //게시글 번호에 따른 보여지는 페이지의 마지막 번호
	private boolean prev; // 이전 버튼 클릭 가능 여부
	private boolean next; // 다음 버튼 클릭 가능 여부 
	
	private int displayPageNum = 10; //페이징 하단에 보여지는 페이지의 개수 (1~10) (11~20) -> 10개
	
	private Criteria cri; //page or offset, limit


	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public Criteria getCri() {
		return cri;
	}
	
	public void setTotalResults(int totalResults) {
		this.totalResults = totalResults;
		
		calcData();
	}

	public int getTotalResults() {
		return totalResults;
	}
	
	private void calcData() {
		
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum ) * displayPageNum);
		
		startPage = (endPage - displayPageNum) + 1;
		
		int tempEndPage = (int)(Math.ceil(totalResults / (double)cri.getLimit()));
		
		if(endPage > tempEndPage){
			endPage = tempEndPage;
		}
		
		prev = startPage ==1 ? false : true;
		
		next = endPage * cri.getLimit() >= totalResults ? false : true;
		
	}



	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}


	
	public String makeQuery(int page){
		
		UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("limit", cri.getLimit())
	            .build();	            
		
		return uriComponents.toUriString();
	}

	public String makeSearch(int page){
		
		UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("limit", cri.getLimit())
	            .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
	            .queryParam("keyword", ((SearchCriteria)cri).getKeyword())
	            .build();	            
		
		return uriComponents.toUriString();
	}	
	
	@Override
	public String toString() {
		return "PageMaker [totalResults=" + totalResults + ", startPage="
				+ startPage + ", endPage=" + endPage + ", prev=" + prev
				+ ", next=" + next + ", displayPageNum=" + displayPageNum
				+ ", cri=" + cri + "]";
	}
	
	
}
