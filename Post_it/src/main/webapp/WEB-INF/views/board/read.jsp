<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/resources/includes/header.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오케에에에이~ 레츠고오오오~</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Latest compiled JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
    	.empty-box {
        	height: 20px; /* 원하는 여백 크기로 조절하세요. */
    	}
    </style>
    
    <script>
 // checkPW() 내용
    function checkPW() {
    	// pno 파라미터 가져오기...
        var pno = '<c:out value="${postit.pno}"/>';
        console.log("메롱1" + pno); // pno는 불러와진다.
        
     	// 입력된 패스워드 가져오기
        var password = $("#passwordInput").val();
        console.log("메롱1" + password); // 입력한 패스워드

        // 서버로 데이터 전송
        $.ajax({
            type: "post",
            url: "/board/checkPW", // 컨트롤러
            data: {pno:pno, password:password},
            success: function (result) {
                window.location.href = result;
            },
            error: function (error) {
                console.log(error);
                // 오류
                alert("오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    }

    $(document).ready(function () {
        // 수정하기 버튼 클릭 시 모달창 보이기
        $("#modalModBtn").click(function () {
            $("#myModal").modal("show");
        });
        
     	// 모달창 닫기 버튼
        $("#modalCloseBtn").click(function () {
            $("#myModal").modal("hide");
        });
        
    });

    </script>
</head>

<body>
	<!-- 헤더 박스 ---------------------------------------------------------------------------------------------------------------------------------->
	

	<!-- 기사 정보 박스 ---------------------------------------------------------------------------------------------------------------------------------->
    <div class="container p-5">
        <div class="container px-5">
            <h2><strong>${postit.title}</strong></h2>
            <div class="row">
                <div class="col-8">
                    <p style="color: #aaaaaa; font-style: italic; font-size: small;">입력 : <fmt:formatDate pattern="yy-MM-dd HH:mm:ss" value="${postit.pdate}"/></p>
                    <p>${postit.name}</p>
                </div>
                <div class="col-4 text-end">
                    <button id="modalModBtn" type="button" class="btn btn-outline-secondary btn-sm" data-toggle="modal" data-target="#myModal">수정하기</button>
                </div>
            </div>
        </div>

		<!-- 이미지 박스 ---------------------------------------------------------------------------------------------------------------------------------->
        <div class="container-fluid mx-auto p-5">
            <svg xmlns="http://www.w3.org/2000/svg" class="d-block user-select-none mx-auto d-block" width="60%" height="400"
                aria-label="Placeholder: Image cap" focusable="false" role="img" preserveAspectRatio="xMidYMid slice"
                viewBox="0 0 318 180" style="font-size:1.125rem;text-anchor:middle">
                <rect width="100%" height="100%" fill="#868e96"></rect> <!-- 이미지 부분 -->
                <img src="../resources/upload/${postit.img}" alt="Ace Image">
            </svg>
        </div>

		<!-- 기사 내용 박스 ---------------------------------------------------------------------------------------------------------------------------------->
        <div class="container p-5">
            ${postit.pcontent}
        </div>
    </div>

    <!-- 비밀번호 확인 modal ----------------------------------------------------------------------------------------->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">비밀번호를 입력하세요</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>비밀번호를 입력해주세요</label>
                        <input id="passwordInput" class="form-control" name='password' value='password'>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id='modalRegisterBtn' type="button" class="btn btn-primary" onClick="checkPW()">제출</button>
                    <button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 푸터 박스 ---------------------------------------------------------------------------------------------------------------------------------->
  
    <div class="empty-box"></div>
    <%@ include file="/resources/includes/footer.jsp" %>


