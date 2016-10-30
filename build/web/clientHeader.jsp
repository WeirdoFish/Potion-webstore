<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.Cookie" %>
<%@page import="java.util.ResourceBundle" %>
<%@page import="java.util.Locale" %>


    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <script src='js/change.js'></script>
        <link rel='stylesheet' href='tabStyles.css'>
         <jsp:useBean id="order" class="etu.lab.CartBean" scope="session"/>
        <title>JSP Page</title>
    </head>
    <body>
        <table>
            <tr>
                <td colspan="2">
                     <%
                        if (request.getSession().getAttribute("auth") != null) {
                           out.println(myres.getString("hello")+" <b>" + request.getSession().getAttribute("username")+"</b>");
                        %>
                        </br><b><a class="alink" href="cabinet.jsp"><%=myres.getString("cab")%></a></b>
                        <%
                        }
                    %>
                </td>
                <td colspan="1">
                    <div class="loc">
                        <img align='right' hspace='3' style = 'cursor: pointer;' onclick="changeLocale('lat')" title='Latinae' onclick='' src='images/RI.png'></img>
                        <img align='right' hspace='3' style = 'cursor: pointer;' onclick="changeLocale('en')" title='English' src='images/UK.png'></img>
                        <img align='right' hspace='3' style = 'cursor: pointer;' onclick="changeLocale('ru')" title='Русский' src='images/RU.png'></img>
                    </div>
                </td>
            <tr>
                <td>
                    <%
                        if (request.getSession().getAttribute("auth") == null) {
                    %>
                    <button class="login"  onclick="javascript: window.location = 'login?log=in&rdir=index.jsp';">  <%= myres.getString("login")%></button>
                    <%
                    } else {
                    %>
                    <button class="login"  onclick="javascript: window.location = 'login?log=out';">  <%= myres.getString("logout")%></button>
                    <%
                        }
                    %>
                </td>
                <td>
                    <button class="another" onclick="javascript: window.location = 'cart.jsp';"><%= myres.getString("cart")%> </button>
                </td>
                <td>
                    <%
                        if ((request.getSession().getAttribute("auth") != null) && (order.getSize()>0)) {
                    %>
                    <button class="another" onclick="javascript: window.location = 'purchase.jsp';"><%= myres.getString("purchase")%></button>
                    <%
                        }
                    %>
                </td>
            </tr>
        </tr>
    </table>

</body>

