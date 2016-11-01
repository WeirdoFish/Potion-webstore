<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.text.SimpleDateFormat"%>
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
            if (null == session0 || session0.getAttribute("auth") == (null)) {
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
    <body  bgcolor="#F8FCD9" style="background-image:url(images/bg.png)" onload="startTime()">

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

                        <div class='itemP' style="height:400px;">
                            <% String lang = locale.getLanguage();
                                SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMMM yyyy", locale);;
                                if (lang.equals(new Locale("ru").getLanguage())) {
                                    dateFormat = new SimpleDateFormat("dd MMMMM yyyy", locale);
                                } else if (lang.equals(new Locale("en").getLanguage())) {
                                    dateFormat = new SimpleDateFormat("MMMMM dd yyyy", locale);
                                } else if (lang.equals(new Locale("lat").getLanguage())) {
                                    DateFormatSymbols mon = new DateFormatSymbols() {

                                        @Override
                                        public String[] getMonths() {
                                            return new String[]{"Januarius", "Februarius", "Martius", "Aprilis", "Maius", "Junius",
                                                "Julius", "Augustus", "September", "October", "November", "December"};
                                        }

                                    };
                                    dateFormat = new SimpleDateFormat("dd MMMMM yyyy", mon);
                                }
                            %>
                            <p class="other"><%=myres.getString("today")%></p>
                            <p><%=dateFormat.format(new Date()).toString()%> </p><p id="time"></p>
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
                            <%-- <p class="other"><%=myres.getString("lang")%></p>
                             <%=request.getSession().getAttribute("lang").toString()%> --%>

                            <button style="margin-top:30px;" class="another" onclick="javascript: window.location = 'history.jsp';"><%= myres.getString("history")%></button>
                        </div>
                    </td>
                </tr>

            </table>
    </body>
    <script type="text/javascript">
        function startTime(){
            var tm = new Date();
            var h = tm.getHours();
            var m = tm.getMinutes();
            var s = tm.getSeconds();
            m = checkTime(m);
            s = checkTime(s);
            document.getElementById('time').innerHTML = h + ":" + m + ":" + s;
            t = setTimeout('startTime()', 500);
        }
        function checkTime(i){
            if (i < 10){
                i = "0" + i;
            }
            return i;
        }
    </script>
</html>
