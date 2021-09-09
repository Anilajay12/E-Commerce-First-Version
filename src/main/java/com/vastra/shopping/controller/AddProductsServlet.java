package com.vastra.shopping.controller;

import com.vastra.shopping.connection.DbConnection;
import com.vastra.shopping.dao.ProductDao;
import com.vastra.shopping.model.Product;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AddProductsServlet", value = "/addProduct")
public class AddProductsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productCategory= request.getParameter("prod_cate");
        String productName= request.getParameter("prod_name");
        Double productPrice = Double.valueOf(request.getParameter("prod_price"));
        Double taxAmount = Double.valueOf(request.getParameter("prod_tax"));
        String productPicture = request.getParameter("prod_pic");
        String email = request.getParameter("email");


        Product product=new Product();
        product.setName(productName);
        product.setCategory(productCategory);
        product.setPrice(productPrice + taxAmount);
        product.setImage(productPicture);

        ProductDao productDao=new ProductDao();
        boolean rowInsert = false;
        try {
            rowInsert = productDao.insertSingleProduct(product);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        if(rowInsert)
            getServletContext().getRequestDispatcher("/products.jsp").forward(request, response);
        else {
            request.setAttribute("errorAddProduct","Product Not Added");
            getServletContext().getRequestDispatcher("/productAdd.jsp").forward(request, response);
        }
    }
}
