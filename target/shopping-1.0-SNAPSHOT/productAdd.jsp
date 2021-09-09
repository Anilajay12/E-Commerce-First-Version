<%--
  Created by IntelliJ IDEA.
  User: Narlapally Anil
  Date: 08-09-2021
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.vastra.shopping.model.User" %>
<%@ page import="com.vastra.shopping.connection.DbConnection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Narlapally Anil
  Date: 07-09-2021
  Time: 08:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%@include file="includes/loginHead.jsp"%>
<marquee behavior="scroll" direction="left" scrollamount="15" style="color: red;background-color: black;font-size: 35px;">Here,You can Add the new Product Details</marquee>
<div class="container container-fluid border border-info p-2" style="height: 100vh;margin: 30px 200px 30px 350px;">
  <h1 class="text-center border badge-info m-3" style="padding: 25px 0px 25px 0px;"><u>Add Product</u></h1>
  <hr>
  <table>
    <form action="/addProduct" method="POST">

      <div>${errorAddProduct}</div>

      <div class="row w-80" style="padding:30px 0 5px 50px;margin-left: 25px;">
        <div class="col-4">
          <label>Choose the product category : </label>
        </div>
        <div class="col-8">
          <select class="form-control col-8" name="prod_cate">
            <option disabled>Select</option>
            <%
              try{

                String sql="select category from products";
                PreparedStatement preparedStatement=DbConnection.connect().prepareStatement(sql);
                ResultSet resultSet=preparedStatement.executeQuery();
                while(true){
                  try {
                    if (!resultSet.next()) break;
                  } catch (SQLException e) {
                    e.printStackTrace();
                  }
            %>
            <option> <%= resultSet.getString("category")%></option> <%
              }
              DbConnection.disconnect();
            } catch (SQLException | ClassNotFoundException throwables) {
              throwables.printStackTrace();
            }
          %>
          </select>
        </div>
      </div>

      <div class="row w-80" style="padding:30px 0 5px 50px;margin-left: 25px;">
        <div class="col-4">
          <label>Enter Product Name : </label>
        </div>
        <div class="col-8">
          <input type="text" class="form-control col-8" placeholder="category" name="prod_name" required>
        </div>
      </div><br>


      <div class="row w-80" style="padding-left: 50px;margin-left: 25px;">
        <div class="col-4">
          <label>Enter Product Price : </label>
        </div>
        <div class="col-8">
          <input type="text" class="form-control col-lg-8" placeholder="Price" name="prod_price"
                 required>
        </div>
      </div><br>

      <div class="row w-80" style="padding-left: 50px;margin-left: 25px;">
        <div class="col-4">
          <label>Enter Tax Amount: </label>
        </div>
        <div class="col-8">
          <input type="text" class="form-control col-8" placeholder="name" name="prod_tax" required>
        </div>
      </div><br>

      <div class="row w-80" style="padding-left: 50px;margin-left: 25px;">
        <div class="col-4">
          <label>Choose Product Image : </label>
        </div>
        <div class="col-8">
          <div class="form-group">

            <input type="file" class="form-control-file" id="exampleFormControlFile1" name="prod_pic" required>
          </div>
        </div>
        <input type="text" name="email" hidden value="${user.getEmail()}">
      </div>

      <div class="row w-80" style="padding: 15px 15px 15px 50px;margin-left: 25px;">
        <div class="col-4 p-2"> &emsp;&emsp;
          <button type="submit" class="btn btn-success col-6">Save Category</button>
        </div>
        <div class="col-8 p-2"> &emsp;&emsp;
          <a href="products.jsp"><button type="button" class="btn btn-secondary col-4">Close</button></a>
        </div>
      </div>



    </form>
  </table>
</div>

<%@include file="includes/loginFooter.jsp"%>
</body>
</html>

