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

button#search_btn {
    position: absolute;
    right: 10px; /* 오른쪽 정렬 */
    height: 40px;
    border: none;
    background: none;
    cursor: pointer;
}

/* 현재 내 위치 관련 박스 */
button#get_lat_lng {
	margin-top: 15px;
	width: 100%;
	height: 40px;
	border: none;
	border-radius: 6px;
	background-color: #0DCC5A;
	position: absolute;
	color: white;
	font-size: 14px;
}


i#get_lat_lng_icon {
	margin-right: 10px;
	color: white;
	font-size: 14px;
}


i#loading {
	margin-top: 10px;
	color: #0DCC5A;
	font-size: 24pt;
	display: inline-block;
    text-align: center;
    width: 100%; /* 가로 중앙 정렬 */
}


/* 동네 검색 창 박스 */
div#search_result {
	margin-top: 20px;
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
    
    <div id="get_lat_lng_container">
    	<button id="get_lat_lng"><i id="get_lat_lng_icon" class="fa-solid fa-location-crosshairs"></i>현재 내 위치 사용하기</button>
    </div>
    
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
						   const region_lat = item.region_lat; 	   // 위도 값 가져오기 
						   const region_lng = item.region_lng;	   // 경도 값 가져오기
						   
						   const idx = word.indexOf($("input[name='search_word']").val());
						   const len = $("input[name='search_word']").val().length;
			               
						   const result = word.substring(0, idx) + "<span style='color:#0dcc5a;'>"+ word.substring(idx, idx+len)+"</span>" + word.substring(idx+len);
						   
			               v_html += `<span style='cursor:pointer;' class='result' data-region-no='\${fk_region_no}' data-region-town='\${region_town}' data-region-lat='\${region_lat}' data-region-lng='\${region_lng}' >\${result}</span><br>`;

						});
  					   
					}
					else {
						v_html = "<span style='display: block; text-align: center;'>검색결과가 없습니다.</span>";  // 결과가 없으면 "데이터가 없습니다." 메시지 표시
					}
					
					 $("div#search_result").html(v_html).show();
	    		},
	    		error: function(request, status, error){
	    			errorHandler(request, status, error);
				} 
	    		
	    	}); // end of $.ajax

	    }

	}); // end of $("input[name='search_region']").on("keyup", function()
	// 지역 검색 입력 시 자동글 완성하기 끝 //
	
	
	// 현재 내위치로 검색하기 클릭하면
	$("button#get_lat_lng").click(function(){
		
		$("input[name='search_word']").val("");
		
		if(navigator.geolocation) { // 브라우저가 해당 기능을 지원한다면
			navigator.geolocation.getCurrentPosition(function (position) {
				const current_lat = position.coords.latitude;
				const current_lng = position.coords.longitude;
				
				// console.log("현재 위치:", current_lat, current_lng);
				
				
				
				 // 기존 검색 결과를 지우고 로딩 메시지 표시
            	$("div#search_result").html("<i id='loading' class='fa-solid fa-spinner fa-spin fa-spin-reverse'></i>").show();
				
				$.ajax({
					url:"<%= ctxPath %>/product/near_region",
					type:"get",
					data:{"current_lat" : current_lat,
						  "current_lng" : current_lng},
					dataType:"json",
					success: function(json) {
						// console.log("가장 가까운 동네 5개:", json);
						
						let v_html = ``;
						
						if (json.length > 0) { // 검색된 데이터가 있는 경우에
							$.each(json, function(index, item){
								   const pk_region_no = item.pk_region_no; // 지역번호
								   const region_state = item.region_state; // 시도
				               	   const region_city = item.region_city;   // 시군구
				                   const region_town = item.region_town;   // 읍면동
				                   const region_lat = item.region_lat;     // 위도 값
				                   const region_lng = item.region_lng;     // 경도 값
				                   const distance = item.distance;         // 현재 위치와의 거리
								       
								   const result = region_state + "&nbsp;" + region_city + "&nbsp;<span style='color:#0dcc5a;'>"+ region_town+"</span>";
								   
					               v_html += `<span style='cursor:pointer;' class='result' data-region-no='\${pk_region_no}' data-region-town='\${region_town}' data-region-lat='\${region_lat}' data-region-lng='\${region_lng}' >\${result}</span><br>`
							});
						}
						else {
							v_html = "<span style='display: block; text-align: center;'>검색결과가 없습니다.</span>";  // 결과가 없으면 "데이터가 없습니다." 메시지 표시
						}
						
						
	                    setTimeout(function(){
	                        $("div#search_result").html(v_html).show();
	                    }, 1000);
						
						
					},
			        error: function(request, status, error) {
			        	errorHandler(request, status, error);
			        }
				});
				
			},
			function(error) {
				console.log(error);
				showAlert('error', '위치 정보를 가져오는 중 오류가 발생했습니다.');
			}, 
			{
				enableHighAccuracy: true,
				timeout: 30000,
				maximumAge: 0
			});
		}
		else {
			showAlert('error', '해당 기능을 지원하지 않는 브라우저입니다.');
		}
		
		
	}); // end of $("button#get_lat_lng").click(function()
	
	
	
	
	// 지역 검색 시 검색된 주소를 클릭 할 경우
    $(document).on("click", "span.result", function(e){
		
    	let fk_region_no = $(this).data("region-no");   // 'data-region-no' 값 가져오기
    	let region_town = $(this).data("region-town"); // 'data-region-town' 값 가져오기
    	let region_lat = $(this).data("region-lat"); // 'data-region-lat' 값 가져오기
    	let region_lng = $(this).data("region-lng"); // 'data-region-lng' 값 가져오기
    		
    	
	    $.ajax({
	        url: "<%= ctxPath %>/product/prodlist",
	        type: "get",
	        data: { "fk_region_no": fk_region_no,
	        	    "region_town": region_town,
	        	    "region_lat" : region_lat,
	        	    "region_lng" : region_lng},
	        success: function(response) {
	        	// console.log("성공: ", response);
	        	$("button.choice_region").text(region_town);
	        	$("input.town").val(region_town);
	        	$("input.fk_region_no").val(fk_region_no).trigger("input"); // prodlist 페이지에서 이벤트를 하기 위한
	        	// $("input.town_name").css({"visibility":"visible"});
	        	// $("input#fk_region_no").val(fk_region_no);
	        },
	        error: function(request, status, error) {
	        	errorHandler(request, status, error);
	        }
	    });
	    
	    closeSideTab(); // 사이드바 닫기
	   	
    });

});
</script>