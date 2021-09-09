<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.vastra.shopping.model.User" %><%--
  Created by IntelliJ IDEA.
  User: Narlapally Anil
  Date: 09-09-2021
  Time: 06:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/loginHead.jsp"%>
<% User auth2 = (User) request.getSession().getAttribute("auth");

%>
<div class="container w-75 border border-info" style="margin-top: 20px;padding-top: 25px;padding-bottom: 25px;margin-bottom: 25px">
<form action="/profile" method="post">
    <div class="form-row">
        ${errorUpdate}
        <div class="form-group col-md-6">
            <label for="inputEmail4">First Name</label>
            <input type="text" class="form-control" id="inputEmail4" name="fname" value="<%=auth2.getFirstName()%>" placeholder="First Name" required>
        </div>
        <div class="form-group col-md-6">
            <label for="inputPassword4">Last Name</label>
            <input type="text" class="form-control" id="inputPassword4" placeholder="Last Name" value="<%=auth2.getLastName()%>" name="lname" required>
        </div>
    </div>
    <div class="form-group">
        <label for="inputAddress">Address</label>
        <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St" value="<%=auth2.getAddress()%>" name="address" required>
    </div>
    <div class="form-row">
        <div class="form-group col-md-6">
            <label for="inputCity">Country</label>
            <input type="text" class="form-control" id="inputCity" name="country" value="<%=auth2.getCountry()%>" required>
        </div>
        <div class="form-group col-md-4">
            <label for="inputState">State</label>
            <input type="text" class="form-control" id="inputState" name="state" value="<%=auth2.getState()%>" required>
        </div>
        <div class="form-group col-md-2">
            <label for="inputZip">City</label>
            <input type="text" class="form-control" id="inputZip" name="city" value="<%=auth2.getDistrict()%>" required>
        </div>
    </div>
    <div>

        <div class="form-group col-sm-6">
            <input type="text" value="<%=auth2.getGender()%>" readonly>
            <label>Gender</label>
            <input type="radio" name="gender" value="male" class="col-sm-2" required> Male
            <input type="radio" name="gender" value="female" class="col-sm-2"> Female
            <input type="radio" name="gender" value="other" class="col-sm-2"> Other
        </div>

        <div class="form-group col-md-4" >
            <label for="inputDob">Date of Birth</label>
            <input type="date" class="form-control" id="inputDob" value="<%=auth2.getDob()%>" name="dob"required>
        </div>
    </div>
    <div class="form-group">
        <label>Email Id</label>
        <input type="email" class="form-control" id="email" value="<%=auth2.getEmail()%>" name="email" readonly>
    </div>

    <div class="row w-80" style="padding: 15px 15px 15px 50px;margin-left: 25px;">
        <div class="col-6 p-2"> &emsp;&emsp;
            <button type="submit" class="btn btn-success col-6">Update Profile</button>
        </div>
        <div class="col-6 p-2"> &emsp;&emsp;
            <a href="homepage.jsp"><button type="button" class="btn btn-secondary col-4">Close</button></a>
        </div>
    </div>

</form>
</div>


<%@include file="includes/loginFooter.jsp"%>
