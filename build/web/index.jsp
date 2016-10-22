<%@page import="etu.lab.ProdBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.Cookie" %>
<%@page import="java.util.ResourceBundle" %>
<%@page import="java.util.Locale" %>
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

            Cookie coo[] = request.getCookies();
            String selectId = "opt1";
            String selectPrice = "p0";
            if (coo != null) {
                for (Cookie c : coo) {
                    if ("categ".equals(c.getName())) {
                        selectId = c.getValue();
                    }
                    if ("price".equals(c.getName())) {
                        selectPrice = c.getValue();
                    }
                }
            }
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Potion Store - Catalog</title>
        <link rel='stylesheet' href='tabStyles.css'>
        <jsp:useBean id="Bean1" class="etu.lab.ProdBean" scope="request">
            <jsp:setProperty name="Bean1" property="price" value="p2" />
            <jsp:setProperty name="Bean1" property="tag" value="opt2 opt5" />
            <jsp:setProperty name="Bean1" property="link" value="prewiev.jsp?id=1&price=${myRes.p1}" />
        </jsp:useBean>
        <jsp:useBean id="Bean2" class="etu.lab.ProdBean" scope="request">
            <jsp:setProperty name="Bean2" property="price" value="p2" />
            <jsp:setProperty name="Bean2" property="tag" value="opt5" />
            <jsp:setProperty name="Bean2" property="link" value="prewiev.jsp?id=2&price=${myRes.p2}" />
        </jsp:useBean>
        <jsp:useBean id="Bean3" class="etu.lab.ProdBean" scope="request">
            <jsp:setProperty name="Bean3" property="price" value="p3" />
            <jsp:setProperty name="Bean3" property="tag" value="opt3" />
            <jsp:setProperty name="Bean3" property="link" value="prewiev.jsp?id=3&price=${myRes.p3}" />
        </jsp:useBean>
        <jsp:useBean id="Bean4" class="etu.lab.ProdBean" scope="request">
            <jsp:setProperty name="Bean4" property="price" value="p2" />
            <jsp:setProperty name="Bean4" property="tag" value="opt3 opt4 opt5" />
            <jsp:setProperty name="Bean4" property="link" value="prewiev.jsp?id=4&price=${myRes.p4}" />
        </jsp:useBean>
        <jsp:useBean id="Bean5" class="etu.lab.ProdBean" scope="request">
            <jsp:setProperty name="Bean5" property="price" value="p3" />
            <jsp:setProperty name="Bean5" property="tag" value="opt2 opt5" />
            <jsp:setProperty name="Bean5" property="link" value="prewiev.jsp?id=5&price=${myRes.p5}" />
        </jsp:useBean>
        <jsp:useBean id="Bean6" class="etu.lab.ProdBean" scope="request">
            <jsp:setProperty name="Bean6" property="price" value="p2" />
            <jsp:setProperty name="Bean6" property="tag" value="opt3 opt4" />
            <jsp:setProperty name="Bean6" property="link" value="prewiev.jsp?id=6&price=${myRes.p6}" />
        </jsp:useBean>
        <jsp:useBean id="Bean7" class="etu.lab.ProdBean" scope="request">
            <jsp:setProperty name="Bean7" property="price" value="p3" />
            <jsp:setProperty name="Bean7" property="tag" value="opt3 opt4" />
            <jsp:setProperty name="Bean7" property="link" value="prewiev.jsp?id=7&price=${myRes.p7}" />
        </jsp:useBean>
        <jsp:useBean id="Bean8" class="etu.lab.ProdBean" scope="request">
            <jsp:setProperty name="Bean8" property="price" value="p4" />
            <jsp:setProperty name="Bean8" property="tag" value="opt4" />
            <jsp:setProperty name="Bean8" property="link" value="prewiev.jsp?id=8&price=${myRes.p8}" />
        </jsp:useBean>
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
                    <td valign="top" colspan="1" width="275">

                        <b><p class="other"><%=myres.getString("cat")%></p></b>
                        <select name='category' class="filter" onchange="categChanged();">
                            <%
                                for (int i = 1; i < 6; i++) {
                                    if (("opt" + Integer.toString(i)).equals(selectId)) {
                                        out.println("<option value='opt" + i + "' selected>" + myres.getString("option" + i) + "</option>");
                                    } else {
                                        out.println("<option value='opt" + i + "'>" + myres.getString("option" + i) + "</option>");
                                    }
                                }
                            %>

                        </select>

                        <b><p class="other"><%=myres.getString("price")%></p></b>
                        <select name='price' class="filter" onchange="categChanged();">
                            <%
                                for (int i = 1; i < 5; i++) {
                                    if (("p" + Integer.toString(i)).equals(selectPrice)) {
                                        out.println("<option value='p" + i + "' selected>" + myres.getString("pr" + i) + "</option>");
                                    } else {
                                        out.println("<option value='p" + i + "'>" + myres.getString("pr" + i) + "</option>");
                                    }
                                }
                            %>

                        </select>
                    </td>
                    <td colspan="3" width="825" valign="top">


                        <%
                            ProdBean[] beans = {Bean1, Bean2, Bean3, Bean4, Bean5, Bean6, Bean7, Bean8};
                            for (int i = 0; i < 8; i++) {
                        %>
                        <div  style="display:none;" class="list <%=beans[i].getTag()%> <%=beans[i].getPrice()%>">
                            <jsp:include page="<%=beans[i].getLink()%>"/>
                        </div>
                        <%
                            }
                        %>


                    </td>
                </tr>
            </table>

        </div>


    </body>
    <script src='js/getParam.js'></script>
    <script srcs='js/change.js'></script>
    <script src='js/filter.js'></script>
    <script type="text/javascript">

                            window.onload = function () {
                                var products = document.getElementsByClassName("list");
                                var value = getCookie("categ");
                                var pValue = getCookie("price");

                                if (value === "opt1" || !value) {
                                    for (i = 0; i < products.length; i++) {
                                        products[i].style.display = "block";
                                    }
                                } else {
                                    var choose = document.getElementsByClassName(value);

                                    for (i = 0; i < products.length; i++) {
                                        products[i].style.display = "none";
                                    }

                                    for (i = 0; i < choose.length; i++) {
                                        choose[i].style.display = "block";
                                    }
                                }
                                var prices = document.getElementsByClassName("list");
                                if (pValue !== "p1" && pValue) {
                                    for (i = 0; i < prices.length; i++) {
                                        if (!prices[i].classList.contains(pValue)) {
                                            prices[i].style.display = "none";
                                        }
                                    }
                                }
                            };
                            function getCookie(name) {
                                var matches = document.cookie.match(new RegExp(
                                        "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
                                        ));
                                return matches ? decodeURIComponent(matches[1]) : undefined;
                            }


    </script>
</html>
