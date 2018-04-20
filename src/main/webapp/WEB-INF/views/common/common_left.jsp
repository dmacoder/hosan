<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="col-sm-5 col-md-3 col-md-pull-9 col-sm-pull-7 pull-off">
						<aside class="sidebar">
							<!-- 카테고리별 서브카테고리 부분 -->
							<div class="sidebar-widget">
								<h3 class="sidebar-title mb30"><span id="CategoryTitle"></span></h3>
								<ul class="categories" id="subCategoryList">
								
									<li><a href="#"><span>1</span>목조</a></li>
									<li><a href="#"><span>2</span>단열</a></li>
									<li><a href="#"><span>3</span>창호</a></li>
									<li><a href="#"><span>4</span>내부마감</a></li>
									<li><a href="#"><span>5</span>외장마감</a></li>
									<li><a href="#"><span>6</span>설비</a></li>
									<li><a href="#"><span>7</span>전기</a></li>
									<li><a href="#"><span>8</span>징크</a></li>
									<li><a href="#"><span>9</span>설계&amp;디자인</a></li>
									<li><a href="#"><span>10</span>데크</a></li>
									
									
								</ul>
							</div>
							
							<!-- 최근/인기 게시글 -->
							<div class="sidebar-widget">
								<ul class="nav nav-tabs">
									<li class="active"><a href="#tab1" data-toggle="tab">최근 게시글</a></li>
									<li><a href="#tab2" data-toggle="tab">인기 게시글</a></li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane fade in active" id="tab1">
										<ul class="latest-posts" id="latest-posts">
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">화장실 타일 공사해드립니다</a>
													</h5>
													<span>25 3월, 2018 </span>
												</div>
											</li>
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">주택 리모델링 해드립니다.</a>
													</h5>
													<span>27 3월, 2018 </span>
												</div>
											</li>
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">오래 된 모텔건물, 집 등 외벽을 철거없이 리모델링 해드립니다</a>
													</h5>
													<span>1 3월, 2018 </span>
												</div>
											</li>
										</ul>
									</div>
									<div class="tab-pane fade" id="tab2">
										<ul class="latest-posts" id="hot-posts">
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">싸게 주택 리모델링 해드립니다.</a>
													</h5>
													<span>10 2월, 2018 </span>
												</div>
											</li>
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">고객 만족 100% 화장실 타일 공사</a>
													</h5>
													<span>12 2월, 2018 </span>
												</div>
											</li>
											<li>
												<div class="image-post">
													<img src="${pageContext.request.contextPath}/resources/upload/service/1/images/mainimage.jpg" alt="blog post">
												</div>
												<div class="info-post">
													<h5>
														<a href="blog_single_left.html">값싸고 만족되는 석면철거,인테리어철거공사</a>
													</h5>
													<span>15 2월, 2018 </span>
												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>
							
							
							

						</aside>
					</div>