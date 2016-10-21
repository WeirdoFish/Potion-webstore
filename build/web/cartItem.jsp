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
        <title>prewiev</title>
        <link rel='stylesheet' href='tabStyles.css'>
        <script src='getParam.js'></script>
    </head>
    <body>
        <div class="itemC"> 
            <table>
                <tr>
                    <td>
                        <% String temp = request.getParameter("id");
                            out.println("<img height='90px' src='images/img0" + temp + ".png'></img>");
                        %>
                    </td>
                    <td>
                            <div class="textset">

                                <b>  <% out.println("<a color='#F48A4E' class='alink' href='/WebStoreP/product?id=" + temp + "'>");
                                %>
                                <%= myres.getString("Pot" + temp)%> </b></a></br>
                            <%= myres.getString("Short" + temp)%>
                        </div>
                    </td>
                    
                    
                </tr>

            </table>
        </div>
    </body>
        <script type="text/javascript">
          
            </script>
</html>
