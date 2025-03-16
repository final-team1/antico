<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 후기 등록 페이지 --%>

<%-- context path --%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}"/>

<%-- 후기 설문 문항 정보 목록 --%>
<c:set var="survey_vo_list" value="${requestScope.survey_vo_list}"/>

<%-- 거래내역 --%>
<c:set var="trade_vo" value="${requestScope.trade_vo}"/>

<%-- 거래 상품 내역 --%>
<c:set var="product_map" value="${requestScope.product_map}"/>


<style>
    div#review_register_container {
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: space-between;
        flex-direction: column;
        align-items: center;
    }

    div#review_register_container img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    div#review_main {
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    div#register_header {
        margin-top: 20px;
        padding-bottom: 20px;
        width: 100%;
        height: 20%;
        display: flex;
        align-items: center;
        border-bottom: 1px solid #eee;
    }

    div#prod_img_box {
        width: 10%;
        height: 100%;
    }

    div#prod_info_box {
        display: flex;
        flex-direction: column;
    }

    div#feedback_title_box {
        width: 100%;
        margin: 30px 20px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: flex-start;
    }

    span.feedback_title {
        font-size: 17pt;
        font-weight: bold;
    }

    div#feedback_btn_box {
        margin: 0 20px;
        width: 80%;
        display: flex;
        justify-content: space-between;
        align-itmes: center;
        cursor: pointer;
    }

    div.feedback_btn {
        width: 80px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    img.feedback_img {
        filter: invert(100%) sepia(70%) saturate(242%) hue-rotate(217deg) brightness(118%) contrast(87%);
        transition: 0.5s ease;
    }

    span.feedback_type {
        width: 100px;
        text-align: center;
        font-size: 15pt;
        color: gray;
        transition: 0.5s ease;
        font-weight: bold;
    }

    button#review_register_btn {
        border: none;
        margin: 0 10px;
        border-radius: 15px;
        width: 100%;
        padding: 15px;
        background-color: #eee;
        color: white;
        font-size: 15pt;
        margin-bottom: 10px;
    }

    button#review_register_btn:hover {
        transition: 0.5s ease;
        background-color: black;
    }

    div.survey_box {
        margin: 20px 0;
        width: 100%;
    }

    div.survey {
        margin: 15px 0 10px 10px;
        display: flex;
        align-items: center;
        cursor: pointer;
    }

    span.survey_span {
        margin-left: 10px;
    }

    div.survey_checkbox {
        width: 30px;
        height: 30px;
    }

    div.survey_checkbox img {
        filter: invert(100%) sepia(70%) saturate(242%) hue-rotate(217deg) brightness(118%) contrast(87%);
    }

    div.add_blacklist_box {
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    span.survey_sub_span {
        margin-left: 10px;
        font-size: 10pt;
        color: gray;
    }

    div#review_textarea_box {
        margin-bottom: 20px;
        width: 100%;
        display: flex;
        flex-direction: column;
    }

    textarea {
        border-radius: 15px;
        border: solid 1px #eee;
        width: 100%;
        height: 150px;
    }

    span.review_span {
        margin-left: 9px;
        font-size: 13pt;
    }

    div#review_image_box {
        display: flex;
        align-items: center;
        margin-top: 20px;
    }

    div.btn_upload {
        transition: 0.5s ease;
        width: 150px;
        height: 30px;
        background: transparent;
        border: solid 1px gray;
        border-radius: 15px;
        font-weight: 500;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;

        &:hover {
            background: black;
            color: #fff;
        }
    }

    div#remove_image_btn {
        transition: 0.5s ease;
        margin-left: 30px;
        width: 50px;
        height: 30px;
        background: transparent;
        border: solid 1px gray;
        border-radius: 15px;
        font-weight: 500;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;

        &:hover {
            background: black;
            color: #fff;
        }
    }

    input#file {
        display: none;
    }

    span#file_name {
        margin-left: 30px;
        font-weight: bold;
    }

    div#image_preview {
        margin: 30px 0;
        display: none;
        width: 200px;
        height: 200px;
    }
</style>

<div id="review_register_container">
    <div id="review_main">
        <%-- 거래에 대한 상품 정보 --%>
        <div id="register_header">
            <div id="prod_img_box">
                <img src="${product_map.prod_img_name}"/>
            </div>
            <div id="prod_info_box">
                <span id="title">${product_map.product_title}</span>
                <span id="writer">${product_map.member_name}</span>
            </div>
        </div>

        <%-- 후기 선택지 제목  --%>
        <div id="feedback_title_box">
			<span class="feedback_title">
				${product_map.member_name}님과의
			</span>
            <span class="feedback_title">
				거래는 어떠셨나요?
			</span>
        </div>

        <%-- 후기 선택지  --%>
        <div id="feedback_btn_box">
            <div class="feedback_btn">
                <img class="feedback_img" src="${ctxPath}/images/icon/laugh.svg"/>
                <span class="feedback_type">최고에요!</span>
            </div>
            <div class="feedback_btn">
                <img class="feedback_img" src="${ctxPath}/images/icon/smile.svg"/>
                <span class="feedback_type">좋아요</span>
            </div>
            <div class="feedback_btn">
                <img class="feedback_img" src="${ctxPath}/images/icon/frown.svg"/>
                <span class="feedback_type">아쉬워요</span>
            </div>
        </div>

        <div class="survey_box" id="survey_best_box">
            <c:forEach var="survey" items="${survey_vo_list}">
                <c:if test="${survey.pk_survey_no < 5}">
                    <div class="survey" data-pk_survey_no="${survey.pk_survey_no}">
                        <div class="survey_checkbox">
                            <img src="${ctxPath}/images/icon/check.svg"/>
                        </div>
                        <span class="survey_span">${survey.survey_content}</span>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <div class="survey_box" id="survey_good_box">
            <c:forEach var="survey" items="${survey_vo_list}">
                <c:if test="${survey.pk_survey_no < 5}">
                    <div class="survey" data-pk_survey_no="${survey.pk_survey_no}">
                        <div class="survey_checkbox">
                            <img src="${ctxPath}/images/icon/check.svg"/>
                        </div>
                        <span class="survey_span">${survey.survey_content}</span>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <div class="survey_box" id="survey_bad_box">

            <c:forEach var="survey" items="${survey_vo_list}">
                <c:if test="${survey.pk_survey_no > 4}">
                    <div class="survey" data-pk_survey_no="${survey.pk_survey_no}">
                        <div class="survey_checkbox">
                            <img src="${ctxPath}/images/icon/check.svg"/>
                        </div>
                        <span class="survey_span">${survey.survey_content}</span>
                    </div>
                </c:if>
            </c:forEach>

            <hr>

            <div class="survey add_blacklist_checkbox">
                <div class="survey_checkbox">
                    <img src="${ctxPath}/images/icon/check.svg"/>
                </div>
                <div class="add_blacklist_box">
                    <span class="survey_span">다음에는 이 분을 만나고 싶지 않아요.</span>
                    <span class="survey_sub_span">해당 항목 선택 시, 거래가 차단됩니다.</span>
                </div>
            </div>
        </div>

        <div id="review_textarea_box">
            <span class="review_span">자세한 후기를 남겨주세요</span>
            <form id="reviewFrm" method="post" enctype="multipart/form-data">
                <textarea name="review_content"></textarea>
                <input type="hidden" name="arr_pk_survey_resp_no"/>
                <input type="hidden" name="pk_trade_no" value="${trade_vo.pk_trade_no}"/>
                <input type="hidden" name="feedback_type" />

                <div id="image_preview"></div>

                <div id="review_image_box">
                    <div class="btn_upload">이미지 업로드하기</div>
                    <input type="file" name="file" id="file"/>
                    <div id="remove_image_btn" onclick="removeImage()">취소</div>
                    <span id="file_name"></span>
                </div>
            </form>
        </div>
    </div>

    <button type="button" id="review_register_btn" onclick="goReviewRegister()">후기 작성하기</button>
</div>

<script>
    $(document).ready(function () {

        // 피드백(최고에요, 좋아요, 아쉬워요) 버튼을 클릭하기 전 까지는 설문문항 감추기
        $("div.survey_box").hide();

        // 설문 문항을 클릭하기 전까지는 후기 작성 란 숨기기
        $("div#review_textarea_box").hide();

        // 피드백 버튼 호버링 이벤트
        $("div.feedback_btn").hover(function () {
            $(this).find("img.feedback_img").css({
                "filter": "invert(56%) sepia(37%) saturate(967%) hue-rotate(91deg) brightness(101%) contrast(98%)"
            });
            $(this).find("span.feedback_type").css({
                "color": "black"
            });
        }, function () {
            if (!$(this).hasClass("clicked")) {
                $(this).find("img.feedback_img").css({
                    "filter": ""
                });
                $(this).find("span.feedback_type").css({
                    "color": ""
                });
            }
        });

        // 피드백 버튼 클릭 이벤트
        $("div.feedback_btn").click(function () {

            // 이전에 클릭한 버튼과 다른 피드백 버튼 경우 이전에 클릭한 설문 문항 초기화
            if (!$(this).hasClass("clicked")) {
                $("div.survey").removeClass("checked");

                $("div.survey_checkbox img").prop("src", "${ctxPath}/images/icon/check.svg");

                $("div.survey_checkbox img").css({
                    "filter": ""
                });

                $("#review_textarea_box textarea").val("");
            }

            // 클릭한 피드백 버튼에 클릭 여부 클래스 추가
            $("div.feedback_btn").removeClass("clicked");
            $(this).addClass("clicked");

            // 클릭한 피드백 버튼 색 변경
            $("img.feedback_img").css({
                "filter": ""
            });

            $("span.feedback_type").css({
                "color": ""
            });

            $(this).find("img.feedback_img").css({
                "filter": "invert(56%) sepia(37%) saturate(967%) hue-rotate(91deg) brightness(101%) contrast(98%)"
            });

            $(this).find("span.feedback_type").css({
                "color": "black"
            });

            // 클릭한 피드백 버튼에 따라 달라지는 설문 문항 보이기
            const index = $("div.feedback_btn").index(this);

            switch (index) {
                case 0 :
                    $("div.survey_box").hide();
                    $("div#survey_best_box").show();
                    break;
                case 1 :
                    $("div.survey_box").hide();
                    $("div#survey_good_box").show();
                    break;
                case 2 :
                    $("div.survey_box").hide();
                    $("div#survey_bad_box").show();
                    break;
            }

            // 설문 문항이 체크된 상태이면 후기 작성란 보이기
            if ($("div.survey").hasClass("checked")) {
                $("div#review_textarea_box").show();
            } else {
                $("div#review_textarea_box").hide();
            }
        });

        // 설문 문항 클릭 이벤트
        $("div.survey").click(function () {
            // 이미 클릭한 설문 문항인 경우
            if ($(this).hasClass("checked")) {
                $(this).find("div.survey_checkbox img").prop("src", "${ctxPath}/images/icon/check.svg");

                $(this).find("div.survey_checkbox img").css({
                    "filter": ""
                });

                $(this).removeClass("checked");
            }
            // 새로운 설문 문항을 클릭한 경우
            else {
                // 클릭한 설문 문항이 사용자 차단(블랙리스트) 문항인 경우
                if ($(this).hasClass("add_blacklist_checkbox")) {
                    Swal.fire({
                        title: "${product_map.member_name}님이 차단됩니다.",
                        text: "채팅 불가, 사용자 차단, 단골/찜 해제, 알림 미수신",
                        confirmButtonText: "확인",
                        showDenyButton: true,
                        denyButtonText: "취소",
                        icon: "warning"
                    }).then((result) => {
                        // 추가적인 confirm을 통해 사용자 차단 요청
                        if (result.isConfirmed) {
                            addBlacklist();
                        }
                    });
                }
                // 클릭한 설문 문항이 사용자 차단(블랙리스트) 문항이 아닌 경우
                else {
                    $(this).find("div.survey_checkbox img").prop("src", "${ctxPath}/images/icon/checked.svg");

                    $(this).find("div.survey_checkbox img").css({
                        "filter": "invert(56%) sepia(37%) saturate(967%) hue-rotate(91deg) brightness(101%) contrast(98%)"
                    });

                    $(this).addClass("checked");
                }
            }

            // 설문 문항이 체크된 상태이면 후기 작성란 보이기
            if ($("div.survey").hasClass("checked")) {
                $("div#review_textarea_box").show();
            } else {
                $("div#review_textarea_box").hide();
            }

        });

        // 이미지 업로드 버튼 클릭 이벤트
        $(document).on("click", "div.btn_upload", function () {
            // console.log("파일 업로드 버튼 클릭됨");
            $("input#file").click();
        });

        // 이미지 파일 선택 시 이미지 명 표시
        $(document).on("change", "input#file", function (e) {
            const image_file = $(e.target)[0].files[0];
            const file_name = image_file.name;

            console.log($(e.target)[0].files[0]);

            $("span#file_name").text(file_name);

            // 파일 확장자가 시작되는 인덱스 구하기
            const i = file_name.indexOf(".");

            // 파일확장자가 없는 경우
            if (i == -1) {
                showAlert("warning", "업로드 이미지 형식이 잘못되었습니다. 다시 확인해주세요");
                return;
            }

            // 파일 확장자
            const ext = file_name.substring(i + 1);

            console.log(ext);

            // 파일 확장자가 이미지 형식이 아닌경우
            if (ext != "jpg" && ext != "jpeg" && ext != "png" && ext != "gif") {
                showAlert("warning", "업로드 이미지 형식이 잘못되었습니다. 다시 확인해주세요");
                return;
            }

            // 이미지 파일 크기 제한 최대 5MB
            if (image_file.size > 1024 * 1024 * 5) {
                showAlert("warning", "업로드 이미지는 최대 5MB까지 가능합니다.");
                return;
            }

            let v_html = ``;

            const reader = new FileReader();
            reader.onload = function (e) {
                v_html += `<img id="preview" src="\${e.target.result}"/>`;
                console.log(v_html);
                $("div#image_preview").html(v_html).show();
            }

            reader.readAsDataURL(image_file);

        });


    });

    // 후기 등록 요청 함수
    function goReviewRegister() {
        let arr_pk_survey_resp_no = []; // 체크한 설문 문항을 저장하는 배열

        // 체크한 설문 문항을 배열에 저장
        $("div.survey").each(function (index, item) {
            if ($(item).hasClass("checked")) {
                arr_pk_survey_resp_no.push($(item).data("pk_survey_no"));
            }
        });

        // 설문문항을 클릭하지 않은 경우 경고 알림
        if (arr_pk_survey_resp_no.length < 1) {
            showAlert("warning", "설문 문항을 체크해 주세요");
            return;
        }

        if($("textarea[name='review_content']").text()=="" || $("textarea[name='review_content']").text().length < 1) {
            showAlert("warning", "설문 내용을 작성해주세요");
            return;
        };

        // input 태그에 저장
        $("input[name='arr_pk_survey_resp_no']").val(arr_pk_survey_resp_no.join(","));

        // 피드백 타입 저장
        const feedback_type = $("div.feedback_btn").filter(".clicked").index();

        $("input[name='feedback_type']").val(feedback_type);

        // 후기 등록 form에서 formData 가져오기
        const formData = new FormData($("form#reviewFrm")[0]);

        $.ajax({
            url: "${ctxPath}/review/register",
            enctype: "multipart/form-data",
            type: "post",
            data: formData,
            processData: false, // 쿼리 문자열 변환 방지
            contentType: false, // multipart/form-data 형태 고정
            cache: false, // 캐시 방지
            success: function (json) {
                console.log(json);

                if (json.review_success > 0) {
                    showAlert("success", "후기 등록을 성공했습니다.")
                    closeSideTab();
                } else {
                    showAlert("error", "후기 등록을 실패했습니다. 다시 시도해주세요");
                }
            },
            error: function (request, status, error) {
                if (request.status == 413) {
                    showAlert("error", "파일 크기가 너무 큽니다.");
                } else {
                    errorHandler(request, status, error);
                }
            }
        });
    }

    // 사용자 차단(블랙리스트) 요청 함수
    function addBlacklist() {
        $.ajax({
            url: "${ctxPath}/review/add_blacklist",
            type: "post",
            data: {
                "pk_target_member_no": "${product_map.fk_member_no}",
            },
            success: function (json) {
                console.log(json);

                const blacklist_success = json.blacklist_success;

                if (blacklist_success != 1) {
                    showAlert("error", "사용자 차단을 실패했습니다. 마이페이지에서 다시 시도해주세요");
                } else {
                    showAlert("success", "${product_map.member_name}님을 차단하였습니다.");

                    // 사용자 차단을 성공한 경우 CSS 체크 처리
                    $("div.add_blacklist_checkbox").find("div.survey_checkbox img")
                        .prop("src", "${ctxPath}/images/icon/checked.svg")
                        .css({
                            "filter": "invert(56%) sepia(37%) saturate(967%) hue-rotate(91deg) brightness(101%) contrast(98%)"
                        });

                    $("div.add_blacklist_checkbox").addClass("checked");
                }
            },
            error: function (request, status, error) {
                errorHandler(request, status, error);
            }
        });
    }

    function removeImage() {
        if ($("img#preview")) {
            $("div#image_preview").html("");
            $("input#file")[0].files[0] = null;
            $("div#image_preview").hide();
            $("span#file_name").text("");
        }
    }

</script>