
// ===== 코인충전 결제금액 선택하기(실제로 카드 결제) ==== //
function pointcharge(ctx_Path){
	
    // 코인충전 결제금액 선택하기 팝업창 띄우기
    const url = `${ctx_Path}/mypage/pointcharge`;

    // 너비 650, 높이 570 인 팝업창을 화면 가운데 위치시키기
    const width = 850;
    const height = 700;

    const left = Math.ceil( (window.screen.width - width)/2 ); // 정수로 만듦
    //         // 내 모니터의 넓이  ex) 1400 - 650 = 750/2 ==>375

    const top = Math.ceil( (window.screen.height - height)/2 ); // 정수로 만듦
    //         // 내 모니터의 넓이  ex) 900 - 570 = 330/2 ==>165

    window.open(url, "pointcharge",
                `left=${left}, top=${top}, width=${width}, height=${height}`
    );

} // end of function goCoinPurchaseTypeChoice(){})----------



// ==== DB 상의 tbl_member 테이블에 해당 사용자의 코인금액 및 포인트를 증가(update)시켜주는 함수 === //
function goCoinUpdate(ctx_Path, userid, coinmoney) { 

    // console.log(`~~ 확인용 userid : ${userid}, coinmoney : ${coinmoney}원`);
    // ~~ 확인용 userid : dlgns, coinmoney : 300000원

    $.ajax({
        url : ctx_Path+"/member/coinUpdateLoginUser.up",
        data: {"userid" : userid, 
               "coinmoney" : coinmoney}, // data 속성은 http://localhost:9090/MyMVC/member/coinUpdateLoginUser.up 로 전송해야할 데이터를 말한다.
        type: "post", // type 을 생략하면 type : "get" 이다.
        async : true,   // async:true 가 비동기 방식을 말한다. async 을 생략하면 기본값이 비동기 방식인 async:true 이다.
                        // async:false 가 동기 방식이다. 지도를 할때는 반드시 동기방식인 async:false 을 사용해야만 지도가 올바르게 나온다.
            
        dataType : "json",  // Javascript Standard Object Notation.  dataType은 /MyMVC/member/idDuplicateCheck.up 로 부터 실행되어진 결과물을 받아오는 데이터타입을 말한다. 
                            // 만약에 dataType:"xml" 으로 해주면 /MyMVC/member/coinUpdateLoginUser.up 로 부터 받아오는 결과물은 xml 형식이어야 한다. 
                            // 만약에 dataType:"json" 으로 해주면 /MyMVC/member/coinUpdateLoginUser.up 로 부터 받아오는 결과물은 json 형식이어야 한다.
        success : function(json){
                console.log("~~~~ 확인용 json => ", json);
            //  {loc: '/MyMVC/index.up', message: '강이훈님의 300,000원 결제가 완료되었습니다.', n: 1} 
            
            alert(json.message);
            location.href = json.loc;
        },
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
    });

} // end of function goCoinUpdate(ctxPath, userid, coinmoney) { }------------