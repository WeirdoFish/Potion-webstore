package etu.lab.log;

import etu.lab.CartBean;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Date;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserFilter implements Filter {

    private static final boolean debug = true;
    private FilterConfig filterConfig = null;
    private String[] pages = {"auth.jsp", "cabinet.jsp", "cart.jsp",
        "index.jsp", "auth-error.jsp", "purchase.jsp",
        "product", "ordering", "login",
        "history.jsp"};

    public UserFilter() {
    }

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession();
        String name = "гость";

        if (session.getAttribute("username") != null) {
            name = session.getAttribute("username").toString();
        }

        if (debug) {
            String page = getPage(req.getHeader("referer"));
            String action = getAction(req, page);
            if (page != null && action != null) {
                log("*------Новое действие------*");
                log("Пользователь: " + name);
                log("Время:  " + (new Date()).toString());
                log("На странице:  " + page);
                log("Действие: " + action);
            }
        }

        chain.doFilter(request, response);

    }

    private String getPage(String uri) {
        if (uri != null) {
            for (String p : pages) {
                int slt = uri.lastIndexOf("/");
                if (slt == uri.length() - 1) {
                    return "index.jsp";
                }

                int tmp = uri.lastIndexOf(p);
                if (tmp >= 0) {
                    return p;
                }
            }
        }
        return null;
    }

    private String getAction(HttpServletRequest req, String page) {
        String action = null;
        try {
            String temp = getPage(req.getRequestURL().toString());
            if (temp != null) {
                action = temp;
                switch (action) {
                    case "auth.jsp":
                        action = "Переход на страницу авторизации";
                        break;
                    case "auth-error.jsp":
                        action = "Ошибка авторизации";
                        break;
                    case "login":
                        String log = req.getParameter("log");
                        if (log.equals("in")) {
                            action = "Авторизация";
                        } else {
                            action = "Выход";
                        }
                        break;
                    case "j_security_check":
                        action = "Попытка авторизации";
                        break;
                    case "cart.jsp": {
                        Cookie[] cookie = req.getCookies();
                        String pri = "";
                        String id = "";
                        if (cookie != null) {
                            for (Cookie c : cookie) {
                                if ("newPrice".equals(c.getName())) {
                                    pri = c.getValue();
                                }
                                if ("newOrder".equals(c.getName())) {
                                    id = c.getValue();
                                }
                            }
                            if (pri.equals("-1")) {
                                action = "Товар с id=" + id + " был удалён из корзины";
                            } else if (!pri.equals("")) {
                                action = "Товар с id=" + id + " был добавлен в корзину";
                            } else {
                                action = "Переход на страницу корзины";
                            }

                        }
                        break;
                    }
                    case "product": {
                        String id = "";
                        if (req.getParameter("id") != null) {
                            id = req.getParameter("id");
                        }
                        if (!id.equals("")) {
                            action = "Просмотр товара с id=" + id;
                        } else {
                            action = "Авторизация";
                        }
                        break;
                    }
                    case "cabinet.jsp":
                        action = "Переход в личный кабинет";
                        break;
                    case "history.jsp":
                        action = "Просмотр истории";
                        break;
                    case "purchase.jsp": {
                        action = "Просмотр страницы заказа (пусто)";
                        HttpSession session = req.getSession();
                        if ((CartBean) session.getAttribute("order") != null) {
                            CartBean order = (CartBean) session.getAttribute("order");
                            if (order.getSize() != 0) {
                                action = "Оформление заказа";
                            }
                        }
                        break;
                    }
                    case "ordering":
                        action = "Сохранение заказа";
                        break;
                    case "index.jsp": {
                        action = "Просмотр списка товаров";
                        if ((req.getParameter("categ") != null) || (req.getParameter("price") != null)) {
                            String filter1 = "",
                                    filter2 = "";
                            if (req.getParameter("categ") != null) {
                                filter1 = " categ = " + req.getParameter("categ");
                            }
                            if (req.getParameter("price") != null) {
                                filter2 = " price = " + req.getParameter("price");
                            }
                            action = "Фильтрация списка товаров с параметрами: " + filter1 + filter2;
                        }
                    }
                    break;
                    default:
                        break;
                }
            }
        } catch (Exception e) {

        }
        return action;
    }

    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    public void destroy() {
    }

    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("UserFilter:Initializing filter");
            }
        }
    }

    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("UserFilter()");
        }
        StringBuffer sb = new StringBuffer("UserFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
