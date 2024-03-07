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
         <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/board/register">
            <fieldset>
                <!-- 제목 입력 필드 -->
                <div class="mb-3">
                    <label for="InputTitle" class="form-label">Title</label>
                    <input type="text" class="form-control" id="InputTitle" placeholder="제목을 입력해주세요" autocomplete="off"
                        name="title">
                </div>
                <!-- 작성자 입력 필드 -->
                <div class="mb-3">
                    <label for="InputId" class="form-label">Writer</label>
                    <input type="text" class="form-control" id="InputId" placeholder="작성자" autocomplete="off" name="name">
                </div>
                <!-- 비밀번호 입력 필드 -->
                <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label">Password</label>
                    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password"
                        autocomplete="off" name="password">
                </div>
                <!-- 내용 입력 필드 -->
                <div class="mb-3">
                    <label for="editor" class="form-label">Content</label>
                    <textarea class="form-control" id="content" rows="10" name="pcontent"></textarea>
                </div>
                <!-- 이미지 미리보기 -->
                <div id="preview-container" class="mb-3" style="width:400px; height:300px; overflow: hidden;">
                	
                    	<img class="img-fluid"  id="preview" />
                   
                </div>
                <!-- 파일 선택(input type="file") -->
                <div class="mb-3">
                    <label for="formFile" class="form-label">File input</label>
                    <input class="form-control" type="file" multiple="multiple" id="formFile" name="img">
                </div>

                
                
                <!-- 제출 버튼 -->
                <button type="submit" class="btn btn-secondary">Submit</button>
                <!-- 취소 버튼 -->
                <a href="javascript:history.back();" class="btn btn-secondary custom-button" id="btnList">Cancel</a>
                <div class="empty-box"></div>
            </fieldset>
        </form>
    </div>


<!-- 이미지 미리보기 처리를 위한 JavaScript -->
<script>
    // 문서가 로드된 후 실행
    $(document).ready(function () {
        // 파일 입력에 변화가 있을 때의 이벤트 처리
        $("#formFile").change(function () {
            // 이전에 선택한 이미지의 프리뷰를 모두 제거
            $('#preview-container').empty();

            // 선택된 이미지를 저장할 배열
            var selectedImages = [];

            // 최대 5개까지만 선택하도록 체크
            for (var i = 0; i < Math.min(this.files.length, 5); i++) {
                // 이미지 미리보기 함수 호출
                readURL(this.files[i], selectedImages);
            }

            // 이미 선택된 이미지의 개수가 5개 미만일 경우 나머지 히든 인풋 태그에 null 값 설정
            for (var i = this.files.length; i < 5; i++) {
                selectedImages.push(null);
            }
            
            // 히든 인풋 태그에 값 설정
            for (var i = 0; i < 5; i++) {
                $('<input>').attr({
                    type: 'hidden',
                    name: 'img' + (i + 1),
                    value: selectedImages[i]
                }).appendTo('#preview-container');
            }
        });
    });

    // 이미지 미리보기 함수
    function readURL(file, selectedImages) {
        // FileReader 객체 생성
        var reader = new FileReader();
        // 파일 읽기가 완료되었을 때의 이벤트 처리
        reader.onload = function (e) {
            // 새로운 이미지 요소를 만들어 속성 설정
           var img = $('<img>').attr('src', e.target.result).addClass('img-fluid')
           .css({'width': '100%','height': '100%','object-fit':'cover'});
            // 이미지의 이름을 히든으로 추가
            var hiddenInput = $('<input>').attr({
                type: 'hidden',
                name: 'img' + (selectedImages.length + 1),
                value: file.name
            });
            // 새로운 미리보기 칸을 만들어 이미지와 히든을 추가
            var previewContainer = $('<div>').addClass('mb-3').append(img).append(hiddenInput);
            // 이미지 미리보기 영역에 추가
            $('#preview-container').append(previewContainer);
            // 이미지 파일 이름을 selectedImages 배열에 저장
            selectedImages.push(file.name);
        }
        // 파일을 읽어 data URL 형태로 변환
        reader.readAsDataURL(file);
    }
</script>
</body>
<%@ include file="/resources/includes/footer.jsp" %>
