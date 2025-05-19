/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author DELL
 */
public class Membre {
    private int id;
    private String nom;
    private String prenom;
//    private String email;
    private String telephone;
    private double amendes;

    // Constructeurs
    public Membre() {
        this.amendes = 0.0;
    }

    public Membre(int id, String nom) {
        this.id = id;
        this.nom = nom;
        this.amendes = 0.0;
    }

    public Membre(int id, String nom, String prenom, String telephone) {
        this.id = id;
        this.nom = nom;
        this.prenom = prenom;
//        this.email = email;
        this.telephone = telephone;
        this.amendes = 0.0;
    }
    
    public Membre(String nom, String prenom, String telephone) {
        this.nom = nom;
        this.prenom = prenom;
//        this.email = email;
        this.telephone = telephone;
        this.amendes = 0.0;
    }

    // Getters et setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

//    public String getEmail() {
//        return email;
//    }

//    public void setEmail(String email) {
//        this.email = email;
//    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public double getAmendes() {
        return amendes;
    }

    public void setAmendes(double amendes) {
        this.amendes = amendes;
    }

    // Optionnel : méthode d'affichage
    @Override
    public String toString() {
        return "Membre{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
//                ", email='" + email + '\'' +
                ", telephone='" + telephone + '\'' +
                ", amendes=" + amendes +
                '}';
    }
}
