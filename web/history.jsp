<%@page import="java.util.Locale"%>
<%@page import="java.util.ResourceBundle"%>
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

        <%

            Locale locale = response.getLocale();
            Cookie cookie[] = request.getCookies();
            if (cookie != null) {
                for (Cookie c : cookie) {
                    if ("locale".equals(c.getName())) {
                        locale = new Locale(c.getValue());
                    }
                }
            }
            ResourceBundle myres = ResourceBundle.getBundle("strings", locale);

        %>

        <title>Potion Store - Authentification</title>
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
                        <div class="header"><%= myres.getString("storeName")%></div>   
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
                            ArrayList<Notes> ArList = DBWork.getHist(request.getSession().getAttribute("username").toString());
                            if (ArList.size()!=0) {
                                for (Notes cur : ArList) {
                        %>
                        <div class="itemP" style="margin-bottom:15px;" align="center">
                            <table>
                                <tr>
                                    <td colspan="3" align="left">
                                        <p class="other">Заказ от:
                                            <%=cur.getDate().toString()%></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%--пикчи--%>
                                    </td>
                                    <td>
                                        <p class="other">Товар</p>
                                    </td>
                                    <td>
                                        <p class="other">Количество</p>
                                    </td>
                                </tr>
                                <%
                                    ArrayList<Integer> ids, ams;
                                    ids = cur.getIds();
                                    ams = cur.getAms();
                                    for (int i = 0; i < ids.size(); i++) {
                                %>
                                <tr>
                                    <td align="center">
                                        <img src="images/img0<%=ids.get(i)%>.png" height="50"></img>
                                    </td>

                                    <td>
                                        <a class="alink" href="product?id=<%=ids.get(i)%>"><%=myres.getString("Pot" + ids.get(i))%></a>   
                                    </td>
                                    <td align="center">
                                        <p><%=ams.get(i)%></p>
                                    </td>
                                    <%
                                        }
                                    %>
                                </tr>
                                <tr>
                                    <td colspan="1" valign="bottom">
                                        <p class="other">Стоимость:</p>  
                                    </td>
                                    <td colspan="2" valign="bottom">
                                        <p style="font-weight: 900; margin-bottom:4px;">
                                            <%=cur.getPrice().toString()%>
                                        </p>

                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="1" valign="bottom">
                                        <p class="other">Способ доставки: </p> 
                                    </td>
                                    <td colspan="2" valign="bottom">                                         
                                        <p style="font-weight: 900; margin-bottom:4px;">
                                            <%=cur.getMagazine().toString()%>
                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <%
                            }
                        } else{
                        %>
                        <p class="other">Вы ещё ничего не заказывали. </p> 
                        <%
                            }
                        %>


                    </td>
                </tr>

            </table>
    </body>
</html>