/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 *
 * @author nmohamed
 */
public class User {

    private static BCryptPasswordEncoder bcryptEncoder = new BCryptPasswordEncoder();
    
    private int id;
    private String name;
    private String lang;
    private int type;
    private String hashedAndSalted;

    public User(int id) {
        this.id = id;
        hashedAndSalted = "";
    }
    
    public User(int id,String hashedAndSalted,String nombre) {
        this.id = id;
        this.name = nombre;
        this.hashedAndSalted = hashedAndSalted;
    }
    
    public User() {}
    
    public boolean isPassValid(String pass) {
        return bcryptEncoder.matches(pass, hashedAndSalted);		
    }

    /**
     * Generate a hashed&salted hex-string from a user's pass and salt
     * @param pass to use; no length-limit!
     * @return a string to store in the BD that does not reveal the password even
     * if the DB is compromised. Note that brute-force is possible, but it will
     * have to be targeted (ie.: use the same salt)
     */
    public static String generateHashedAndSalted(String pass) {
        
        String s = bcryptEncoder.encode(pass);
        return s;
    }	
    
    
    
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
     private String password;

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLang() {
        return lang;
    }

    public void setLang(String lang) {
        this.lang = lang;
    }
    
    
}
