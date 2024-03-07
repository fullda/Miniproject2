<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Post It</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/resources/css/style.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <style> 
	@media screen and (max-width:768px){		
		select[name='type']{
			display:inline !important;
			width:30% !important;
		}
		input[name='keyword']{
			display:inline !important;
			width:45% !important;
		}
		#searchForm button{
			display:inline !important;
			width:22% !important;
		}
	}
</style>
</head>
<body class="d-flex flex-column">
<main class="flex-shrink-0">
    <!-- Navigation-->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container px-5">
            <a class="navbar-brand" href="/board/main"><h1>Post it</h1></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="/board/register">Write</a></li>
                    <li class="nav-item dropdown">
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- Page Content-->
    <section class="py-5">
        <div class="container px-5">
            <h1 class="fw-bolder fs-5 mb-4">Hot topic</h1>
            <div class="card border-0 shadow rounded-3 overflow-hidden">
                <div class="card-body p-0">
                    <div class="row gx-0">
                        <div class="col-lg-6 col-xl-5 py-lg-5">
                            <div class="p-4 p-md-5">
                                <div class="h2 fw-bolder">
                                    <c:out value="${main.title}"/>
                                </div>
                                <c:if test="${not empty main}">
                                <a class="stretched-link text-decoration-none" href="/board/read?pno=${main.pno}">
                                    Read more
                                    <i class="bi bi-arrow-right"></i>
                                </a>
                                </c:if>
                            </div>
                        </div>
                        <div class="col-lg-6 col-xl-7">
                            <div class="bg-featured-blog" style="background-image: url('/resources/upload/${main.img}');height: 350px; background-size:100% 100%;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="py-5">
        <div class="container px-5">
            <h2 class="fw-bolder fs-5 mb-4">Featured Stories</h2>
            <div class="row gx-5">
                <c:forEach var="story" items="${list}">
                    <div class="col-lg-4 mb-5">
                        <div class="card h-100 shadow border-0">
                            <img class="card-img-top" src="/resources/upload/${story.img}" alt="Image" style="height: 250px; object-fit: cover;" />
                            <div class="card-body p-4">
                                <a class="text-decoration-none link-dark stretched-link" href="/board/read?pno=${story.pno}">
                                    <div class="h5 card-title mb-3"><c:out value="${story.title}"/></div>
                                </a>
                            </div>
                            <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                <div class="d-flex align-items-end justify-content-between">
                                    <div class="d-flex align-items-center">
                                       <div class="small">
                                                <div class="fw-bold">${story.name}</div>
                                                <div class="text-muted">${story.pdate}</div>
                                            </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
             <!-- form 태그 --------------------------------------------------------------------------->
             <form id="actionForm" method="get">
             	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
             	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
             	<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'>
             	<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'>
             </form>
             <!-- form 태그.end -->
             
            <div class="row">
			    <div class="col-lg-6">
			        <!-- Search Form -->
			        <form id="searchForm" method="get" class="input-group mb-2">
			            <div class="input-group-prepend">
			                <select name="type" class="form-select form-control">
			                    <option value="T">제목</option> 
			                    <option value="C">내용</option> 
			                    <option value="W">작성자</option> 
			                    <option value="TC">제목&내용</option>                      				
			                </select> 
			            </div>
			            <input name="keyword" class="form-control">
			            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			            <button class="btn btn-outline-secondary" type="submit">Search</button>	            			
			        </form>
			        <!-- End Search Form -->
			    </div>
			    <div class="col-lg-6 text-end">
			        <!-- Paging -->
			        <ul class="pagination justify-content-end">
			            <c:if test="${pageMaker.prev}">
			                <li class="page-item paginate_button previous">
			                    <a class="page-link" href="${pageMaker.startPage-1}">Previous</a>
			                </li>
			            </c:if>
			            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			                <li class="page-item paginate_button ${pageMaker.cri.pageNum==num ? 'active' : ''}">
			                    <a class="page-link" href="${num}">${num}</a>
			                </li>
			            </c:forEach>
			            <c:if test="${pageMaker.next}">
			                <li class="page-item paginate_button next">
			                    <a class="page-link" href="${pageMaker.endPage+1}">Next</a>
			                </li>
			            </c:if>
			        </ul>
			        <!-- End Paging -->
			    </div>
			</div> 
            
             
            
            <%-- <div class="text-end mb-5 mb-xl-0">
                <c:if test="${pageMaker.next}">
                    <a class="text-decoration-none" href="your_jsp_page_url?page=${pageMaker.endPage + 1}">
                        More stories
                        <i class="bi bi-arrow-right"></i>
                    </a>
                </c:if>
            </div> --%>
        </div>
    </section>
</main>

<!-- Footer-->
<footer class="bg-dark py-4 mt-auto">
    <div class="container px-5">
        <div class="row align-items-center justify-content-between flex-column flex-sm-row">
            <div class="col-auto"><div class="small m-0 text-white">Copyright &copy; Your Website 2023</div></div>
            <div class="col-auto">
                <a class="link-light small" href="#!">Privacy</a>
                <span class="text-white mx-1">&middot;</span>
                <a class="link-light small" href="#!">Terms</a>
                <span class="text-white mx-1">&middot;</span>
                <a class="link-light small" href="#!">Contact</a>
            </div>
        </div>
    </div>
</footer>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<!--  <script src="js/scripts.js"></script> -->
<script>
    	$(document).ready(function(){	
    		var actionForm=$("#actionForm");
    		/* 페이지번호 event 처리 **********************************************************/    		
    		$(".paginate_button a").on("click",function(e){
    			e.preventDefault(); // 링크 클릭시 다른 페이지로 넘어가는 것 방지.
    			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
    			actionForm.submit();    			
    		});
    		
    		/* 제목 클릭시 event 처리 *********************************************************/
    		$(".move").on("click",function(e){
    			e.preventDefault(); // 링크 클릭시 다른 페이지로 넘어가는 것 방지.
    			actionForm.append("<input type='hidden' name='pno' value='"+$(this).attr("href")+"'>");
    			actionForm.attr("action","/board/main");
    			actionForm.submit();
    		});
    		
    		
    	});
    </script>

</body>
</html>
