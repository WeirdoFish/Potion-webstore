<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>

        <c:if test="${empty cookie.locale.value}">
            <fmt:setBundle basename="strings"/> 
            <fmt:setLocale value="${pageContext.getLocale()}) "/>
        </c:if>       
        <c:if test="${cookie.locale.value eq 'ru'}">
            <fmt:setBundle basename="strings_ru"/>
        </c:if>

        <c:if test="${cookie.locale.value eq 'en'}">
            <fmt:setBundle basename="strings_en"/>
        </c:if>

        <c:if test="${cookie.locale.value eq 'lat'}">
            <fmt:setBundle basename="strings_lat"/>
        </c:if>

        <title>Potion Store - Error</title>
        <link rel='stylesheet' href='tabStyles.css'>
    </head>
    <body  bgcolor="#F8FCD9" style="background-image:url(images/bg.png)">

        <div>
            <table align="center" style="width:1100px;" table-layout="fixed">
                <tr>

                    <td  colspan="1" width="275">
                        <img src="images/logo.png" onclick="javascript: window.location = 'index.jsp';" style = 'cursor: pointer;' height="130px" width="260px"></img>
                    </td>
                    <td  colspan="2">
                        <div class="header"><fmt:message key="storeName"/></div>   
                    </td>
                    <td align="right" colspan="1" width="400">
                        <div>
                            <jsp:include page="/clientHeader.jsp"/>
                        </div>
                    </td>

                </tr>
                <tr>
                    <td colspan="4" width="1100">
                        <div class="blockM"> </div>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4" width="1100">
                        <table  width="500" table-layout="fixed">
                            <div id="loginBox">
                                <p class="other"><fmt:message key="fail"/></p>
                                <p><fmt:message key="fail1"/> <strong><a class="alink" href="login"><fmt:message key="fail2"/></a></strong>.</p>
                            </div>
                        </table>
                    </td>
                </tr>

            </table>
    </body>
    <script type="text/javascript">

    </script>
</html>