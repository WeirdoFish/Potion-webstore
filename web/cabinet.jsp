<%@page import="java.util.Locale"%>
<%@page import="java.util.ResourceBundle"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>

        <%
            HttpSession session0 = request.getSession();
            if (null == session0 || session0.getAttribute("auth")==(null)) {
                response.sendRedirect("login?log=in&rdir=cabinet.jsp");
                return;
            }
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

        <title>Potion Store - Cabinet</title>
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
                        <div class="header"><%=myres.getString("storeName")%></div>   
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

                        <div class='itemP' style="height:200px;">
                            <p class="other"><%=myres.getString("name")%></p> 
                            <%= request.getSession().getAttribute("username")%> 
                            <p class="other"><%=myres.getString("tab0")%></p> 
                            <%
                                String tab = request.getSession().getAttribute("tab").toString();
                                if (tab.equals("shortD")) {
                                    out.println(myres.getString("shortDiscr"));
                                }
                                if (tab.equals("longD")) {
                                    out.println(myres.getString("longDiscr"));
                                }
                                if (tab.equals("feedback")) {
                                    out.println(myres.getString("feedback"));
                                }
                            %> 
                        </div>
                    </td>
                </tr>

            </table>
    </body>
</html>
