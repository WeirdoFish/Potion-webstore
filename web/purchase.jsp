<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="etu.lab.bd.Items"%>
<%@page import="org.hibernate.cfg.AnnotationConfiguration"%>
<%@page import="java.util.Date"%>
<%@page import="org.hibernate.HibernateException"%>
<%@page import="etu.lab.bd.MyHibernateUtil"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>

<%@page import="net.sf.ehcache.hibernate.HibernateUtil"%>
<%@page import="etu.lab.bd.History"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>

        <c:if test="${empty cookie.locale.value}">
            <fmt:setBundle basename="strings"/> 
            <fmt:setLocale value="${pageContext.getLocale()}) "/>
        </c:if>       
        <c:if test="${cookie.locale.value eq 'ru'}">
            <fmt:setBundle basename="strings_ru"/>
        </c:if>

        <c:if test="${cookie.locale.value eq 'en'}">
            <fmt:setBundle basename="strings_en"/>
        </c:if>

        <c:if test="${cookie.locale.value eq 'lat'}">
            <fmt:setBundle basename="strings_lat"/>
        </c:if>

        <title>Potion Store - Purchase</title>
        <link rel='stylesheet' href='tabStyles.css'>
    </head>
    <body  bgcolor="#F8FCD9" style="background-image:url(images/bg.png)">

        <div>
            <table align="center" style="width:1100px;" table-layout="fixed">
                <tr>

                    <td  colspan="1" width="275">
                        <img src="images/logo.png" style = 'cursor: pointer;' onclick="javascript: window.location = 'index.jsp';" height="130px" width="260px"></img>
                    </td>
                    <td  colspan="2">
                        <div class="header"><fmt:message key="storeName"/></div>   
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
                        <%
                            Session session2
                                    //SessionFactory sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
                                    //Session  session2=new AnnotationConfiguration().configure().buildSessionFactory().openSession();
                                    = MyHibernateUtil.getSessionFactory().openSession();
                            Transaction tx = null;
                            StringBuilder sb = new StringBuilder();
                            Integer resId = null;
                            Integer itId = null;
                            try {
                                tx = session2.beginTransaction();
                                History h = new History("user", new Date(), "somewhere", 300);
                                Items items = new Items(1, 2, h);

                                resId = (Integer) session2.save(h);
                                session2.save(items);
                                // Сохранение нового объекта
                                tx.commit();
                                // sb.append("<br>Название товара: ").append(h.get());
                                // sb.append(";");
                                //sb.append("Магазин: ").append(h.getMarket()).append(";<br>");
                            } catch (HibernateException e) {
                                if (tx != null) {
                                    tx.rollback();
                                }
                                e.printStackTrace();
                            } finally {
                                session2.close();
                            }

                            Session session3 = null;
                            Transaction txx = null;

                            try {
                                session3 = MyHibernateUtil.getSessionFactory().openSession();
                                txx = session3.beginTransaction();
                                List list = session3.createQuery("FROM History").list();


                                for (Iterator iterator = list.iterator(); iterator.hasNext();) {
                                    History cur = (History) iterator.next();  
                                    out.println(cur.getCustomer()+"</br>");
                                }
                                txx.commit();
                            } catch (HibernateException e) {
                                if (tx != null) {
                                    tx.rollback();
                                }
                                e.printStackTrace();
                            } finally {
                                session3.close();
                            }
                        %>
                    </td>
                </tr>

            </table>
    </body>
</html>

