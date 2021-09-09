<%--
  Created by IntelliJ IDEA.
  User: Narlapally Anil
  Date: 09-09-2021
  Time: 08:09
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.*"%>
<%@ page import="com.vastra.shopping.model.User" %>
<%@ page import="com.vastra.shopping.model.Order" %>
<%@ page import="com.vastra.shopping.dao.OrderDao" %>
<%@ page import="com.vastra.shopping.connection.DbConnection" %>
<%@ page import="com.vastra.shopping.model.Cart" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);
    User auth2 = (User) request.getSession().getAttribute("auth");
    List<Order> orders = null;
    if (!auth2.getRole().equalsIgnoreCase("Customer")) {
        request.setAttribute("person", auth2);
        OrderDao orderDao  = new OrderDao(DbConnection.connect());
        orders = orderDao.allOrders();
    }else{
        response.sendRedirect("account.jsp");
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }

%>
<%@include file="includes/loginHead.jsp"%>

<div class="container">
    <div class="card-header my-3">All Orders</div>
    <table class="table table-light">
        <thead>
        <tr>
            <th scope="col">Order Id</th>
            <th scope="col">User Id</th>
            <th scope="col">Quantity</th>
            <th scope="col">Order Date</th>
            <th scope="col">Cancel</th>
        </tr>
        </thead>
        <tbody>

        <%
            if(orders != null){
                for(Order o:orders){%>
        <tr>
            <td><%=o.getOrderId() %></td>
            <td><%=o.getId() %></td>
            <td><%=o.getQuantity() %></td>
            <td><%=o.getDate() %></td>
            <td><a class="btn btn-sm btn-danger" href="cancel-order?id=<%=o.getOrderId()%>">Cancel Order</a></td>
        </tr>
        <%}
        }
        %>

        </tbody>
    </table>
</div>
<%@include file="includes/loginFooter.jsp"%>
