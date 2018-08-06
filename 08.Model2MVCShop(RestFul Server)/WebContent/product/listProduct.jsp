<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html; charset=euc-kr" %>




<html>
<head>


<title>상품 목록 조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
function fncGetUserList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
   	document.detailForm.submit();		
}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm" action="/product/listProduct?menu=${param.menu}"	method="post">

			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">
								<c:if test="${param.menu eq 'manage'}"> 상품 관리 조회</td></c:if>
								<c:if test="${param.menu eq 'search'}"> 상품 목록 조회 </td></c:if>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>

					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">

							<option value="0" ${! empty searchCondition.equals && searchCondition.equals==0 ? "selected" : "" }>상품 번호</option>
							<option value="1" ${! empty searchCondition.equals && searchCondition.equals==1 ? "selected" : "" }>상품명</option>
							<option value="2" ${! empty searchCondition.equals && searchCondition.equals==2 ? "selected" : "" }>상품 가격</option>
					</select> <input type="text" name="searchKeyword"
						value="${! empty search.searchKeyword ? search.searchKeyword : '' }" class="ct_input_g"
						style="width: 200px; height: 19px" /></td>

					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">

							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>

								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;"><a
									href="javascript:fncGetUserList('1');">검색</a>
								</td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">전체 ${resultPage.totalCount} 건수,	현재 ${resultPage.currentPage} 페이지
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">번호</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품 가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">등록일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">현재 상태</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				
					<c:set var="i" value="0"/>
					<c:forEach var="product" items="${list}">
					<c:set var="i" value="${i+1}"/>
					<tr class="ct_list_pop">
					<td align="center">${ i }</td>
					<td></td>
					<td align="center">
					<c:if test="${param.menu eq 'manage'}" >
					<a href="/product/updateProduct?menu=${param.menu}&prodNo=${product.prodNo}">${product.prodName}</a>
					</c:if>
					<c:if test="${param.menu eq 'search'}">
					<a href="/product/getProduct?menu=${param.menu}&prodNo=${product.prodNo}">${product.prodName}</a></c:if></td>
					
					<td></td>
					<td align="center">${product.price}</td>
					<td></td>

					<td align="center">${product.regDate}</td>
					<td></td>
					
					<td> 
					
					<c:if test="${product.proTranCode.trim() == null && param.menu =='search'}">판매중</c:if>
					<c:if test="${product.proTranCode.trim() == null && param.menu =='manage'}">판매중</c:if>
					
					<c:if test="${product.proTranCode.trim() == '1' && user.role =='user'}">재고없음</c:if>
					<c:if test="${product.proTranCode.trim() == '1' && user.role =='admin'}">구매완료
					<a href="/purchase/updateTranCodeByProd?proTranCode=2&prodNo=${product.prodNo}">&nbsp;배송하기</a></c:if>
					
					<c:if test="${product.proTranCode.trim() =='2' && user.role =='admin'}">배송중</c:if>
					<c:if test="${product.proTranCode.trim() =='2' && user.role =='user'}">재고없음</c:if>
									
					<c:if test="${product.proTranCode.trim() =='3' }">배송완료</c:if>
					
					</td>
					
				</tr>
				
				</c:forEach>
			</table>

			<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
				<tr>
					<td align="center">
					 <input type="hidden" id="currentPage" name="currentPage" value=""/>
		
						<jsp:include page="../common/pageNavigator.jsp"/>
					</td>
				</tr>
			</table>
			<!--  페이지 Navigator 끝 -->

		</form>

	</div>
</body>
</html>
