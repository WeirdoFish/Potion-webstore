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
        <div class="item"> 
            <table>
                <tr>
                    <td>
                        <% String temp = request.getParameter("id");
                            out.println("<img height='90px' src='images/img0" + temp + ".png'></img>");
                            //<jsp:getProperty name="Bean1" property="id"/>
                        %>
                    </td>
                    <td>

                        <b> 
                            <div class="textset">

                                <% out.println("<a color='#F48A4E' class='alink' href='/WebStoreP/product?id=" + temp + "'>");
                                %>
                                <%= myres.getString("Pot" + temp)%> </b></a></br>
                            <%= myres.getString("Short" + temp)%>
                        </div>
                    </td>
                    <td>
                        <div class="butset">
                            <button class="buyBut" valign="center" align="center" onclick="link(<%=temp%>,<%= myres.getString("p"+temp)%>);"> 

                            <%= myres.getString("buy")%> </button>
                       <!-- <button class="another" valign="center" align="center"> <%= myres.getString("cartBut")%> </button>-->
                        </div>
                    </td>
                </tr>

            </table>
        </div>
    </body>
        <script type="text/javascript">
            function link(num,pr){    
                document.cookie='newOrder='+num;  
                document.cookie='newPrice='+pr; 
                window.location='cart.jsp';
            };
            </script>
</html>
