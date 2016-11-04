package etu.lab.bd;

import etu.lab.CartBean;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Ordering extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       // response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        CartBean order = (CartBean) session.getAttribute("order");
        String ship = "";
        if (request.getParameter("courier") != null) {
            ship = "Доставка по адресу: ";
        } else {
            ship = "Самовывоз из: ";
        }
        ship += request.getParameter("adress");
        if (order.getSize() != 0) {
            DBWork.addOrder(session.getAttribute("username").toString(), ship, order);
        }

        response.sendRedirect("purchase.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
