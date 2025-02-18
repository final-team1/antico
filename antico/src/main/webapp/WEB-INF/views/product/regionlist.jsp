<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

div.search_container {
    position: relative;
    width: 100%;
}

input#search_word {
    width: 100%;
    padding: 10px;
    height: 40px;
    border: 1px solid #cccccc;
    border-radius: 6px;
    font-size: 14px;
}

#search_btn {
    position: absolute;
    right: 10px; /* 오른쪽 정렬 */
    height: 40px;
    border: none;
    background: none;
    cursor: pointer;
}

span.result {
	display: inline-block;
	width: 100%;
	font-size: 20px;
	margin-bottom: 15px;
}


/* sidetab 스크롤 */
div#sidetab_content {
	overflow-y: auto;   	/* 내부 스크롤 활성화 */
    scrollbar-width: none;	/* 스크롤 감추기 */
}


</style>


<br>
<br>
  
<div class="search_container">
    <input type="text" id="search_word" name='search_word' autocomplete="off" placeholder="지역(읍, 면, 동)을 검색해 주세요.">
    <input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%>
    <button id="search_btn">
        <i class="fa-solid fa-magnifying-glass fa-xs"></i>
    </button>
    
    <br>
    <br>
    
    <div id="search_result"></div>
</div>



<script type="text/javascript">

$(document).ready(function(){

	// 지역 검색 입력 시 자동글 완성하기 시작 //
	$("div#search_result").hide();

	$("input[name='search_word']").on("keyup", function(){
		
		// 검색어에서 공백을 제거한 길이를 알아온다.
		const word_length = $(this).val().trim().length;
		
		// 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다. 
	    if(word_length == 0) {
		    $("div#search_result").hide();
		   
	    }
	    else {
	    	
	    	$.ajax({
	    		url:"<%= ctxPath%>/product/region_search",
	    		type:"get",
	    		data:{"search_word":$("input[name='search_word']").val()},
	    		dataType:"json",
	    		success:function(json){
					// console.log(JSON.stringify(json));
					
					let v_html = ``;
					
					if(json.length > 0) { // 검색된 데이터가 있는 경우에
					
					
						$.each(json, function(index, item){
						   const word = item.word;				   // 검색어
						   const fk_region_no = item.fk_region_no; // 지역 번호 가져오기
						   const region_town = item.region_town;   // 읍면동 가져오기
						   
						   const idx = word.indexOf($("input[name='search_word']").val());
						   const len = $("input[name='search_word']").val().length;
			               
						   const result = word.substring(0, idx) + "<span style='color:#0dcc5a;'>"+ word.substring(idx, idx+len)+"</span>" + word.substring(idx+len);
						   
			               v_html += `<span style='cursor:pointer;' class='result' data-region-no='\${fk_region_no}' data-region-town='\${region_town}' >\${result}</span><br>`;

						});
  					   
					}
					else {
						v_html = "<span style='display: block; text-align: center;'>검색결과가 없습니다.</span>";  // 결과가 없으면 "데이터가 없습니다." 메시지 표시
					}
					
					 $("div#search_result").html(v_html).show();
	    		},
	    		error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				} 
	    		
	    	}); // end of $.ajax
	    	
	    }

	}); // end of $("input[name='search_region']").on("keyup", function()
	// 지역 검색 입력 시 자동글 완성하기 끝 //
	
	
	// 지역 검색 시 검색된 주소를 클릭 할 경우
    $(document).on("click", "span.result", function(e){
		
    	let fk_region_no = $(this).data("region-no");   // 'data-region-no' 값 가져오기
		// alert(fk_region_no);
    	let region_town = $(this).data("region-town");; // 'data-region-town' 값 가져오기
    	
	    // AJAX를 사용하여 부모 페이지(add)로 fk_region_no를 전송
	    $.ajax({
	        url: "<%= ctxPath %>/product/add",
	        type: "get",
	        data: { "fk_region_no": fk_region_no,
	        	    "region_town":region_town},
	        success: function(response) {
	        	// console.log("성공: ", response);
	        	$("input.town_name").css({"visibility":"visible"});
	        	$("input.town_name").val(region_town);
	        	$("input#fk_region_no").val(fk_region_no);
	        },
	        error: function(request, status, error) {
	        	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
	    });
	    
	    closeSideTab(); // 사이드바 닫기
	   	
    });
	
	

}); // end of $(document).ready(function()

</script>