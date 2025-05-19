/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;
import com.connexion.Connexion;
import com.model.User;
import java.sql.*;

/**
 *
 * @author DELL
 */

public class UserDAO {

    public boolean Connexion(User user) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM user WHERE email = ? AND mdp = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getMdp());

            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    public void inscrireUtilisateur(User user) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO utilisateurs (email, mdp) VALUES (?, ?)";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getMdp());
            stmt.executeUpdate();
        }
    }
}

