<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=euc-kr" %>

	
<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
		¢·
</c:if>
<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
		<a href="javascript:fncGetUserList('${ resultPage.currentPage-1}')">¢·</a>
</c:if>

<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
	<a href="javascript:fncGetUserList('${ i }');">${ i }</a>
</c:forEach>

<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
		¢¹
</c:if>
<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
		<a href="javascript:fncGetUserList('${resultPage.endUnitPage+1}')">¢¹</a>
</c:if>