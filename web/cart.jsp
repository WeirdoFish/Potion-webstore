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

        <jsp:useBean id="order" class="etu.lab.CartBean" scope="session"/>
        <title>Potion Store - Cart</title>
        <link rel='stylesheet' href='tabStyles.css'>
    </head>
    <body  bgcolor="#F8FCD9" style="background-image:url(images/bg.png)">

        <c:if test="${not empty cookie.newOrder.value}">
            <c:if test="${cookie.newPrice.value ne '-1'}">
                ${order.add(Integer.valueOf(cookie.newOrder.value), Integer.valueOf(cookie.newPrice.value))}
            </c:if>
            <c:if test="${cookie.newPrice.value eq '-1'}">
                ${order.del(Integer.valueOf(cookie.newOrder.value))}
            </c:if>
        </c:if>    

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
                    <td colspan="4" width="1100">
                        <table align="center" width="1100" table-layout="fixed">
                            <c:if test="${order.getSize() eq 0}">
                                <tr>
                                    <td align="center">
                                        <b><p class="other tabHead"><fmt:message key="empty"/></p>
                                    </td>
                                </tr>
                            </c:if>

                            <c:if test="${not (order.getSize() eq 0)}">
                                <tr>
                                    <td align="center">
                                        <b><p class="other tabHead" ><fmt:message key="prod"/></p></b>
                                    </td>
                                    <td align="center">
                                        <b><p class="other tabHead"><fmt:message key="count"/></p></b>
                                    </td>
                                    <td align="center">
                                        <b><p class="other tabHead"><fmt:message key="price"/></p></b>
                                    </td>
                                </tr>

                                <c:forEach var="i" begin="0" end="${order.getSize() - 1}">
                                    <tr>
                                        <td align="center"><div><jsp:include page="${order.getProductPath(i)}"/></div></td>
                                        <td align="center"><div class="countPrice">
                                                <button onclick="remove(${order.getProdID(i)});" class="incdec" id="minus">-</button>
                                                ${order.getProdCount(i)} 
                                                <button class="incdec" id="plus" onclick="add(${order.getProdID(i)},${order.getProdPrice(i)});">+</button></div></td>
                                        <td align="center"><div class="countPrice">${order.calc(i)}</div></td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td  align="center" colspan="3">
                                        <div class="countPrice summary" align="center">
                                            <table>
                                                <tr>
                                                    <td align="left" width="400px">
                                                        <div style="font-weight: 900; color:#F48A4E; margin-top:0px;"><fmt:message key="sum"/></div>
                                                    </td>
                                                    <td align=right">
                                                        <div style="font-weight: 900; margin-top:0px;" >${order.calcAll()}</div>
                                                    </td>
                                                </tr>

                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>

                            <c:if test="${empty sessionScope.auth}">
                                <tr>
                                    <td colspan="3" align="center">
                                        <div align="center" class="countPrice auth" align="center">

                                            <fmt:message key="authFail"/>
                                            <div align="center">
                                                <button onclick="javascript: window.location='login?log=in&rdir=cart.jsp';" class="login"><fmt:message key="login"/></button>
                                            </div>
                                        </div>

                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${not empty sessionScope.auth}">
                                <c:if test="${not (order.getSize() eq 0)}">
                                <tr>
                                    <td colspan="4" align="center">
                                        <button class="buyBut" onclick="javascript: window.location='purchase.jsp';"><fmt:message key="purchase"/></button>
                                    </td>
                                </tr>
                                </c:if>
                            </c:if>
                        </table>
                    </td>
                </tr>

            </table>
    </body>
    <script type="text/javascript">
        function delCookie(name) {
            document.cookie = name + "=" + "; expires=Thu, 01 Jan 1970 00:00:01 GMT";
        }
        ;
        window.onload = function () {
            delCookie("newOrder");
            delCookie("newPrice");
        };

        function remove(num) {
            document.cookie = 'newOrder=' + num;
            document.cookie = 'newPrice=-1';
            window.location = 'cart.jsp';
        }
        function add(num, pr) {
            document.cookie = 'newOrder=' + num;
            document.cookie = 'newPrice=' + pr;
            window.location = 'cart.jsp';
        }
    </script>
</html>
