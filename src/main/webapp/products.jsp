<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.vastra.shopping.model.User" %>
<%@ page import="com.vastra.shopping.dao.ProductDao" %>
<%@ page import="com.vastra.shopping.connection.DbConnection" %>
<%@ page import="com.vastra.shopping.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.vastra.shopping.model.Cart" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: Narlapally Anil
  Date: 08-09-2021
  Time: 19:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //		response.setHeader("Pragma", "no-Cache");x
//        User auth = (User) request.getSession().getAttribute("auth");
    if (request.getSession().getAttribute("auth") == null) {
        response.setHeader("Cache-Control", "no-cache,no-store,no-transform,private,must-revalidate");
        response.sendRedirect("index.jsp");
    }

%>
<%
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth != null) {
        request.setAttribute("person", auth);
    }
    ProductDao pd = null;
    try {
        pd = new ProductDao(DbConnection.connect());
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
    List<Product> products = pd.getAllProducts();
//    System.out.println(products.size());
//    out.println(products.size());
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if (cart_list != null) {
        request.setAttribute("cart_list", cart_list);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/includes/head.jsp"%>
    <title>E-Commerce Cart</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Anil shopping Mall</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css"
          integrity="sha512-5A8nwdMOWrSz20fDsjczgUidUBR8liPYU+WymTZP1lmY9G6Oc7HlZv156XqnsgNUzTyMefFTcsFH/tnJE/+xBg=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">
</head>
<body>

<c:if test="${auth == null}">

<div class="container">
    <div class="navbar">
        <div class="logo">
            <a href="index.jsp"><img src="images/logo%20(1).png " width="100px"></a>
        </div>
        <nav>
            <ul id="MenuItems">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="products.jsp">Products</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="account.jsp">Account</a></li>
            </ul>
        </nav>
        <a href="cart.jsp"><img src="images/cart.png" width="30px" length="30px"><span class="badge badge-danger">${cart_list.size()}</span></a>
        <img src="images/menu.png" class="menu-icon" onclick="menutoggle()">
    </div>
</div>


<div class="container">
    <div class="card-header my-3">All Products</div>
    <div class="row">
        <%
            if (!products.isEmpty()) {
                for (Product p : products) {
        %>
        <div class="col-md-3 my-3">
            <div class="card w-100">
                <img class="card-img-top" src="product-image/<%=p.getImage() %>"
                     alt="Product Image">
                <div class="card-body">
                    <h5 class="card-title"><%=p.getName() %></h5>
                    <h6 class="price">Price: $<%=p.getPrice() %></h6>
                    <h6 class="category">Category: <%=p.getCategory() %></h6>
                    <div class="mt-3 d-flex justify-content-between">
                        <a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>">Add to Cart</a> <a
                            class="btn btn-primary" href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>
                    </div>
                </div>
            </div>
        </div>
        <img  src="product-image/"
        <%
                }
            } else {
                out.println("There is no products");
            }
        %>

    </div>
</div>

<%@include file="/includes/footer.jsp"%>
</c:if>
<c:if test="${auth != null}">


    <nav class="navbar navbar-light bg-light">
        <span class="navbar-brand mb-0 h1"><img src="images/logo%20(1).png" style="width: 150px;height: 60px"></span>
        <h3>Vastra Bushan Collection</h3>
        <h5>Hello,
            <c:if test="${auth.getFirstName() != null }">${auth.getFirstName()}</c:if>
            <c:if test="${auth.getLastName() != null }">${auth.getLastName()}</c:if>
            <c:if test="${auth.getFirstName() == null && auth.getLastName() == null}">${auth.getEmail()}</c:if>
        </h5>

    </nav>




    <nav class="navbar navbar-expand-lg bg-dark navbar-light"
         style="color: #ffffff">

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active"><a class="nav-link  mnu-itm"
                                               style="color: #ffffff" href="/homepage.jsp">Home<span
                        class="sr-only">(current)</span></a></li>

                <c:if test="${!auth.getRole().equals('Customer')}">
                    <li class="nav-item"><a class="nav-link mnu-itm" style="color: #ffffff" href="productAdd.jsp">Add Product</a> </li>

                </c:if>

                <li class="nav-item"><a class="nav-link mnu-itm" style="color: #ffffff" href="products.jsp">View Products</a> </li>

                <c:if test="${auth.getRole().equals('Customer')}">
                    <li class="nav-item"><a class="nav-link mnu-itm" style="color: #ffffff" href="orders.jsp">My Orders</a> </li>
                    <li class="nav-item"><a class="nav-link mnu-itm" style="color: #ffffff" href="cart.jsp">Cart</a> </li>
                </c:if>
                <c:if test="${auth.getRole().equals('Employee')}">
                    <li class="nav-item"><a class="nav-link mnu-itm" style="color: #ffffff" href="ordersList.jsp">Manage Orders</a> </li>
                </c:if>
                <c:if test="${auth.getRole().equals('Admin')}">
                    <li class="nav-item"><a class="nav-link mnu-itm" style="color: #ffffff" href="ordersList.jsp">Reports</a> </li>
                </c:if>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <ul class="nav justify-content-end">
                    <c:if test="${!auth.getRole().equals('Admin')}">
                        <li class="nav-item"><a class="nav-link mnu-itm" style="color: #ffffff" href="profile.jsp">Profile</a> </li>
                    </c:if>

                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/log-out"><i
                            class="fa fa-sign-out" aria-hidden="true"></i><button type="button" class="btn btn-outline-info">Logout</button></a></li>
                </ul>
            </form>
        </div>
    </nav>


    <div class="container">
        <div class="card-header my-3">All Products</div>
        <div class="row">
            <%
                if (!products.isEmpty()) {
                    for (Product p : products) {
            %>
            <div class="col-md-3 my-3">
                <div class="card w-100">
                    <img class="card-img-top" src="product-image/<%=p.getImage() %>"
                         alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title"><%=p.getName() %></h5>
                        <h6 class="price">Price: $<%=p.getPrice() %></h6>
                        <h6 class="category">Category: <%=p.getCategory() %></h6>
                        <div class="mt-3 d-flex justify-content-between">
                            <a class="btn btn-dark" href="add-to-cart?id=<%=p.getId()%>">Add to Cart</a> <a
                                class="btn btn-primary" href="order-now?quantity=1&id=<%=p.getId()%>">Buy Now</a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
                    out.println("There is no products");
                }
            %>

        </div>
    </div>

    <%@include file="includes/loginFooter.jsp"%>

</c:if>
</body>
</html>
