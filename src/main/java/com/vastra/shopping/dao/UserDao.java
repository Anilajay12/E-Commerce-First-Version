package com.vastra.shopping.dao;

import java.sql.*;

import com.vastra.shopping.connection.DbConnection;
import com.vastra.shopping.model.User;

public class UserDao {
	private Connection con;

	private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public UserDao(){

    }
	public UserDao(Connection con) {
		this.con = con;
	}
	
	public User userLogin(String email, String password) {
		User user = null;
        try {
            query = "select * from users where email=? and password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, password);
            rs = pst.executeQuery();
            if(rs.next()){
            	user = new User();
            	user.setId(rs.getInt("id"));
            	user.setFirstName(rs.getString("firstname"));
                user.setLastName(rs.getString("lastname"));
            	user.setEmail(rs.getString("email"));
                user.setDob(rs.getDate("dob"));
                user.setGender(rs.getString("gender"));
                user.setCountry(rs.getString("country"));
                user.setState(rs.getString("state"));
                user.setDistrict(rs.getString("city"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return user;
    }

    public boolean insertUser(User user) throws SQLException, ClassNotFoundException {
        final String insertQuery="insert into users (email,password,role) values (?,?,?)";
        PreparedStatement preparedStatement= DbConnection.connect().prepareStatement(insertQuery);
        preparedStatement.setString(1,user.getEmail());
        preparedStatement.setString(2,user.getPassword());
        if(user.getRole() == null)
            preparedStatement.setString(3,"Customer");
        else
            preparedStatement.setString(3,"Employee");
        boolean rowInserted = false;
        try{
            if(preparedStatement.executeUpdate() > 0)
                rowInserted=true;
        }catch (SQLException e){
            rowInserted = false;
        }

        preparedStatement.close();
        DbConnection.disconnect();
        return rowInserted;
    }

    public boolean updateUser(User user) throws SQLException, ClassNotFoundException {
        boolean rowUpdate;
        query = "update users set firstname=?,lastname=?,dob=?,gender=?,country=?,state=?,city=?,address=? where email = ?";
        pst=DbConnection.connect().prepareStatement(query);
        pst.setString(1,user.getFirstName());
        pst.setString(2,user.getLastName());
        pst.setDate(3,user.getDob());
        pst.setString(4,user.getGender());
        pst.setString(5,user.getCountry());
        pst.setString(6,user.getState());
        pst.setString(7,user.getDistrict());
        pst.setString(8,user.getAddress());
        pst.setString(9,user.getEmail());


        rowUpdate = pst.executeUpdate() > 0;
        return  rowUpdate;
    }
}
