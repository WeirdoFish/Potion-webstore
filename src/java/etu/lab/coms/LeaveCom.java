package etu.lab.coms;

import etu.lab.bd.DBWork;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LeaveCom extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String user = request.getParameter("user");
            String text = request.getParameter("text");
            Date datetime = new Date();
            Locale lang = getLang(request,response);
            SimpleDateFormat dateForm=getDateFormat(lang);
            
            if (user != null && text != null) {
                DBWork.addComment(user, text, datetime);

                PrintWriter ajax_resp = response.getWriter();
                ajax_resp.print(user + "#_#" + dateForm.format(datetime)+ "#_#" + text);
                // response.sendRedirect("cabinet.jsp");
            }
        }
    }

    protected Locale getLang(HttpServletRequest request, HttpServletResponse response) {
        Locale locale = response.getLocale();
        Cookie cookie[] = request.getCookies();
        if (cookie != null) {
            for (Cookie c : cookie) {
                if ("locale".equals(c.getName())) {
                    locale = new Locale(c.getValue());
                }
            }
        }
        return locale;
    }

    protected SimpleDateFormat getDateFormat(Locale locale) {
        String lang = locale.getLanguage();
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMMM yyyy HH:mm", locale);;
        if (lang.equals(new Locale("ru").getLanguage())) {
            dateFormat = new SimpleDateFormat("dd MMMMM yyyy HH:mm", locale);
        } else if (lang.equals(new Locale("en").getLanguage())) {
            dateFormat = new SimpleDateFormat("MMMMM dd yyyy HH:mm", locale);
        } else if (lang.equals(new Locale("lat").getLanguage())) {
            DateFormatSymbols mon = new DateFormatSymbols() {

                @Override
                public String[] getMonths() {
                    return new String[]{"Januarius", "Februarius", "Martius", "Aprilis", "Maius", "Junius",
                        "Julius", "Augustus", "September", "October", "November", "December"};
                }

            };
            dateFormat = new SimpleDateFormat("dd MMMMM yyyy HH:mm", mon);
        }
        return dateFormat;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
