/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Chema
 */
public class Ticket {
    private int id;
    private String createtime;
    private int parentid;
    private int costumerid;
    private String status;
    
    public Ticket(int id) {
        this.id = id;
    }

    public Ticket(int id, String createtime, int parentid, int costumerid, String status) {
        this.id = id;
        this.createtime = createtime;
        this.parentid = parentid;
        this.costumerid = costumerid;
        this.status = status;
    }
    
    
    @Override
    public boolean equals(Object obj){
        return ((Ticket)obj).id==this.id;
    }
    
    /*
    -----------------------
    ---GETTER AND SETTER---
    -----------------------
    */
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String date) {
        this.createtime = date;
    }

    public int getParentid() {
        return parentid;
    }

    public void setParentid(int parentid) {
        this.parentid = parentid;
    }

    public int getCostumerid() {
        return costumerid;
    }

    public void setCostumerid(int costumerid) {
        this.costumerid = costumerid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
    
}
