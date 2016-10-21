<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.Cookie" %>
<%@page import="java.util.ResourceBundle" %>
<%@page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
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
        <script src='change.js'></script>
        <link rel='stylesheet' href='tabStyles.css'>
        <title>JSP Page</title>
    </head>
    <body>
        <table>
            <tr>
                <td colspan="3">
                    <div class="loc">
                        <img align='right' hspace='3' style = 'cursor: pointer;' onclick="changeLocale('lat')" title='Latinae' onclick='' src='images/RI.png'></img>
                        <img align='right' hspace='3' style = 'cursor: pointer;' onclick="changeLocale('en')" title='English' src='images/UK.png'></img>
                        <img align='right' hspace='3' style = 'cursor: pointer;' onclick="changeLocale('ru')" title='Русский' src='images/RU.png'></img>
                    </div>
                </td>
            <tr>
                <td>
                    <button class="login">  <%= myres.getString("login")%></button>
                </td>
                <td>
                    <button class="another" onclick="javascript: window.location='cart.jsp';"><%= myres.getString("cart")%> </button>
                </td>
                <td>
                    <button class="another"><%= myres.getString("history")%></button>
                </td>
            </tr>
        </tr>
    </table>

</body>
</html>
