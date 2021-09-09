package com.vastra.shopping.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
    private static final String jdbcURL="jdbc:mysql://localhost:3306/ecommerce_cart";
    private static final String jdbcUserName="Admin";
    private static final String jdbcPassword="Admin";

    private static Connection connection=null;

    public static Connection connect() throws SQLException, ClassNotFoundException {
        if(connection == null || connection.isClosed()){
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL,jdbcUserName,jdbcPassword);
        }
//        System.out.println("db connected");
        return connection;
    }

    public static void disconnect() throws SQLException {
        if(connection !=null || !connection.isClosed())
            connection.close();
        connection = null;
//        System.out.println("db disconnected");
    }
}
