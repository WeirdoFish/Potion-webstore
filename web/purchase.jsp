<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="etu.lab.bd.Notes"%>
<%@page import="etu.lab.bd.DBWork"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="etu.lab.bd.Items"%>
<%@page import="org.hibernate.cfg.AnnotationConfiguration"%>
<%@page import="java.util.Date"%>
<%@page import="org.hibernate.HibernateException"%>
<%@page import="etu.lab.bd.MyHibernateUtil"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>

<%@page import="net.sf.ehcache.hibernate.HibernateUtil"%>
<%@page import="etu.lab.bd.History"%>
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
        <title>Potion Store - Purchase</title>
        <link rel='stylesheet' href='tabStyles.css'>
    </head>
    <body  bgcolor="#F8FCD9" style="background-image:url(images/bg.png)">

        <div>
            <table align="center" style="width:1100px;" table-layout="fixed">
                <tr>

                    <td  colspan="1" width="275">
                        <img src="images/logo.png" style = 'cursor: pointer;' onclick="javascript: window.location = 'index.jsp';" height="130px" width="260px"></img>
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
                        <%
                            if(order.getSize()!=0) DBWork.addOrder(request.getSession().getAttribute("username").toString(),"blabla",order);
                            ArrayList<Notes> list = DBWork.getHist(request.getSession().getAttribute("username").toString());
                            if(list!=null){
                            for (Notes cur : list) { 
                               out.println(cur.getDate().toString());
                               out.println(cur.getPrice().toString());
                               out.println(cur.getMagazine().toString());
                            }
                            }
                        %>
                    </td>
                </tr>

            </table>
    </body>
</html>

