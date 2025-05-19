/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author DELL
 */


/**
 * Classe représentant un livre dans la bibliothèque
 */
public class Livre {
    private int id;
    private String titre; 
    private String auteur;
    private String isbn;
    private int annee;
    private boolean disponible;
    
    public Livre(){}
    
    public Livre(String titre,String auteur,String isbn, int annee,boolean disponible){
//        this.id=id;
        this.annee=annee;
        this.auteur=auteur;
        this.disponible=disponible;
        this.isbn=isbn;
        this.titre=titre;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getAuteur() {
        return auteur;
    }

    public void setAuteur(String auteur) {
        this.auteur = auteur;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }
}