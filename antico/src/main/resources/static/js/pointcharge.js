
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
function goCoinUpdate(ctx_Path, fk_member_no, charge_price) { 

    // console.log(`~~ 확인용 userid : ${userid}, coinmoney : ${coinmoney}원`);
    // ~~ 확인용 userid : dlgns, coinmoney : 300000원

    $.ajax({
        url : ctx_Path+"/mypage/point_update",
        data: {"fk_member_no" : fk_member_no,
			   "charge_commission" : charge_commission,
               "charge_price" : charge_price},
        type: "post",
        dataType : "json",
        success : function(json){
			if (json.n == 1) {
                alert("충전이 완료되었습니다.");
				location.href = ctx_Path+"/mypage/mypagemain";
            } else {
                alert("충전실패!!");
            }
        },
        error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
    });

} // end of function goCoinUpdate(ctxPath, userid, coinmoney) { }------------