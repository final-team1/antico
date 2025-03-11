<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<% String ctxPath = request.getContextPath(); %>


<!-- chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<jsp:include page=".././header/header.jsp"></jsp:include>

<style type="text/css">

div#container {
	width: 70%;
	height: 800px;
	margin: 0 auto;
}

div#price_check_title {
	margin-top: 100px;
	text-align: center;
}

div#price_check_contents {
	margin-top: 10px;
	text-align: center;
}
span#price_check_title {
	font-size: 20pt;
	font-weight: bold;
}

div#search_price_div {
	margin-top: 20px;
	margin-bottom: 80px;
	position: relative;
	width: 100%;
	text-align: center;
}

div#search_price_input_icon {
    position: relative;
    width: 450px;
    text-align: center;
    display: inline-block;
}

input#search_price_ip {
	width: 100%;
	height: 30px;
    border: 1px solid #cccccc;
    border-radius: 6px;
    font-size: 10pt;
    padding: 10px 30px 10px 10px; /* 오른쪽에 아이콘을 위한 패딩 */
    box-sizing: border-box; 	  /* padding을 포함한 크기로 계산되도록 설정 */  
}

button#search_price_btn {
	position: absolute;
	height: 30px;
	border: none;
    background: none;
    cursor: pointer;
    padding: 0;
    margin: 0;
    top: 50%;
    right: 10px; /* 오른쪽 끝에 아이콘 위치 설정 */
    transform: translateY(-50%); /* 아이콘을 정확히 수직 가운데로 위치시킴 */
}


div#today_price {
	width: 600px;
	margin: 0 auto;
}

span#today_price_title {
	font-size: 12pt;
	display: none;
}

span#today_price_span {
	margin-top: 10px;
	font-size: 20pt;
	font-weight: bold;
	color: #0DCC5A;
}

div#chart_container {
	width: 600px;
	height: 450px;
    display: block;
    margin: 10px auto;
    padding: 0;
}

div#no_search {
	width: 600px;
	margin: 0 auto;
	text-align: center;
	display: none;
}



</style>

<div id="container">
		
	
	<div id="price_check_title">
		<span id="price_check_title">시세조회</span>
	</div>	
	<div id="price_check_contents">
		<span>원하시는 상품의 시세를 알아보세요</span>
	</div>	
	<div id="search_price_div">
		<div id="search_price_input_icon">
			<input type="text" id="search_price_ip" name="search_pirce" placeholder="어떤 시세 정보가 궁금하세요?" />
			<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지 --%>
			<button id="search_price_btn">
	        	<i class="fa-solid fa-magnifying-glass fa-xs"  onclick="goSearchPrice()"></i>
	    	</button>
    	</div>
	</div>
    <!-- 차트 영역 -->
   	<div id="today_price">
   		<div>
   			<span id="today_price_title">시세금액</span>
   		</div>
   		<div>
			<span id="today_price_span"></span>
   		</div>
   	</div>
    <div id="chart_container">
        <canvas id="priceChart" width="600" height="450"></canvas>
    </div>	
    <div id="no_search">
    	<span>검색 결과가 없습니다.</span>
    </div>	
	
	
	
</div>

<jsp:include page=".././footer/footer.jsp"></jsp:include>


<script type="text/javascript">


$(document).ready(function(){

	
	// 상품 검색 창 엔터를 친 경우 검색하러 간다.
	$("input:text[name='search_pirce']").bind("keyup", function(e){
   	if(e.keyCode == 13){ // 엔터를 했을 경우
   		goSearchPrice();
   	}
})

});

let priceChart;

// 상품 검색하는 함수
function goSearchPrice() {
    const search_price = $("input[name='search_pirce']").val();
    
    
    // 검색어가 빈 값일 경우, "검색된 데이터가 없습니다" 메시지 표시
    if (!search_price.trim()) {
        $("div#no_search").css("display", "block");
        $("div#today_price").css("display", "none");
        $("div#chart_container").css("display", "none");
        return; // 검색어가 없으면 더 이상 진행하지 않음
    }
    
 	let date_list = [];   // 날짜 리스트
	let price_list = [];  // 시세 리스트
    
    // 시세 데이터 받아오기
    $.ajax({
        url: "<%= ctxPath %>/product/market_price_search", // 서버 URL
        method: "get",
        data: { "search_price": search_price }, // 검색어 전송      
        dataType: "json",
		success: function(data) {
			
            // 검색 결과가 없을 경우
            if (data.length === 0) {
                $("div#no_search").css("display", "block");
                $("div#today_price").css("display", "none");
                $("div#chart_container").css("display", "none");
                return;
            }
            
            // avg_price 합계 계산
            let total_price = data.reduce(function(sum, item) {
            	return sum + (Number(item.avg_price) || 0);  // avg_price를 모두 더함
            }, 0);

            // avg_price 전체 합계가 0일 경우
            if (total_price === 0) {
                $("div#no_search").css("display", "block");
                $("div#today_price").css("display", "none");
                $("div#chart_container").css("display", "none");
                return;
            }
            
            
            $("div#no_search").css("display", "none");
            $("div#today_price").css("display", "block");
            $("div#chart_container").css("display", "block");
			
			// 데이터 넣기
			for(let i = 0; i<data.length; i++) {
				date_list.push(data[i].product_update_date);
				price_list.push(data[i].avg_price);
			}
			
			$("span#today_price_title").css("display", "block");
			
	        // 마지막 시세 금액을 <span>에 표시
	        let last_price = price_list[price_list.length - 1]; // 마지막 시세
	        let formatted_price = new Intl.NumberFormat().format(last_price);
	        $("span#today_price_span").text(formatted_price + ' 원'); // <span>에 출력
			
            // 기존 차트가 있으면 삭제
            if (priceChart) {
                priceChart.destroy();
            }
			
			
            priceChart = new Chart(document.getElementById('priceChart').getContext('2d'), {
		    	  type: 'line',
		    	  data: {
		    	    labels: date_list, // X축 
		    	    datasets: [{ 
		    	        // data: price_list, // 값
		    	        data: price_list,
		    	        label: "",
						borderColor: '#0DCC5A',
						backgroundColor: 'rgba(13, 204, 90, 0.5)',
						borderWidth: 2,
						fill: false,
					    pointStyle: 'circle',
					    pointRadius: 7,
					    pointHoverRadius: 9
		    	      }
		    	    ]
		    	  },
		    	  options: {
				    responsive: true,
				    maintainAspectRatio: false,
				    scales: {
				        x: {
				            grid: {
				              display: false,
				            },
			                ticks: {
			                    display: false, // X축의 날짜 숨기기
			                }
				        },
				        y: {
				            beginAtZero: false,
			                ticks: {
			                    callback: function(value) {
			                    	// y축 값만 10,000으로 나누고 반올림하여 '만원' 단위로 표시
			                        return Math.round(value / 10000) + ' 만원';
			                    },
			                    maxTicksLimit: 7, // y축에 7개의 눈금 고정
			                    stepSize: (Math.ceil(Math.max(...price_list) / 10000) - Math.floor(Math.min(...price_list) / 10000)) / 6 * 10000, // 간격 계산
			                    padding: 10 // y축 값과 눈금 간의 여백 추가 (간격 조정)
			                },
			        		// offset: true // y축의 오프셋을 활성화하여 축이 데이터 포인트에 더 여유를 둡니다.
				        }
				    },
				    plugins: {
				        legend: {
				            onClick: function(e) {// '시세 금액 클릭 시 아무 동작 없게 처리'
				     		},
				    		display: false  	  // 범례 숨기기
				        }
				    }
				}
			});
 
        }, 
        error: function(request, status, error) {
            errorHandler(request, status, error);
        }
    });
}

</script>

