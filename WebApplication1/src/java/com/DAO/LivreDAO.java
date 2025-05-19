/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.connexion.Connexion;
//import com.essai.SQLException;
import com.model.Livre;

/**
 *
 * @author DELL
 */

import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LivreDAO {

    public void ajouterLivre(Livre livre) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO livre (titre, auteur, isbn, annee, disponible) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, livre.getTitre());
            stmt.setString(2, livre.getAuteur());
            stmt.setString(3, livre.getIsbn());
            stmt.setInt(4, livre.getAnnee());
            stmt.setBoolean(5, true);
            stmt.executeUpdate();
        }
    }

    public void supprimerLivre(int id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM livre WHERE id = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public void modifierLivre(Livre livre) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE livre SET titre=?, auteur=?, isbn=?, annee=? WHERE id=?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, livre.getTitre());
            stmt.setString(2, livre.getAuteur());
            stmt.setString(3, livre.getIsbn());
            stmt.setInt(4, livre.getAnnee());
            stmt.setInt(5, livre.getId());
            stmt.executeUpdate();
        }
    }

    public List<Livre> listerLivres() throws SQLException, ClassNotFoundException {
        List<Livre> livres = new ArrayList<>();
        String sql = "SELECT * FROM livre";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Livre livre = new Livre();
                livre.setId(rs.getInt("id"));
                livre.setTitre(rs.getString("titre"));
                livre.setAuteur(rs.getString("auteur"));
                livre.setIsbn(rs.getString("isbn"));
                livre.setAnnee(rs.getInt("annee"));
                livre.setDisponible(rs.getBoolean("disponible"));
                livres.add(livre);
            }
        }
        return livres;
    }

    
    public void mettreAJourDisponibiliteLivre(int idLivre, boolean dispo) throws SQLException {
    String sql = "UPDATE livres SET disponible = ? WHERE id = ?";

    try (
        Connection conn = Connexion.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)
    ) {
        ps.setBoolean(1, dispo);
        ps.setInt(2, idLivre);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace(); // Tu peux remplacer par un Logger si tu préfères
    }   catch (ClassNotFoundException ex) {
            Logger.getLogger(LivreDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
}

}