<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
%>

<script src="<%= ctxPath%>/Highcharts-10.3.1/code/highcharts.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/exporting.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/export-data.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/accessibility.js"></script> 

<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/series-label.js"></script>

<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/data.js"></script>
<script src="<%= ctxPath%>/Highcharts-10.3.1/code/modules/drilldown.js"></script>

<jsp:include page=".././header/header.jsp" />

<div class="main">
	<jsp:include page=".././admin/admin_sidemenu.jsp" />
	
	<div>	
		<div class="statistics-main">		
			<div>
				<h2>회사 통계</h2>
					
				<form name="searchFrm">
					<select name="searchType" id="searchType" style="height: 30px;">
						<option value="">통계선택하세요</option>
						<option value="visitant">일별 방문자 통계</option>
						<option value="visitant_month">월별 방문자 통계</option>
						<option value="visitant_year">연별 방문자 통계</option>
						<option value="sales">일별 매출액</option>
						<option value="product_total_views">카테고리별 상품조회수</option>
					</select>
				</form>
			</div>
			
			<div>
				<div id="chart_container"></div>
				<div id="table_container" style="margin: 40px 0 0 0;"></div>
			</div>
		</div>
	</div>
</div>

<jsp:include page=".././footer/footer.jsp" />

<script type="text/javascript">
	$(document).ready(function(){
		   
		   $("select#searchType").change(function(e){
			   func_choice($(e.target).val());  
		   });

		   $("select#searchType").val("visitant").trigger("change");
		   
	});
	
	function func_choice(searchTypeVal) {
	    switch (searchTypeVal) {
	        case "":    // 통계선택하세요 를 선택한 경우 
	            $("div#chart_container").empty();
	            $("div#table_container").empty();
	            $("div.highcharts-data-table").empty();
	            break;
	        
	        case "visitant":  // Column with drilldown 차트
	            $.ajax({
	                url: "<%= ctxPath%>/admin/admin_statistics/admin_visitantchat",
	                dataType: "json",
	                success: function(json) {
	                    console.log(JSON.stringify(json));
	                    
	                    $("div#chart_container").empty();
	                    $("div#table_container").empty();
	                    $("div.highcharts-data-table").empty();
	                    
	                    let visitant_arr = []; // 부서명별 인원수 퍼센티지 객체 배열
	                    
	                    $.each(json, function(index, item){
	                        visitant_arr.push({
	                            name: item.login_history_date,
	                            y: Number(item.login_count) // 마지막 쉼표 제거
	                        });
	                    });

	                    /////////////////////////////////////////////////////////
	                    Highcharts.chart('chart_container', {
	                        chart: {
	                            type: 'column'
	                        },
	                        title: {
	                            align: 'left',
	                            text: '일일 방문자 수'
	                        },
	                        accessibility: {
	                            announceNewData: {
	                                enabled: true
	                            }
	                        },
	                        xAxis: {
	                            type: 'category'
	                        },
	                        yAxis: {
	                            title: {
	                                text: '방문자 수'
	                            }
	                        },
	                        legend: {
	                            enabled: false
	                        },
	                        plotOptions: {
	                            series: {
	                                borderWidth: 0,
	                                dataLabels: {
	                                    enabled: true,
	                                    format: '{point.y:.0f}' // 퍼센트 기호 없애고 정수로 표시
	                                }
	                            }
	                        },
	                        tooltip: {
	                            headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
	                            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.0f}</b> of total<br/>'
	                        },
	                        series: [
	                            {
	                                name: "인원",
	                                colorByPoint: true,
	                                data: visitant_arr
	                            }
	                        ],
	                    });
	                    /////////////////////////////////////////////////////////
	                },
	                error: function(request, status, error) {
	                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	                }
	            });
	            break;
	        case "visitant_month":  // Column with drilldown 차트
	            $.ajax({
	                url: "<%= ctxPath%>/admin/admin_statistics/admin_visitant_monthchat",
	                dataType: "json",
	                success: function(json) {
	                    console.log(JSON.stringify(json));
	                    
	                    $("div#chart_container").empty();
	                    $("div#table_container").empty();
	                    $("div.highcharts-data-table").empty();
	                    
	                    let visitant_arr = []; // 부서명별 인원수 퍼센티지 객체 배열
	                    
	                    $.each(json, function(index, item){
	                        visitant_arr.push({
	                            name: item.login_history_date,
	                            y: Number(item.login_count) // 마지막 쉼표 제거
	                        });
	                    });

	                    /////////////////////////////////////////////////////////
	                    Highcharts.chart('chart_container', {
	                        chart: {
	                            type: 'column'
	                        },
	                        title: {
	                            align: 'left',
	                            text: '월별 방문자 수'
	                        },
	                        accessibility: {
	                            announceNewData: {
	                                enabled: true
	                            }
	                        },
	                        xAxis: {
	                            type: 'category'
	                        },
	                        yAxis: {
	                            title: {
	                                text: '방문자 수'
	                            }
	                        },
	                        legend: {
	                            enabled: false
	                        },
	                        plotOptions: {
	                            series: {
	                                borderWidth: 0,
	                                dataLabels: {
	                                    enabled: true,
	                                    format: '{point.y:.0f}' // 퍼센트 기호 없애고 정수로 표시
	                                }
	                            }
	                        },
	                        tooltip: {
	                            headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
	                            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.0f}</b> of total<br/>'
	                        },
	                        series: [
	                            {
	                                name: "인원",
	                                colorByPoint: true,
	                                data: visitant_arr
	                            }
	                        ],
	                    });
	                    /////////////////////////////////////////////////////////
	                },
	                error: function(request, status, error) {
	                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	                }
	            });
	            break;
        case "visitant_year":  // Column with drilldown 차트
            $.ajax({
                url: "<%= ctxPath%>/admin/admin_statistics/admin_visitant_yearchat",
                dataType: "json",
                success: function(json) {
                    console.log(JSON.stringify(json));
                    
                    $("div#chart_container").empty();
                    $("div#table_container").empty();
                    $("div.highcharts-data-table").empty();
                    
                    let visitant_arr = [];
                    
                    $.each(json, function(index, item){
                        visitant_arr.push({
                            name: item.login_history_date,
                            y: Number(item.login_count)
                        });
                    });

                    /////////////////////////////////////////////////////////
                    Highcharts.chart('chart_container', {
                        chart: {
                            type: 'column'
                        },
                        title: {
                            align: 'left',
                            text: '월별 방문자 수'
                        },
                        accessibility: {
                            announceNewData: {
                                enabled: true
                            }
                        },
                        xAxis: {
                            type: 'category'
                        },
                        yAxis: {
                            title: {
                                text: '방문자 수'
                            }
                        },
                        legend: {
                            enabled: false
                        },
                        plotOptions: {
                            series: {
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: true,
                                    format: '{point.y:.0f}'
                                }
                            }
                        },
                        tooltip: {
                            headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.0f}</b> of total<br/>'
                        },
                        series: [
                            {
                                name: "인원",
                                colorByPoint: true,
                                data: visitant_arr
                            }
                        ],
                    });
                    /////////////////////////////////////////////////////////
                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
            break;
        case "sales":  // line 차트
			
        	$.ajax({
        	    url: "<%= ctxPath%>/admin/admin_statistics/admin_saleschat",
        	    dataType: "json",
        	    success: function(json) {
        	        console.log(JSON.stringify(json));

        	        $("div#chart_container").empty();
        	        $("div#table_container").empty();
        	        $("div.highcharts-data-table").empty();

        	        let sales_arr = [];

        	        for (let i = 0; i < json.length; i++) {
        	            sales_arr.push({
        	                name: json[i].charge_regdate,
        	                y: Number(json[i].price_to_commission)
        	            });
        	        }

        	        Highcharts.chart('chart_container', {
        	            title: {
        	                text: '일별 매출액'
        	            },
        	            subtitle: {
        	                text: 'Source: <a href="http://antico.shop/antico/index">'
        	            },
        	            yAxis: {
        	                title: {
        	                    text: '매출액'
        	                }
        	            },
        	            xAxis: {
        	                categories: json.map(item => item.charge_regdate),
        	                title: {
        	                    text: '날짜'
        	                }
        	            },
        	            legend: {
        	                layout: 'vertical',
        	                align: 'right',
        	                verticalAlign: 'middle'
        	            },
        	            plotOptions: {
        	                series: {
        	                    label: {
        	                        connectorAllowed: false
        	                    }
        	                }
        	            },
        	            series: [{
        	                name: '매출액',
        	                data: sales_arr
        	            }],
        	            responsive: {
        	                rules: [{
        	                    condition: {
        	                        maxWidth: 500
        	                    },
        	                    chartOptions: {
        	                        legend: {
        	                            layout: 'horizontal',
        	                            align: 'center',
        	                            verticalAlign: 'bottom'
        	                        }
        	                    }
        	                }]
        	            }
        	        });
        	    },
        	    error: function(request, status, error) {
        	        alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
        	    }
        	});
	        break;
        case "product_total_views":  // pie 차트
		    
   	        $.ajax({
   	    	    url:"<%= ctxPath%>/admin/admin_statistics/admin_product_total_views",
   	    	    dataType:"json",
   	    	    success:function(json){
   	    	    	console.log(JSON.stringify(json));

   	    	    	$("div#chart_container").empty();
   			        $("div#table_container").empty();
   			        $("div.highcharts-data-table").empty();
   	    	    	
   	    	    	let resultArr = [];
   	    	    	
   	    	    	for(let i=0; i<json.length; i++){
   	    	    		
   	    	    		let obj;
   	    	    		
   	    	    		if(i==0){
   	    	    			obj = {
	   	    	    	            name: json[i].category_name,
	   	    	    	            y: Number(json[i].percentage),
	   	    	    	            sliced: true,
	   	    	    	            selected: true
	   	    	    	          };
   	    	    		}
   	    	    		else {
   	    	    			obj = {
	   	    	    	            name: json[i].category_name,
	   	    	    	            y: Number(json[i].percentage)
	   	    	    	          };
   	    	    		}
   	    	    		
   	    	    		resultArr.push(obj); // 배열속에 객체를 넣기 
   	    	    	}// end of for-------------------------------
   	    	    	
   	    	    	///////////////////////////////////////////////////////////////
   	    	    	Highcharts.chart('chart_container', {
   	    	    	    chart: {
   	    	    	        plotBackgroundColor: null,
   	    	    	        plotBorderWidth: null,
   	    	    	        plotShadow: false,
   	    	    	        type: 'pie'
   	    	    	    },
   	    	    	    title: {
   	    	    	        text: '카테고리별 상품 조회수'
   	    	    	    },
   	    	    	    tooltip: {
   	    	    	        pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
   	    	    	    },
   	    	    	    accessibility: {
   	    	    	        point: {
   	    	    	            valueSuffix: '%'
   	    	    	        }
   	    	    	    },
   	    	    	    plotOptions: {
   	    	    	        pie: {
   	    	    	            allowPointSelect: true,
   	    	    	            cursor: 'pointer',
   	    	    	            dataLabels: {
   	    	    	                enabled: true,
   	    	    	                format: '<b>{point.name}</b>: {point.percentage:.2f} %'
   	    	    	            }
   	    	    	        }
   	    	    	    },
   	    	    	    series: [{
   	    	    	        name: '조회수비율',
   	    	    	        colorByPoint: true,
   	    	    	        data: resultArr 
   	    	    	    }]
   	    	    	});
   	    	    	//////////////////////////////////////////////////////////////
   	    	    },
   	    	    error: function(request, status, error){
				   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
   	        });   	   
	        break;
	    }
	};

</script>


<style>
	.main {
		margin: 0 auto;
		width: 70%;
		display: flex;
	}
	.statistics-main {
		display: flex;
	}
</style>