<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="etu.lab.bd.Notes"%>
<%@page import="etu.lab.bd.DBWork"%>
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
        <jsp:useBean id="order" class="etu.lab.CartBean" scope="session"/>


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
                    <c:if test="${order.getSize() eq 0 }">
                        <td align="center" colspan="4" >
                            <p class="other">Вы можете перейти <a class="alink" href="history.jsp"> к истории покупок</a></p>

                        </td>
                    </c:if>

                    <c:if test="${order.getSize() ne 0 }">

                        <td align="center" colspan="3" >

                            <div id="map"  style="height: 500px; width: 600px;"></div>

                        </td>
                        <td  colspan="1" align="top">
                            <div class="itemP" style="width:300px;">
                                <div  align="top">
                                    <p><p class="other"><b>Выберите способ доставки:</p></b><Br>

                                    <input type="radio"  name="ship" value="market" checked onclick="changeShip()"> Самовывоз из магазина</br>
                                    <input type="radio" name="ship" value="courier" onclick="changeShip()"> Доставка курьером</br>

                                    </p>
                                </div>

                                <div class="shipping" id="courier_ch" style="display:none;"> 
                                    <form action="ordering" method="POST" name="cour_form" >
                                        <input  type="text" class="adress" name="adress" placeholder="..." required></input>
                                        <input  name="courier" value="true" style="display:none;"></input>
                                        </br>
                                        <input  class = "buyBut" type="submit" >

                                    </form>
                                </div>

                                <div class="shipping" id="market_ch">
                                    <form action="ordering" method="POST" name="mark_form">
                                        <select id ="mark_inp" name="adress" class="filter" onchange="openMarker()">
                                            <option  value='<fmt:message key="m1"/>'><fmt:message key="m1"/></option>
                                            <option  value='<fmt:message key="m2"/>'><fmt:message key="m2"/></option>
                                            <option  value='<fmt:message key="m3"/>'><fmt:message key="m3"/></option>
                                        </select>
                                        </br>
                                        <input class = "buyBut" type="submit">
                                    </form>
                                </div>
                            </div>
                        </td>
                    </c:if>

                </tr>
            </table>

            <script type="text/javascript">
                function changeShip() {
                    var chooses = document.getElementsByClassName("shipping");
                    chooses[0].style.display = "none";
                    chooses[1].style.display = "none";

                    if (document.getElementsByName("ship")[0].checked === true) {
                        document.getElementById("market_ch").style.display = "block";

                    } else {
                        document.getElementById("courier_ch").style.display = "block";
                    }
                }
                ;

                function initMap() {
                    var myLatlng = new google.maps.LatLng(59.9500019, 30.3144831, 17);
                    var myOptions = {
                        zoom: 12,
                        center: myLatlng,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    };
                    map = new google.maps.Map(document.getElementById("map"), myOptions);
                    place1 = new google.maps.LatLng(59.9258963, 30.3247093, 19.75);
                    place2 = new google.maps.LatLng(59.9753886, 30.3211598, 21);
                    place3 = new google.maps.LatLng(59.9402745, 30.3485747, 21);

                    var marker1 = new google.maps.Marker({
                        position: place1
                    });

                    var marker2 = new google.maps.Marker({
                        position: place2
                    });

                    var marker3 = new google.maps.Marker({
                        position: place3
                    });


                    var infowindow1 = new google.maps.InfoWindow({
                        content: '<div id="content">Гороховая ул. 57а</div>'
                    });
                    var infowindow2 = new google.maps.InfoWindow({
                        content: '<div id="content">Аптекарский пр. 9</div>'
                    });
                    var infowindow3 = new google.maps.InfoWindow({
                        content: '<div id="content">Литейный пр. 32</div>'
                    });


                    google.maps.event.addListener(marker1, 'click', function () {
                        infowindow1.open(map, marker1);
                        document.getElementById("mark_inp").selectedIndex = 0;
                    });
                    google.maps.event.addListener(marker2, 'click', function () {
                        infowindow2.open(map, marker2);
                        document.getElementById("mark_inp").selectedIndex = 1;
                    });
                    google.maps.event.addListener(marker3, 'click', function () {
                        infowindow3.open(map, marker3);
                        document.getElementById("mark_inp").selectedIndex = 2;
                    });

                    marker1.setMap(map);
                    marker2.setMap(map);
                    marker3.setMap(map);

                }
                function openMarker() {
                    var place = document.getElementById("mark_inp").selectedIndex;
                    map.setZoom(16);
                    if (place === 0) {
                        map.setCenter(place1);
                    }
                    if (place === 1) {
                        map.setCenter(place2);
                    }
                    if (place === 2) {
                        map.setCenter(place3);
                    }
                }



            </script>
            <script async defer
                    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5uSMpepNgp2_ZA4sTKD9Rac5G2a7z0HY&callback=initMap">

            </script>
    </body>
</html>

