package com.vastra.shopping.controller;

import com.vastra.shopping.connection.DbConnection;
import com.vastra.shopping.dao.UserDao;
import com.vastra.shopping.model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String email = request.getParameter("login-email");
			String password = request.getParameter("login-password");

			if(email.isEmpty() && password.isEmpty()){
				request.setAttribute("errorLogin","enter email and password");
				getServletContext().getRequestDispatcher("/account.jsp").forward(request,response);
			}
			else if(email.isEmpty()){
				request.setAttribute("errorLogin","Enter the emailId");
				getServletContext().getRequestDispatcher("/account.jsp").forward(request,response);
			}
			else if(password.isEmpty()){
				request.setAttribute("errorLogin","Enter the password also");
				getServletContext().getRequestDispatcher("/account.jsp").forward(request,response);
			}
			else{
				User user = new User();
				user.setEmail(email);
				user.setPassword(password);
				UserDao udao = new UserDao(DbConnection.connect());
				user = udao.userLogin(email, password);
				if (user != null) {
					request.getSession().setAttribute("auth", user);
//				System.out.print("user logged in");
					response.sendRedirect("homepage.jsp");
				} else {
					request.setAttribute("errorLogin","Invalid Credentials");
					getServletContext().getRequestDispatcher("/account.jsp").forward(request,response);
				}

			}
		}
		catch (SQLException | ClassNotFoundException throwables) {
			throwables.printStackTrace();
		}
	}
}
