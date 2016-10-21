package etu.lab;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;
import java.util.ResourceBundle;
import static java.util.ResourceBundle.getBundle;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Product extends HttpServlet {

    private final static Logger log
            = Logger.getLogger(etu.lab.Product.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Locale locale = response.getLocale();
        Cookie cookie[] = request.getCookies();
        if (cookie != null) {
            for (Cookie c : cookie) {
                //log.info(c.getName()+"=" + c.getValue());
                if ("locale".equals(c.getName())) {
                    locale = new Locale(c.getValue());
                }
            }
        }

        // log.info("locale=" + lang);
        ResourceBundle myres = getBundle("strings", locale);

        try (PrintWriter out = response.getWriter()) {
            String id = request.getParameter("id");

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<link rel='stylesheet' href='tabStyles.css'>");

            out.println("<title>Potion Store - Product info</title>");
            out.println("<script src='tabs.js'></script>");
            out.println("<script src='change.js'></script>");
            //out.println("<h1>" + myres.getString("storeName") + "</h1>");
            //out.println("<img align='right' hspace='3' style = 'cursor: pointer;' onclick=\"changeLocale('lat')\" title='Latinae' onclick='' src='images/RI.png'></img>");
            //out.println("<img align='right' hspace='3' style = 'cursor: pointer;' onclick=\"changeLocale('en')\" title='English' src='images/UK.png'></img>");
            //out.println("<img align='right' hspace='3' style = 'cursor: pointer;' onclick=\"changeLocale('ru')\" title='Русский' src='images/RU.png'></img>");
            out.println("</head>");
            out.println("<body bgcolor='#F8FCD9' style=\"background-image:url(images/bg.png)\">");
            out.println(" <div>\n"
                    + "            <table align=\"center\" style=\"width:1100px;\" table-layout=\"fixed\">\n"
                    + "                <tr>\n"
                    + "\n"
                    + "                    <td  colspan=\"1\" width=\"275\">\n"
                    + "                        <img src=\"images/logo.png\" height=\"130px\" width=\"260px\"></img>\n"
                    + "                    </td>\n"
                    + "                    <td  colspan=\"2\">\n"
                    + "                        <div class=\"header\">" + myres.getString("storeName") + "</div>   \n"
                    + "                    </td>\n"
                    + "                    <td align=\"right\" colspan=\"1\" width=\"400\">\n"
                    + "                        <div>\n");
            out.println("<img align='right' hspace='3' style = 'cursor: pointer;' onclick=\"changeLocale('lat')\" title='Latinae' onclick='' src='images/RI.png'></img>");
            out.println("<img align='right' hspace='3' style = 'cursor: pointer;' onclick=\"changeLocale('en')\" title='English' src='images/UK.png'></img>");
            out.println("<img align='right' hspace='3' style = 'cursor: pointer;' onclick=\"changeLocale('ru')\" title='Русский' src='images/RU.png'></img>");

            out.println("                        </div>\n"
                    + "                    </td>\n"
                    + "\n"
                    + "                </tr>\n"
                    + "                <tr>\n"
                    + "                    <td colspan=\"4\" width=\"1100\">\n"
                    + "                        <div class=\"blockM\"> </div>\n"
                    + "                    </td>\n"
                    + "                </tr><tr><td colspan='4' align='center'>");
            out.println("<div class='itemP'><table align='center' width='550'cellpadding=\"10px\">\n"
                    + "  <tr>\n"
                    + "    <td rowspan=\"2\"><div><img src='images/img0" + id + ".png'></img></div></td>");
            out.println("<td valign='top'><p align='center' class='other tabHead'>" + myres.getString("Pot" + id) + "</p></td> </tr>");
            out.println(" <tr>\n"
                    + "   <td align='center' valign='top'><button class='buyBut' onclick='link("+id+","+myres.getString("p" + id)+");'>" + myres.getString("buy") + "</button></td>\n"
                    + "  </tr>\n");
            //+ "</table>");
            out.println("<tr><td colspan='2'><ul class=\"tab\">\n"
                    + "  <li><a href=\"#\" class=\"tabsB\" id=\"shortD0\" onclick=\"openTab(event, 'shortD')\">" + myres.getString("shortDiscr") + "</a></li>\n"
                    + "  <li><a href=\"#\" class=\"tabsB\" id=\"longD0\" onclick=\"openTab(event, 'longD')\">" + myres.getString("longDiscr") + "</a></li>\n"
                    + "  <li><a href=\"#\" class=\"tabsB\" id=\"feedback0\" onclick=\"openTab(event, 'feedback')\">" + myres.getString("feedback") + "</a></li>\n"
                    + "</ul>\n"
                    + "\n"
                    + "<div id=\"shortD\" class=\"tabs\">\n"
                    + "  <p>" + myres.getString("Short" + id) + "</p>\n"
                    + "</div>\n"
                    + "\n"
                    + "<div id=\"longD\" class=\"tabs\">\n"
                    + "  <p>" + myres.getString("Long" + id) + "</p> \n"
                    + "</div>\n"
                    + "\n"
                    + "<div id=\"feedback\" class=\"tabs\">\n"
                    + "</div></tr></td></table></td></tr></table></div>");
            out.println("<script> openTab(null,'" + getInitParameter("firstTab") + "') </script>");
            out.println(" <script type=\"text/javascript\">\n" +
"            function link(num,pr){    \n" +
"                document.cookie='newOrder='+num;  \n" +
"                document.cookie='newPrice='+pr; \n" +
"                window.location='cart.jsp';\n"  +
"            };\n" +
"            </script>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
