<%--
  Created by IntelliJ IDEA.
  User: Narlapally Anil
  Date: 08-09-2021
  Time: 22:36
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- Bootstrap CSS -->

  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
        integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
  <style>
    * {
      margin: 0px;
      padding: 0px;
      box-sizing: border-box;
    }

    .collapse ul li {
      margin-left: 10px;
      margin-right: 25px;
    }

    nav {
      background-color: #e3f2fd;
    }

    a {
      color: #fff;
    }

    .fa {
      margin-right: 8px;
    }

    .carousel-item img {
      height: 500px;
      margin-top:5%;
      margin-left:25%;
      margin-right:20%;
      margin-bottom:5%;
      width:900px;
      border: solid black;
    }

    nav li {
      padding-left: 5px;
    }

    .footer {
      text-align: center;
      background-color: black;
      color: white;
      padding-top: 10px;
      padding-bottom: 10px;
    }

    .footertext {
      text-transform: uppercase;
      height: 40px;
    }
    .mnu-itm:hover{
      /*text-transform: uppercase;*/
      border: 1px solid #ffffff;
      border-radius: 25px;
    }
  </style>
  <title>Welcome Page</title>
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
          integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous">
  </script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
          integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous">
  </script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
          integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous">
  </script>
</head>

<body>
  <%
    //		response.setHeader("Pragma", "no-Cache");x
    User auth = (User) request.getSession().getAttribute("auth");
    if (auth == null) {
        response.setHeader("Cache-Control", "no-cache,no-store,no-transform,private,must-revalidate");
        response.sendRedirect("index.jsp");
    }

%>

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


