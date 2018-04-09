/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;

/**
 * Clase que representa un arbol con multiples hijos por padre
 * @author Chema
 */
public class Arbol<T> {
    private T valor;
    private Arbol<T> padre;
    private ArrayList<Arbol<T>> hijos;

    public Arbol(T valor) {
        this.valor = valor;
        this.padre = null;
        hijos = new ArrayList();
    }
    
    public Arbol(T valor, Arbol<T> padre) {
        this.valor = valor;
        this.padre = padre;
        hijos = new ArrayList();
    }
    
    public Arbol(T valor, Arbol<T> padre, ArrayList<Arbol<T>> hijos) {
        this.valor = valor;
        this.padre = padre;
        this.hijos = hijos;
    }
    
    
    
    public boolean esRaiz(){
        return padre==null;
    }
    
    
    
    public boolean insertar(Arbol<T> elem){
        boolean ret = false;
        if(elem.padre != null && elem.padre.equals(this)){
            elem.padre = this;
            this.hijos.add(elem);
            ret = true;
        } else{
            for(Arbol<T> a:hijos){
                ret |= a.insertar(elem);
            }
        }
        return ret;
    }
    
    public boolean eliminar(Arbol<T> elem){
        boolean ret = false;
        if(elem.padre != null && elem.equals(this)){
            elem.padre.hijos.remove(elem);
            ret = true;
        } else{
            for(Arbol<T> a:hijos)
                ret |= a.eliminar(elem);
        }
        return ret;
    }
    
    public Arbol<T> busqueda(T value){
        Arbol<T> ret = null;
        if(value.equals(this.valor)){
            ret = this;
        } else{
            for(Arbol<T> a:hijos){
                ret = a.busqueda(value);
                if(ret!=null)
                    break;
            }
        }
        return ret;
    }

    @Override
    public boolean equals(Object elem){
        return ((Arbol<T>)elem).valor.equals(this.valor);
    }
    
    /*
    --------------------
    --- GETTER Y SETER--
    --------------------
    */
    
    public T getValor() {
        return valor;
    }

    public void setValor(T valor) {
        this.valor = valor;
    }

    public Arbol<T> getPadre() {
        return padre;
    }

    public void setPadre(Arbol<T> padre) {
        this.padre = padre;
    }

    public ArrayList<Arbol<T>> getHijos() {
        return hijos;
    }

    public void setHijos(ArrayList<Arbol<T>> hijos) {
        this.hijos = hijos;
    }
    
    
    
}
