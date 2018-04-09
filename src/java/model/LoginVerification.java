/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author nmohamed
 */

import Controllers.Homepage;
import com.microsoft.sqlserver.jdbc.SQLServerDriver;

import java.sql.Connection;
import java.sql.DriverManager;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
public class LoginVerification {
    
    public LoginVerification(){}
    public static Connection SQLConnection() throws SQLException {
        System.out.println("database.SQLMicrosoft.SQLConnection()");
        String url = "jdbc:sqlserver://ca-pan.odbc.renweb.com\\ca_pan:1433;databaseName=ca_pan";
        String loginName = "CA_PAN_CUST";
        String password = "RansomSigma+339";
        DriverManager.registerDriver(new SQLServerDriver());
        Connection cn = null;
        try {

            cn = DriverManager.getConnection(url, loginName, password);
        } catch (SQLException ex) {
            System.out.println("No se puede conectar con el Motor");
            System.err.println(ex.getMessage());
        }

        return cn;
    }

    public static ResultSet Query(Connection conn, String queryString) throws SQLException {
        Statement stmt = null;
        ResultSet rs = null;
        stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
        ResultSet.CONCUR_READ_ONLY);
        rs = stmt.executeQuery(queryString);
        //stmt.close();
        //conn.close();
        return rs;
    }

    public User consultUserDBRenWeb(String user,String password) throws Exception {
        User u = null;
       //user = 'shahad' and pswd = 'shahad1234' group = Spring
        String query = "select * from Person where username = '"+user+"' and pswd = HASHBYTES('MD5', CONVERT(nvarchar(4000),'"+password+"'));";
     
         ResultSet rs = Homepage.renweb.executeQuery(query);
         if(!rs.next()) 
         {u=new User();
                 u.setId(0);}
         else{
             rs.beforeFirst();
            while(rs.next()){
               
                u = new User();
                u.setName(rs.getString("username"));
                u.setPassword(password);
                u.setId(rs.getInt("PersonID"));

            }}
        return u;
    }
    
    public User consultUserDBOwn(String user,String password) throws Exception {
        User u = new User(0);
       //user = 'shahad' and pswd = 'shahad1234' group = Spring
        String query = "select * from user where name = '"+user+"';";
     
        ResultSet rs = Homepage.own.executeQuery(query);
        if(!rs.next())
            return u;
        else{
            rs.beforeFirst();
            while(rs.next()){
                u = new User(rs.getInt("id"),rs.getString("pass"),user);
            }
        }
        if(!u.isPassValid(password))
            u=new User(0);
        
        return u;
    }
    
    public int getSecurityGroupID(String name) throws SQLException{
        int sgid = 0;
        String query ="select groupid from SecurityGroups where Name like '"+name+"'";
        ResultSet rs = Homepage.renweb.executeQuery(query);
            while(rs.next()){
                sgid = rs.getInt(1);
            }
        return sgid;
    }
    
    public boolean fromGroup(int groupid, int staffid) throws SQLException{
        boolean aux  = false;
        String query = "select * from SecurityGroupMembership where groupid = "+groupid+" and StaffID = " + staffid;
        ResultSet rs = Homepage.renweb.executeQuery(query);
            while(rs.next()){
                aux = true;
            }
      
        return aux;
    }
    
        public ArrayList<Students> isparent(int userid)throws SQLException {
      
            String query ="SELECT s.FirstName,s.LastName,s.GradeLevel,f.ParentID,ps.StudentID FROM Students as s inner join Parent_Student as ps on ps.StudentID = s.StudentID inner join Family as f on f.ParentID = ps.ParentID where f.PersonID = '"+userid+"'";
            ResultSet rs = Homepage.renweb.executeQuery(query);
            ArrayList<Students> children = new ArrayList<>();
            while(rs.next()){
                Students child = new Students();
                child.setId_students(rs.getInt("StudentID"));
                child.setLevel_id(rs.getString("GradeLevel"));
                child.setNombre_students(rs.getString("FirstName")+" "+rs.getString("LastName"));
                children.add(child);
            }
            return children;
        }
    
}
