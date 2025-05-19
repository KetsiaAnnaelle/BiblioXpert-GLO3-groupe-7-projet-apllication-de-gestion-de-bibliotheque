/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;
import com.connexion.Connexion;
import com.model.Membre;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */


public class MembreDAO {
//    private Connection conn;

//    public MembreDAO(Connection conn) {
//        this.conn = conn;
//    }
 
    public void ajouterMembre(Membre membre) throws SQLException {
        String sql = "INSERT INTO membre(nom, prenom, telephone, amendes) VALUES (?, ?, ?, ?)";
        try (
                Connection conn = Connexion.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, membre.getNom());
            stmt.setString(2, membre.getPrenom());
//            stmt.setString(3, membre.getEmail());
            stmt.setString(3, membre.getTelephone());
            stmt.setDouble(4, membre.getAmendes());
            stmt.executeUpdate();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MembreDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Membre> listerMembres() throws SQLException {
        List<Membre> membres = new ArrayList<>();
        String sql = "SELECT * FROM membre";
        try (
                Connection conn = Connexion.getConnection();
                Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Membre membre = new Membre(
                    rs.getInt("id"),
                    rs.getString("nom"),
                    rs.getString("prenom"),
//                    rs.getString("email"),
                    rs.getString("telephone")
                );
                membre.setAmendes(rs.getDouble("amendes"));
                membres.add(membre);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MembreDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return membres;
    }
}

