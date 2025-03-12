<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String ctx_Path = request.getContextPath();
%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    .bank_info {
        margin-bottom: 20px;
        border-radius: 8px;
        border: 1px solid rgb(218, 222, 229);
        padding: 16px;
        box-shadow: rgba(0, 0, 0, 0.04) 0px 2px 8px 0px;
        overflow: hidden;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        text-align: center;
        padding: 12px;
        border: none;
    }

    .action_buttons {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 32px;
    }

    .main_account {
        cursor: pointer;
        color: #bbb;
        font-weight: bold;
        user-select: none;
        padding-right: 25px;
        margin-right: -10px;
        display: flex;
        align-items: center;
    }

    .account_del {
        cursor: pointer;
        font-weight: bold;
        user-select: none;
        margin-left: -10px;
    }



    .no_account_container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 300px;
        background-color: #f8f9fa;
        border-radius: 8px;
        box-shadow: rgba(0, 0, 0, 0.1) 0px 4px 10px;
        text-align: center;
        color: #6c757d;
    }

    .no_account_message {
        font-size: 20px;
        font-weight: bold;
        color: #6c757d;
    }

    .main_account .mark {
        width: 16px;
        height: 16px;
        background-color: rgb(13, 204, 90);
        border-radius: 50%;
        margin-right: 6px;
    }
</style>

<c:if test="${not empty requestScope.bank_list}">
    <c:forEach var="bank_list" items="${requestScope.bank_list}">
        <div class="bank_info">
            <table class="table">
                <thead>
                    <tr>
                        <th>예금주</th>
                        <th>은행명</th>
                        <th>계좌번호</th>
                    </tr>
                </thead>

                <tbody>
                    <tr>
                        <td>${requestScope.member_name}</td>
                        <td>${bank_list.account_bank}</td>
                        <td>${bank_list.account_no}</td>
                        <input type="hidden" value="${bank_list.account_type}" name="account_type" data-account-id="${bank_list.account_no}" />
                    </tr>
                </tbody>
            </table>
            <div class="action_buttons">
                <span class="main_account" onclick="toggleMainAccount(${bank_list.account_no})" data-account-id="${bank_list.account_no}">
                    <span class="mark" style="display: ${bank_list.account_type == 1 ? 'block' : 'none'};"></span>
                    대표계좌로 설정
                </span>
                <span class="account_del" onclick="deleteAccount(${bank_list.account_no})">삭제</span>
            </div>
        </div>
    </c:forEach>
</c:if>

<c:if test="${empty requestScope.bank_list}">
    <div class="no_account_container">
        <div class="no_account_message">
            등록된 계좌가 없습니다.
        </div>
    </div>
</c:if>


<script>
$(document).ready(function() {
    
});

function deleteAccount(account_no) {
	let type = $("input:hidden[data-account-id='" + account_no + "']").val();
    if (confirm('정말로 계좌를 삭제하시겠습니까?')) {

        if (account_no) {
            $.ajax({
                url: "<%=ctx_Path%>/mypage/account_delete",
                type: "post",
                data: {
                    "account_no": account_no,
                    "account_type": type
                },
                dataType: "json",
                success: function(response) {
                    if (response == 1) {
                        showAlert("success", "계좌가 삭제되었습니다.");
                    } else {
                        showAlert('error', '계좌 삭제를 실패하였습니다.');
                    }
                },
                error: function (request, status, error) {
                    errorHandler(request, status, error);
                }
            });
        } else {
            showAlert('error', '계좌 정보가 없습니다.');
        }
    }
}


function toggleMainAccount(account_no) {
    // 해당 account_no에 맞는 account_type을 가져오기
    let type = $("input:hidden[data-account-id='" + account_no + "']").val();
    
    if (type == '1') {
        showAlert("error", "이미 대표 계좌입니다.");
    } else {
    	$.ajax({
            url: "<%=ctx_Path%>/mypage/account_type_update",
            type: "post",
            data: {
                "account_no": account_no
            },
            dataType: "json",
            success: function(response) {
                if (response == 1) {
                	showAlert("success", "대표 계좌로 설정되었습니다.");
                	
                	 // ✅ 모든 대표 계좌 표시 제거
                    $(".main_account .mark").hide();
                    $("input[name='account_type']").val("0");

                    // ✅ 선택한 계좌만 대표 계좌로 설정
                    $(".main_account[data-account-id='" + account_no + "'] .mark").show();
                    $("input:hidden[data-account-id='" + account_no + "']").val("1");
                } else {
                    showAlert('error', '대표 계좌 설정 실패!!');
                }
            },
            error: function (request, status, error) {
                errorHandler(request, status, error);
            }
        });
        
    }
}
</script>
