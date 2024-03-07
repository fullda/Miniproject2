<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/resources/includes/header.jsp"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- jQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
  
	
    <style>
        .header {
            height: 100px;
            padding: 15px 0;
            margin-bottom: 50px;
            text-align: left;
            line-height: 60px;
            padding-left: 80px;
            font-size: xx-large;
        }

        .footer {
            height: 100px;
            padding: 0 15px;
            margin-top: 100px;
        }

        #formFile {
            margin-bottom: 10px;
        }

        #preview-container {
            margin-bottom: 10px;
        }

        #preview {
            max-width: 100%;
            height: auto;
            border: 1px solid #ccc;
            padding: 10px;
            display : none; /* 이미지 선택 전에는 숨김 처리 */
        }
        .empty-box {
        	height: 20px; /* 원하는 여백 크기로 조절하세요. */
    	}
    </style>
</head>

<body>
    <div class="container mt-3">
          <form action="/board/update" method="post">
	                    <input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                   		<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount}"/>'>
                   		<input type="hidden" id="keyword" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                   		<input type="hidden" id="type" name="type" value='<c:out value="${cri.type}"/>'>
                   		<input type="hidden" id="cno" name="cno" value='<c:out value="${board.cno}"/>'>
            <fieldset>
            	<div class="form-group">
                   	<lable>no</lable>
                   	<input class="form-control" name="pno" value='<c:out value="${board.pno}"/>' readonly>
	            </div> 
                <!-- 제목 불러오기 필드 -->
                <div class="mb-3">
                    <label for="InputTitle" class="form-label">Title</label>
                    <input class="form-control" name="title" value='<c:out value="${board.title}"/>'>    
                </div>
                <!-- 작성자 입력 필드 -->
                <div class="mb-3">
                    <label for="InputId" class="form-label">Writer</label>
                    <input class="form-control" name="name" value='<c:out value="${board.name}"/>'>
                </div>
                <!-- 비밀번호 입력 필드 -->
                <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label">Password</label>
                    <input class="form-control" type="password" name="password" value='<c:out value="${board.password}"/>'>
                </div>
                <!-- 이미지 미리보기 -->
                <div id="preview-container" class="mb-3">
                    <img class="img-fluid" id="preview" src="#" alt="Image Preview" />
                </div>
                <!-- 내용 입력 필드 -->
                <div class="mb-3">
                    <label for="editor" class="form-label">Content</label>
                    <textarea class="form-control" rows="10" name="pcontent"><c:out value="${board.pcontent}"/></textarea>
                </div>
                <!-- 파일 선택(input type="file") -->
                <div class="mb-3">
                    <label for="formFile" class="form-label">File input</label>
                    <input class="form-control" type="file" id="formFile" name="img">
                    <!--  <%=request.getRealPath("/") %> -->
                </div>
                <div class="mb-3">
	                <label>RegDate</label>
	                <input class="form-control" name="pdate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.pdate}" />' readonly>
	            </div>
                <div class="mb-3">
               		<label>updateDate</label>
               		<input class="form-control" name="updatedate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updatedate}" />' readonly>
               	</div>
                <!-- 버튼 -->
                <button data-oper="update" class="btn btn-primary custom-button">수정하기</button>
               	<button data-oper="remove" class="btn btn-primary custom-button">삭제하기</button>
               	<button data-oper="list" class="btn btn-primary custom-button">메인</button> 
                <!-- 버튼 -->
                <a href="javascript:history.back();" class="btn btn-primary custom-button" id="btnList">Cancel</a>
            </fieldset>
        </form>
    </div>
    <!-- 페이지 푸터 -->
    <div class="empty-box"></div>
	<%@ include file="/resources/includes/footer.jsp" %>
    
    
    
   
    
    
    
    <script>
    $(document).ready(function(){
		var formObj=$("form"); // form태그 찾기
		$("button").on("click",function(e){
			e.preventDefault(); // submit방지
			
			var operation=$(this).data("oper"); // event가 발생한 버튼의 data-oper속성의 값을 구하기
			console.log(operation);
		
			if(operation==='remove'){
				
				formObj.attr("action","/board/remove"); //삭제처리
			}else if(operation==="list"){
				formObj.attr("action","/board/main").attr("method","get"); //목록으로   
				
				//hidden 태그를 복제해 둔다.
				var pageNumTag=$("input[name='pageNum']").clone();
				var amountTag=$("input[name='amount']").clone();
				var keywordTag=$("input[name='keyword']").clone();
				var typeTag=$("input[name='type']").clone();
				
				//form태그의 모든 태그를 삭제한다.
				formObj.empty();
				
				//form태그에 복제해 둔 hidden태그를 다시 추가
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}
			
			formObj.submit();//전송
		});
	});

        // 이미지 미리보기 함수
        function readURL(input) {
            // 파일이 선택되었고, 해당 파일이 존재한다면
            if (input.files && input.files[0]) {
                // FileReader 객체 생성
                var reader = new FileReader();
                // 파일 읽기가 완료되었을 때의 이벤트 처리
                reader.onload = function (e) {
                    // 이미지 미리보기의 src 속성에 읽은 파일의 결과물 할당
                    $('#preview').attr('src', e.target.result);
                    // 이미지 미리보기 영역 보이기
                    $('#preview').show();
                }
                // 파일을 읽어 data URL 형태로 변환
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>