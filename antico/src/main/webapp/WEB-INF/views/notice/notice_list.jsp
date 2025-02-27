<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	String ctxPath = request.getContextPath();
%>
<script src="https://kit.fontawesome.com/0c69fdf2c0.js" crossorigin="anonymous"></script>
<jsp:include page=".././header/header.jsp" />

<div class="container" style="padding: 30px; position: relative;">
	<h2 style="text-align: center;">고객센터</h2>
	
	<hr style="border: 1.5px solid black; width: 90%;">	
	
	<h3 style="width: 90%; margin: 0 auto 1% auto;">공지사항</h3>
	
	<div style="border: solid 1px black; padding: 0.5%; border-radius: 10px; width: 90%; margin: 0 auto 3% auto;">
		<form name="searchFrm" style="margin: 0; padding: 0;">
			<label style="margin: 0; padding: 0; width: 100%; display: flex;">
				<span style="padding: 1%;">
					<i class="fa-solid fa-magnifying-glass"></i>
				</span>
				&nbsp;&nbsp;
				<input type="text" name="searchWord" autocomplete="off" style="border: none; width: 100%; outline: none;" /> 
			</label>
		</form>
		<div id="displayList" style="border:solid 1px black; border-top:0px; height:100px; position: absolute; top:187px; left:84px; z-index: 999; background-color: #fff; border-radius: 0 0 10px 10px; width: 85.3%; padding-left: 50px;"></div>
	</div>
	
	
		
	<c:if test="${not empty requestScope.notice_list}">
	    <c:forEach var="NoticeVO" items="${requestScope.notice_list}" varStatus="status">
	        <ul style="padding: 0; margin: 0 auto 3% auto; width: 90%;">
	            <li style="list-style: none; width: 100%;">
	                <button class="noticelist" style="background-color: transparent; text-transform: none; border-width: 1px 0 1px; width: 100%; padding: 3% 0;">
	                    <span style="float: left; margin-left: 1%;">${NoticeVO.notice_title}</span>
	                    <i class="fa-solid fa-chevron-down" style="float: right; margin-right: 1%;"></i>
	                </button>
	                <div class="replylist" style="background-color: #eee; width: 100%; padding: 3% 0; display: none;">
	                    <span style="margin-left: 1%; display: block">${NoticeVO.notice_content}</span>
	
	                    <!-- 첨부파일이 있을 경우에만 표시 -->
	                    <c:if test="${not empty NoticeVO.notice_orgfilename}">
	                        <span style="margin-left: 1%; display: block">첨부파일: <a href="<%= ctxPath%>/notice/notice_download?notice_no=${NoticeVO.pk_notice_no}">${NoticeVO.notice_orgfilename}</a></span>
	                    </c:if>
	                </div>
	            </li>
	        </ul>
	    </c:forEach>
	</c:if>

	
	<c:if test="${empty requestScope.notice_list}">
		<ul style="padding: 0; margin: 0 auto 3% auto; width: 90%;">
			<li style="list-style: none; width: 100%;">
				<button style="background-color: transparent; text-transform: none; border-width: 1px 0 1px; width: 100%; padding: 3% 0;">
					<span style="float: left;">공지사항이 없습니다.</span>
				</button>
			</li>
		</ul>
	</c:if>
	<jsp:include page="../paging.jsp"></jsp:include>
	<div style="text-align: center; margin: 0 auto; width: 90%; padding: 2%;">
	    <!-- 1:1 문의 버튼 -->
	    <button class="inquire-add-btn" type="button" style="padding: 8px 0; width: 43%; background-color: #fff; border-width: 0.5px; border-radius: 5px; margin: 0 5px;">1:1 문의</button>
	    
	    <!-- 문의 내역 버튼 -->
	    <button class="inquire-list-btn" type="button" style="padding: 8px 0; width: 43%; background-color: #fff; border-width: 0.5px; border-radius: 5px; margin: 0 5px;">문의내역</button>
	</div>

</div>

<jsp:include page=".././footer/footer.jsp" />

<jsp:include page="../tab/tab.jsp"></jsp:include>

<script>
  $(document).ready(function() {
  	
	  // 페이징 처리 버튼 이벤트
      $(document).on("click", "a.page_button", function() {
         const page = $(this).data("page");
         const searchWord = $("input[name='searchWord']").val();
         const search_Word = searchWord ? "&searchWord=" + searchWord : "";

         location.href = "<%= ctxPath%>/notice/notice_list?cur_page="+ page + search_Word;
      });
	  
     $(".noticelist").click(function() {

         const $replyList = $(this).next(".replylist");

         $(".replylist").not($replyList).slideUp();

         $replyList.stop(true, true).slideToggle();

     });
  	
     // 1:1 문의 버튼 클릭
     $(".inquire-add-btn").on("click", function() {
         showinquireaddTab();
     });

     // 문의내역 버튼 클릭
     $(".inquire-list-btn").on("click", function() {
         showinquirelistTab();
     });
      
    // 검색 엔터기능
    $("input:text[name='searchWord']").bind("keyup", function(e){
	   if(e.keyCode == 13){ // 엔터를 했을 경우
		   goSearch();
	   }
    });
      
    $("div#displayList").hide();
  
	$("input[name='searchWord']").keyup(function(){

	const wordLength = $(this).val().trim().length;
	// 검색어에서 공백을 제거한 길이를 알아온다.

	 if(wordLength == 0) {
	  	$("div#displayList").hide();
	    // 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다. 
	 } 
	 else {			
		   $.ajax({
			   url:"<%= ctxPath%>/notice/notice_searchshow",
				   type:"get",
				   data:{"searchWord":$("input[name='searchWord']").val()},
				   dataType:"json",
				   success:function(json){						
			
					   if(json.length > 0){
						   // 검색된 데이터가 있는 경우임.
						   
						   let v_html = ``;
						   
						   $.each(json, function(index, item){
							   const word = item.word;
			
						       const idx = word.toLowerCase().indexOf($("input[name='searchWord']").val().toLowerCase());
							
						       const len = $("input[name='searchWord']").val().length; 
						
						       const result = word.substring(0, idx) + "<span style='color:#0DCC5A;'>"+word.substring(idx, idx+len)+"</span>" + word.substring(idx+len); 
						       
							   v_html += `<span style='cursor:pointer;' class='result'>\${result}</span><br>`;
							   
						   }); // end of $.each(json, function(index, item){})-----------
						   
						   const input_width = $("input[name='searchWord']").css("width"); // 검색어 input 태그 width 값 알아오기  
						   
						   $("div#displayList").html(v_html).show();
					   }
				   },
				   error: function(error){
					   alert("실패");
				   }    
			   	});
			 }
		});// end of keyup
	   	   
		$(document).on("click", "span.result", function(e){
			   const word = $(e.target).text();
			   $("input[name='searchWord']").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			   $("div#displayList").hide();
			   goSearch();
		});
	   
	}); // end of document

	// 문의내역 확인 함수
	function showinquirelistTab() {
		var tabTitle = "문의내역";
		
		$.ajax({
			url : "<%=ctxPath%>/inquire/inquire_list",
			success : function(html) {
				openSideTab(html, tabTitle);
			},
			error : function(e) {
				console.log(e);
				alert("불러오기 실패");
				closeSideTab();
			}
		});
	}

	// 1:1문의 작성하는 함수
	function showinquireaddTab() {
		var tabTitle = "1:1 문의";
		
		$.ajax({
			url : "<%=ctxPath%>/inquire/inquire_add",
			cache: false,
			success : function(html) {
				openSideTab(html, tabTitle);
			},
			error : function(e) {
				console.log(e);
				alert("불러오기 실패");
				closeSideTab();
			}
		});
	}

	function goSearch() {
	   const frm = document.searchFrm;
	   frm.method = "get";
	   frm.action = "<%= ctxPath%>/notice/notice_list";
	   frm.submit();
	}// end of function goSearch()-----------------
  
</script>
