/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import Controllers.Homepage;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Chema
 */
public class Consultas {
    
    public static Arbol<Ticket> getTickets(){
        Arbol<Ticket> ret = new Arbol<Ticket>(new Ticket(0),null);
        String consulta = "select * from ticket";
        try {
            ResultSet rs = Homepage.own.executeQuery(consulta);
            while(rs.next()){
                Ticket t = new Ticket(rs.getInt("id"), rs.getString("createtime")
                        ,rs.getInt("parentid"),rs.getInt("customerid"), rs.getString("status"));
                ret.insertar(t);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Consultas.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ret;
    }
    
    
}
