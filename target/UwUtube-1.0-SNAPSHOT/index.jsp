<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int i = 0;
    if (session.getAttribute("ID")==null) {
%>
    <jsp:include page="incognito.jsp" />
<%
    } else {
%>
    <jsp:include page="user.jsp" />
<%
    }
%>