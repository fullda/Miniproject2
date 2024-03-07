<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/resources/includes/header.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>오케에에에이~ 레츠고오오오~</title>
<script type="text/javascript" src="/resources/js/reply.js"></script>
<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
 <!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script> 
	<!-- bootstrap -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


</head>
<style>
.empty-box {
	height: 20px; /* 원하는 여백 크기로 조절하세요. */
}
.left.clearfix {
    list-style-type: none;
    border-bottom: 1px solid #ddd;
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 5px;
}

.left.clearfix:last-child {
    border-bottom: none;
    margin-bottom: 0;
}

.left.clearfix .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 5px;
}

.left.clearfix .header strong {
    color: #333;
    font-weight: bold;
    margin-right: 10px;
}

.left.clearfix .header small {
    color: #999;
}

.left.clearfix p {
    color: #666;
}

.left.clearfix p:last-child {
    margin-bottom: 0;
}

.left.clearfix hr {
    margin: 10px 0;
    border: none;
    border-top: 1px solid #ddd;
}
.left.clearfix:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    background-color: #f0f0f0;
}

.btn:hover{
    transform: scale(1.3);
}


</style>

<script>
    /*리스트 출력******************************************************************************************************************/
	  
	function showList(page){
		var pnoValue ='<c:out value="${postit.pno}"/>'; //부모글번호
			console.log("show list" + page+"   "+ pnoValue);
		replyService.getList({pno:pnoValue , page:page||1},function(replyCnt,list){
			//page가 -1이면 마지막 페이지로 이동
			/* if(page == -1){
				replyPageNum=Math.ceil(replyCnt/10.0);
				showList(replyPageNum);
				return;
			}  */
			
			 var str="";
		       if(list == null || list.length == 0){
		       
		        $(".chat").html("");
		        
		        return;
		      }
    		for(var i = 0, len = list.length || 0 ; i<len; i++){
    			str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
    			str +="  <div><div class='header'><strong class='primary-font'>["
    				+list[i].rno+"] "+list[i].name+"</strong>";
    			str +="    <small class='pull-right text-muted'>"
    				+replyService.displayTime(list[i].rdate)+"</small></div>";
    			str +="    <p>"+list[i].rcontent+"</p></div></li><hr/>";
    		
    		}
    		$(".chat").append(str);
    		if (list.length < 10) { // 한 페이지당 댓글 개수가 10개 미만이면 더 이상 페이지를 넘기지 않음
                $("#plusReplyBtn").hide(); // 더 보기 버튼 숨기기
            }
    		
    		 /*  showReplyPage(replyCnt,page);   */
    	});
	}
	/*더보기 추가후 리스트출력*************************************************************************************************************/
	
	
	  
	/*리스트 출력 끝******************************************************************************************************************/
	
	/*페이징 리스트 출력  ******************************************************************************************************************/
	function showReplyPage(replyCnt,replyPageNum){
		console.log("replyCnt ...... "+replyCnt);
		
		var endNum=Math.ceil(replyPageNum/10.0)*10; // 1.2.3 ... 10에서 10
		var startNum=endNum-9; // 1.2.3 ... 10에서 1. 10-9==1
		var prev=startNum!=1; //previous유무
		var next=false; //next유무
		// 댓글갯수가 endNum*10보다 작을 때(실제끝페이지가 계산으로 구한 마지막페이지보다 작을 때)
		if(endNum*10>=replyCnt){
			endNum=Math.ceil(replyCnt/10.0);//마지막페이지 변경
		}
		// 댓글갯수가 endNum*10보다 크면 next존재
		if(endNum*10<replyCnt){
			next=true;
		}
		var str="<ul class='pagination pull-right' style='margin:0 !important'>";
		if(prev){
			str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
		}
		for(var i=startNum;i<=endNum;i++){
			var active=replyPageNum==i?"active":""; // page번호가 현재페이지 이면 active 설정
			str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}
		if(next){
			str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
		}
		str+=" </ul>";
		$(".panel-footer").html(str);
	}
	
	/*페이징 리스트 출력 끝******************************************************************************************************************/
    
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
        var replyModal = $("#replyModal"); // 모달창
	    var modalInputname = replyModal.find("input[name='name']"); // 이름 입력란
	    var modalInputPassword = replyModal.find("input[name='password']"); // 비밀번호 입력란
	    var modalInputrcontent = replyModal.find("textarea[name='rcontent']"); // 댓글 입력란
	    var modalInputrdate = replyModal.find("input[name='rdate']"); // 작성일 입력란  
	    var modaltime = replyModal.find("#time"); //작성일 전체 칸
	    
	    var writeReplyBtn = $("#writeReplyBtn"); // 등록 버튼
	    var updateReplyBtn = $("#updateReplyBtn"); //수정버튼
	    var deleteReplyBtn = $("#deleteReplyBtn"); //삭제버튼
	    var modalRegisterBtn = $("#modalRegisterBtn"); //등록버튼 
	    var replyPageNum = 1; //페이지 기본값
    	var pnoValue ='<c:out value="${postit.pno}"/>'; //부모글번호
    
    	 showList(replyPageNum);
    	 
  
	    
	    
	     
		/* 댓글 작성 버튼 이벤트 처리 ************************************************************************************************************************************/
	
		$("#addReplyBtn").on("click", function(e){
			e.preventDefault();
		    modalInputname.val(""); // 이름 입력란 초기화
		    modalInputPassword.val(""); // 비밀번호 입력란 초기화
		    modalInputrcontent.val(""); // 댓글 입력란 초기화
		    modaltime.hide(); // 안보이게
		    modalInputrdate.removeAttr("readonly");
		    
		    replyModal.find(".modal-title").text("REPLY"); // 모달 제목 설정
		    replyModal.find("button[id!='closeReplymodal']").hide(); // close버튼만 남겨두고 모든 버튼 안보이게.
		    writeReplyBtn.show(); // 등록 버튼 표시
		    $("#showPasswordBtn").show();
		    console.log(replyModal);
		     replyModal.modal("show"); // 모달 표시 
		});
		/* 댓글 작성 버튼 이벤트 처리  끝************************************************************************************************************************************/
		
		/*모달창 닫기버튼 이벤트 처리 **************************************************************************************************************************************/
		 $("#closeReplymodal").on("click" , function(){
			 replyModal.modal("hide");
		});
		/*모달창 닫기버튼 이벤트 처리 끝**************************************************************************************************************************************/
		
		/* 비밀번호 표시 이벤트***********************************************************************************************************************************************/
		$("#showPasswordBtn").on("click", function() {
			var passwordInput = $("#passwordInput");
			var passwordBtn = $(this);

				if (passwordInput.attr("type") === "password") {
   				passwordInput.attr("type", "text");
    			passwordBtn.text("숨기기");
				} else {
    			passwordInput.attr("type", "password");
    			passwordBtn.text("확인");
			}
			});
		/* 비밀번호 표시 이벤트 끝***********************************************************************************************************************************************/
		
		
		/*모달창 댓글 등록 버튼 이벤트처리******************************************************************************************************************************************/
	   writeReplyBtn.on("click",function(){
			var reply={
				pno:parseInt(pnoValue),
				rcontent:modalInputrcontent.val(),
				name:modalInputname.val(),
				password:modalInputPassword.val()
			};
			replyService.add(reply,function(result){
				alert("댓글이 등록되었습니다"); // controller에서 전달된 'success' 출력
				replyModal.find("input").val(""); // input태그 초기화
				replyModal.find("textarea").val(""); // input태그 초기화
				replyModal.modal("hide"); // modal창 안보이게
				$(".chat").html("");
				showList(1); // 댓글목록 갱신 
			});  
				//location.reload(true); // 강제 새로고침
		});  
		/*모달창 댓글 등록 버튼 이벤트처리 끝******************************************************************************************************************************************/
	
		
		/*댓글목록 이벤트처리*****************************************************************************************************************************************/
		$(".chat").on("click","li",function(e){
			var rno=$(this).data("rno");
			replyService.get(rno,function(reply){
				modalInputrcontent.val(reply.rcontent);
				modalInputname.val(reply.name);
				modalInputPassword.val("");
				modaltime.show();
				console.log(reply.rdate);
				modalInputrdate.val(replyService.displayTime(reply.rdate)).attr("readonly","readonly");
				replyModal.data("rno",reply.rno);//댓글번호. data-rno 생성됨
				
				replyModal.find("button[id!='closeReplymodal']").hide();
				updateReplyBtn.show();
				deleteReplyBtn.show();
				$("#showPasswordBtn").show();
				$("#replyModal").modal("show");
			});    			
		});
		/*댓글목록 이벤트처리 끝******************************************************************************************************************************************/
	
		/* 댓글 수정버튼 이벤트처리****************************************************************************************************************************************/
		updateReplyBtn.on("click",function(){
			var reply={rno:replyModal.data("rno"),rcontent:modalInputrcontent.val(),name:modalInputname.val(),password:modalInputPassword.val()};
			replyService.update(reply,function(result){
				alert("댓글이 수정되었습니다!");
				replyModal.modal("hide");
				$(".chat").html("");
				showList(1);
				//location.reload(true); // 강제 새로고침
			});
		})
		
		/* 댓글 수정버튼 이벤트처리  끝 ****************************************************************************************************************************************/
		
		/* 댓글 삭제 버튼 이벤트처리 *************************************************************************/
		deleteReplyBtn.on("click",function(){    
			var rno=replyModal.data("rno");
			replyService.remove(rno,function(result){
				alert("댓글이 삭제되었습니다!");
				replyModal.modal("hide");
				$(".chat").html("");
				showList(replyPageNum);
			});
		})
		/* 댓글 삭제 버튼 이벤트처리 끝*************************************************************************/
		
		/* 더보기버튼 event 처리*******************************************************************************************/
		// delegate.위임. li a 가 아직 생성되지 않아서 부모에게 event처리 위임
	/* 	$(".panel-footer").on("click","li a",function(a){
			a.preventDefault(); // 클릭시 다른 페이지로 이동 방지.
			var targetPageNum=$(this).attr("href");
			replyPageNum=targetPageNum;
			showList(replyPageNum);
		}); */
		$("#plusReplyBtn").on("click", function() {
		    replyPageNum++; // 페이지 번호 증가
		    showList(replyPageNum); // 추가 댓글 로드
		});
		
		/* 더보기버튼 event 처리 끝*******************************************************************************************/
    });

    </script>
</head>

<body>
	<!-- 헤더 박스 ---------------------------------------------------------------------------------------------------------------------------------->


	<!-- 기사 정보 박스 ---------------------------------------------------------------------------------------------------------------------------------->
	<div class="container p-5">
		<div class="container px-5">
			<h2>
				<strong>${postit.title}</strong>
			</h2>
			<div class="row">
				<div class="col-8">
					<p style="color: #aaaaaa; font-style: italic; font-size: small;">
						입력 :
						<fmt:formatDate pattern="yy-MM-dd HH:mm:ss"
							value="${postit.pdate}" />
					</p>
					<p>${postit.name}</p>
				</div>
				<div class="col-4 text-end">
					<button id="modalModBtn" type="button"
						class="btn btn-outline-secondary btn-sm" data-toggle="modal"
						data-target="#myModal">수정하기</button>
				</div>
			</div>
		</div>

		<!-- 이미지 박스 ---------------------------------------------------------------------------------------------------------------------------------->
		<div class="container-fluid mx-auto p-5">
			<svg xmlns="http://www.w3.org/2000/svg"
				class="d-block user-select-none mx-auto d-block" width="80%"
				height="500" aria-label="Placeholder: Image cap" focusable="false"
				role="img" preserveAspectRatio="xMidYMid slice"
				viewBox="0 0 318 180"
				style="font-size: 1.125rem; text-anchor: middle">
                <image href="/resources/upload/${postit.img}" width="100%" height="100%" preserveAspectRatio="none"/>
            </svg>
                
		</div>

		<!-- 기사 내용 박스 ---------------------------------------------------------------------------------------------------------------------------------->
		<div class="container p-5">${postit.pcontent}</div>
	</div>

	<!-- 비밀번호 확인 modal ----------------------------------------------------------------------------------------->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">비밀번호를 입력하세요</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>비밀번호를 입력해주세요</label> 
						<input id="passwordInput" class="form-control" name='password' placeholder='비밀번호를 입력하세요' required>
					</div>
				</div>
				<div class="modal-footer">
					<button id='modalRegisterBtn' type="button" class="btn btn-primary"
						onClick="checkPW()">제출</button>
					<button id='modalCloseBtn' type="button" class="btn btn-default"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 댓글 목록 ----------------------------------------------------------------------------------------------->
	<section class="mx-auto mb-5" style="width: 60%;">
		<div class="card bg-light">
			<div class="card-body">
				<!-- Comment form-->
				<div class="mb-4">

					<button id="addReplyBtn" class="btn btn-secondary btn-sm float-end" style="margin: 2px 2px 2px 2px ;" data-toggle="modal" data-target="#myModal">댓글작성</button>
                        <br>
                        <hr style="border: 0; height: 2px; background-color: #333; margin: 10px 0;">
					<ul class="chat">

					</ul>
				</div>
				<div class="panel-footer" style="height: 50px;">
					<button id="plusReplyBtn"
						class="btn btn-secondary btn-sm float-end" style="margin: 3px;">더보기</button>
				</div>
			</div>
		</div>
	</section>
	<!-- 댓글 목록.end ----------------------------------------------------------------------------------------------->
	<!-- 모달창 ---------------------------------------------------------------------->

	<!-- Modal ---------------------------------------------------------------------------------------------->
	<div class="modal fade" id="replyModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header bg-dark text-light">
					<h5 class="modal-title" id="exampleModalLabel">REPLY</h5>
					<button type="button" class="close text-light" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>

						<div class="form-group">
							<label class="col-form-label text-dark">이름:</label> <input
								class="form-control" name='name' value='작성자를 작성해주세요' />
						</div>
						<div class="form-group">
							<label class="col-form-label text-dark">비밀번호:</label>
							<div class="input-group">
								<input type="password" class="form-control" id="passwordInput"
									name="password" value="비밀번호를 작성해주세요">
								<div class="input-group-append">
									<button class="btn btn-secondary"
										style="display: block !important" type="button"
										id="showPasswordBtn">확인</button>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="col-form-label text-dark">댓글:</label>
							<textarea class="form-control" name='rcontent' value='댓글을 작성해주세요'></textarea>
						</div>
						<div id="time" "class="form-group">
							<label class="col-form-label text-dark">작성일</label> <input
								class="form-control" name='rdate' value='2018-01-01 13:13'></input>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button id='writeReplyBtn' type="button" class="btn btn-warning">등록</button>
					<button id='deleteReplyBtn' type="button" class="btn btn-danger">삭제</button>
					<button id='updateReplyBtn' type="button" class="btn btn-primary">수정</button>
					<button id='closeReplymodal' type="button"
						class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달창  end---------------------------------------------------------------------->
	<!-- 푸터 박스 ---------------------------------------------------------------------------------------------------------------------------------->

	<div class="empty-box"></div>
	<%@ include file="/resources/includes/footer.jsp"%>