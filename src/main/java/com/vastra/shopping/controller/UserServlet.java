package com.vastra.shopping.controller;

import com.vastra.shopping.connection.DbConnection;
import com.vastra.shopping.dao.UserDao;
import com.vastra.shopping.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.regex.Pattern;

@WebServlet(name = "UserServlet", urlPatterns = {"/insert","/profile"})
public class UserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        try {
            switch (action) {
                case "/insert":
                    insertUser(request, response);
                    break;
                case "/profile":
                    profileUpdate(request,response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void profileUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException, ClassNotFoundException {
        String firstName=request.getParameter("fname");
        String lastName=request.getParameter("lname");
        String email=request.getParameter("email");
        String address=request.getParameter("address");
        String country=request.getParameter("country");
        String state=request.getParameter("state");
        String district=request.getParameter("city");
        Date date= Date.valueOf(request.getParameter("dob"));
        String gender=request.getParameter("gender");

        User user=new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setAddress(address);
        user.setCountry(country);
        user.setState(state);
        user.setDistrict(district);
        user.setDob(date);
        user.setGender(gender);


        UserDao userDao=new UserDao();
        boolean rowUpdate=userDao.updateUser(user);
        if(rowUpdate)
            response.sendRedirect("homepage.jsp");
        else{
            request.setAttribute("errorUpdate","Profile not updated");
            getServletContext().getRequestDispatcher("/profile.jsp").forward(request, response);
        }
    }


    private void insertUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ClassNotFoundException {
        String emailId=request.getParameter("email");
        String password=request.getParameter("password");
        String confirmPassword=request.getParameter("confirmPassword");

        emailId=emailId.toLowerCase();


        if(emailId.isEmpty() && password.isEmpty() && confirmPassword.isEmpty()){
            request.setAttribute("errorReg","All fields are important");
            getServletContext().getRequestDispatcher("/account.jsp").forward(request,response);
        }
        else if(emailId.isEmpty()){
            request.setAttribute("errorReg","Enter the valid email id");
            getServletContext().getRequestDispatcher("/account.jsp").forward(request,response);
        }
        else if(password.isEmpty()){
            request.setAttribute("errorReg","please enter the password");
            getServletContext().getRequestDispatcher("/account.jsp").forward(request,response);
        }
        else if(confirmPassword.isEmpty()){
            request.setAttribute("errorReg","please re-enter the password");
            getServletContext().getRequestDispatcher("/account.jsp").forward(request,response);
        }
        else{
            String result=isValid(password,confirmPassword);
            if(result.isEmpty()) {
                User user = new User();
                user.setEmail(emailId);
                user.setPassword(password);
                UserDao userDao=new UserDao();
                boolean insertSuccess=userDao.insertUser(user);
                if(insertSuccess)
                    request.setAttribute("errorReg", "Account Created Successfully.please click login");
                else{
                    request.setAttribute("errorReg","Email Id Already Exists");
                    getServletContext().getRequestDispatcher("/account.jsp").forward(request, response);
                }
            }
            else{
                request.setAttribute("errorReg",result);
            }
            getServletContext().getRequestDispatcher("/account.jsp").forward(request, response);
        }
    }



    public static String isValid(String password, String confirmPassword) {

        Pattern specialCharPatten = Pattern.compile("[^a-z0-9 ]", Pattern.CASE_INSENSITIVE);
        Pattern UpperCasePatten = Pattern.compile("[A-Z ]");
        Pattern lowerCasePatten = Pattern.compile("[a-z ]");
        Pattern digitCasePatten = Pattern.compile("[0-9 ]");
        String result="";

        if (!password.equals(confirmPassword)) {
            result="password and confirm password does not match";
        }
        else if (password.length() < 8) {
            result="Password length must have at least 8 character !!";
        }
        else if (!specialCharPatten.matcher(password).find()) {
            result="Password must have at least one special character !!";
        }
        else if (!UpperCasePatten.matcher(password).find()) {
            result="Password must have at least one uppercase character !!";
        }
        else if (!lowerCasePatten.matcher(password).find()) {
            result="Password must have at least one lowercase character !!";
        }
        else if (!digitCasePatten.matcher(password).find()) {
            result="Password must have at least one digit character !!";
        }
        return result;
    }

}
