/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;
import com.connexion.Connexion;
import com.model.Emprunt;

import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */

public class EmpruntDAO {

    public void emprunterLivre(Emprunt emprunt) throws SQLException, ClassNotFoundException {
        String insert = "INSERT INTO emprunts (id_livre, id_membre, date_emprunt) VALUES (?, ?, ?)";
        String update = "UPDATE livre SET disponible = false WHERE id = ?";

        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt1 = conn.prepareStatement(insert);
             PreparedStatement stmt2 = conn.prepareStatement(update)) {

            stmt1.setInt(1, emprunt.getIdLivre());
            stmt1.setInt(2, emprunt.getIdMembre());
            stmt1.setDate(3, emprunt.getDateEmprunt() != null ? Date.valueOf(emprunt.getDateEmprunt()) : null);
            stmt1.executeUpdate();

            stmt2.setInt(1, emprunt.getIdLivre());
            stmt2.executeUpdate();
        }
    }


    public void enregistrerEmprunt(Emprunt emprunt) throws SQLException {
        String insert = "INSERT INTO emprunts (id_membre, id_livre, date_retour_prevue) VALUES (?, ?, ?)";
        String updateLivre = "UPDATE livres SET disponible = false WHERE id = ?";

        try (
                Connection conn = Connexion.getConnection();
                PreparedStatement stmt1 = conn.prepareStatement(insert);
                PreparedStatement stmt2 = conn.prepareStatement(updateLivre)) {

            stmt1.setInt(1, emprunt.getIdMembre());
            stmt1.setInt(2, emprunt.getIdLivre());
            stmt1.setDate(3, Date.valueOf(emprunt.getDateRetourPrevue()));
            
            // Si la date de retour est fournie
//            if (emprunt.getDateRetour() != null) {
//                stmt1.setDate(4, Date.valueOf(emprunt.getDateRetour()));
//            } else {
//                stmt1.setNull(4, Types.DATE);
//            }

            stmt1.executeUpdate();

            // Rendre le livre indisponible
            stmt2.setInt(1, emprunt.getIdLivre());
            stmt2.executeUpdate();
        }   catch (ClassNotFoundException ex) {
                Logger.getLogger(EmpruntDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
    }

    public List<Emprunt> listerEmprunts() throws SQLException {
    List<Emprunt> emprunts = new ArrayList<>();
    String sql = "SELECT * FROM emprunts";

    try (
        Connection conn = Connexion.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Emprunt e = new Emprunt();
            e.setId(rs.getInt("id"));
            e.setIdLivre(rs.getInt("id_livre"));
            e.setIdMembre(rs.getInt("id_membre"));

            Date sqlDateEmp = rs.getDate("date_emprunt");
            Date sqlDateRetPrevue = rs.getDate("date_retour_prevue");
            Date sqlDateRetour = rs.getDate("date_retour");

            LocalDate dateEmprunt = sqlDateEmp != null ? sqlDateEmp.toLocalDate() : null;
            LocalDate dateRetourPrevue = sqlDateRetPrevue != null ? sqlDateRetPrevue.toLocalDate() : null;
            LocalDate dateRetour = sqlDateRetour != null ? sqlDateRetour.toLocalDate() : null;

            e.setDateEmprunt(dateEmprunt);
            e.setDateRetourPrevue(dateRetourPrevue);
            e.setDateRetour(dateRetour);

            // ✅ Calcul de l'amende (sans écrire en base)
            if (dateRetourPrevue != null && dateRetour != null && dateRetour.isAfter(dateRetourPrevue)) {
                long joursDeRetard = ChronoUnit.DAYS.between(dateRetourPrevue, dateRetour);
                int amende = (int) (joursDeRetard * 100); // 100 FCFA/jour
                e.setAmende(amende);
            } else {
                e.setAmende(0);
            }

            emprunts.add(e);
        }
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(EmpruntDAO.class.getName()).log(Level.SEVERE, null, ex);
    }

    return emprunts;
}


    public void retournerLivre(int idEmprunt, LocalDate dateRetour) throws SQLException, ClassNotFoundException {
        String sqlUpdateEmprunt = "UPDATE emprunts SET date_retour = ?, amende = ? WHERE id = ?";
        String sqlGetEmpruntInfos = "SELECT id_livre, date_retour_prevue FROM emprunts WHERE id = ?";
        String sqlUpdateLivre = "UPDATE livre SET disponible = true WHERE id = ?";

        try (
            Connection conn = Connexion.getConnection();
            PreparedStatement stmtInfos = conn.prepareStatement(sqlGetEmpruntInfos);
            PreparedStatement stmtUpdateEmprunt = conn.prepareStatement(sqlUpdateEmprunt);
            PreparedStatement stmtUpdateLivre = conn.prepareStatement(sqlUpdateLivre)
        ) {
            // 1. Récupérer les infos de l’emprunt
            stmtInfos.setInt(1, idEmprunt);
            ResultSet rs = stmtInfos.executeQuery();

            if (!rs.next()) {
                throw new SQLException("Aucun emprunt trouvé avec l'ID " + idEmprunt);
            }

            int idLivre = rs.getInt("id_livre");
            Date dateRetourPrevueSql = rs.getDate("date_retour_prevue");
            LocalDate dateRetourPrevue = dateRetourPrevueSql != null ? dateRetourPrevueSql.toLocalDate() : null;

            // 2. Calcul de l’amende
            int amende = 0;
            if (dateRetourPrevue != null && dateRetour.isAfter(dateRetourPrevue)) {
                long joursRetard = ChronoUnit.DAYS.between(dateRetourPrevue, dateRetour);
                amende = (int) joursRetard * 100; // 100 FCFA par jour de retard
            }

            // 3. Mise à jour de l’emprunt
            stmtUpdateEmprunt.setDate(1, Date.valueOf(dateRetour));
            stmtUpdateEmprunt.setInt(2, amende);
            stmtUpdateEmprunt.setInt(3, idEmprunt);
            stmtUpdateEmprunt.executeUpdate();

            // 4. Marquer le livre comme disponible
            stmtUpdateLivre.setInt(1, idLivre);
            stmtUpdateLivre.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            throw e; // On laisse le contrôle à l’appelant
        }
    }
    
   public List<Emprunt> listerEmpruntsRetournes() throws SQLException, ClassNotFoundException {
    List<Emprunt> emprunts = new ArrayList<>();
    String sql = "SELECT * FROM emprunts WHERE date_retour IS NOT NULL";

    try (Connection conn = Connexion.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Emprunt emprunt = new Emprunt();
            emprunt.setId(rs.getInt("id"));
            emprunt.setIdLivre(rs.getInt("id_livre"));
            emprunt.setIdMembre(rs.getInt("id_membre"));
            emprunt.setDateEmprunt(rs.getDate("date_emprunt").toLocalDate());
            emprunt.setDateRetour(rs.getDate("date_retour").toLocalDate());
            emprunt.setDateRetourPrevue(rs.getDate("date_retour_prevue").toLocalDate());
            emprunt.setAmende(rs.getInt("amende"));

            // Si tu veux aussi récupérer les infos du livre et de l’étudiant,
            // tu peux faire une jointure ici ou récupérer via leurs DAOs respectifs.

            emprunts.add(emprunt);
        }
    }

    return emprunts;
}

    
    
    
    
    
    public Emprunt trouverParId(int id) throws SQLException, ClassNotFoundException {
        Emprunt emprunt = null;
        String sql = "SELECT * FROM emprunts WHERE id = ?";

        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                emprunt = new Emprunt(
                    rs.getInt("id"),
                    rs.getInt("id_membre"),
                    rs.getInt("id_livre"),
                    rs.getDate("date_emprunt") != null ? rs.getDate("date_emprunt").toLocalDate() : null,
                    rs.getDate("date_retour") != null ? rs.getDate("date_retour").toLocalDate() : null,
                    rs.getDate("date_retour_prevue") != null ? rs.getDate("date_retour_prevue").toLocalDate() : null,
                    rs.getInt("amende")
                );
            }
        }

        return emprunt;
    }


    public List<Emprunt> empruntsNonRendus() throws SQLException, ClassNotFoundException {
        List<Emprunt> emprunts = new ArrayList<>();
        String sql = "SELECT * FROM emprunts WHERE date_retour IS NULL";

    try (Connection conn = Connexion.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()) {

           while (rs.next()) {
               Emprunt e = new Emprunt();
               e.setId(rs.getInt("id"));
               e.setIdLivre(rs.getInt("id_livre"));
               e.setIdMembre(rs.getInt("id_membre"));
               e.setDateEmprunt(rs.getDate("date_emprunt").toLocalDate());
               e.setDateRetourPrevue(rs.getDate("date_retour_prevue") != null ? rs.getDate("date_retour_prevue").toLocalDate() : null);
               e.setAmende(rs.getInt("amende"));

               emprunts.add(e);
           }
       }

        return emprunts;
    }

  
    public void mettreAJour(Emprunt emprunt) throws SQLException {
    String sql = "UPDATE emprunts SET date_retour = ? WHERE id = ?";

    try (
        Connection conn = Connexion.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)
    ) {
        if (emprunt.getDateRetour() != null) {
            ps.setDate(1, java.sql.Date.valueOf(emprunt.getDateRetour())); // LocalDate → SQL
        } else {
            ps.setNull(1, java.sql.Types.DATE);
        }

        ps.setInt(2, emprunt.getId());
        ps.executeUpdate();

    } catch (SQLException e) {
        e.printStackTrace();
    }   catch (ClassNotFoundException ex) {
            Logger.getLogger(EmpruntDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
}

    
     public void supprimerEmprunt(int id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM emprunts WHERE id = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
     
    public Emprunt getEmpruntById(int id) {
       String sql = "SELECT * FROM emprunts WHERE id = ?";
       try (Connection conn = Connexion.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
           stmt.setInt(1, id);
           ResultSet rs = stmt.executeQuery();
           if (rs.next()) {
               Emprunt emprunt = new Emprunt();
               emprunt.setId(rs.getInt("id"));
               emprunt.setIdMembre(rs.getInt("idMembre"));
               emprunt.setIdLivre(rs.getInt("idLivre"));
               emprunt.setDateEmprunt(rs.getDate("dateEmprunt").toLocalDate());
               if (rs.getDate("dateRetourPrevue") != null)
                   emprunt.setDateRetourPrevue(rs.getDate("dateRetourPrevue").toLocalDate());
               return emprunt;
           }
       } catch (Exception e) {
           e.printStackTrace();
       }
       return null;
   }

    
     public boolean enregistrerRetour(int idEmprunt, LocalDate dateRetour) {
        String sql = "UPDATE emprunts SET dateRetour = ?, amende = ? WHERE id = ?";

        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql))
        {

            // Calculer l'amende si nécessaire
            Emprunt emprunt = getEmpruntById(idEmprunt); // à implémenter
            long daysLate = 0;
            double amende = 0;

            if (emprunt.getDateRetourPrevue() != null) {
                daysLate = java.time.temporal.ChronoUnit.DAYS.between(
                    emprunt.getDateRetourPrevue(), dateRetour);
                if (daysLate > 0) {
                    amende = daysLate * 100; // par exemple, 100 FCFA par jour
                }
            }

            stmt.setDate(1, java.sql.Date.valueOf(dateRetour));
            stmt.setDouble(2, amende);
            stmt.setInt(3, idEmprunt);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Emprunt> historiqueParLivre(int idLivre) throws SQLException, ClassNotFoundException {
        List<Emprunt> historique = new ArrayList<>();
        String sql = "SELECT * FROM emprunts WHERE id_livre = ?";

        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idLivre);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Emprunt e = new Emprunt();
                e.setId(rs.getInt("id"));
                e.setIdLivre(rs.getInt("id_livre"));
                e.setIdMembre(rs.getInt("id_membre"));

                Date sqlDateEmp = rs.getDate("date_emprunt");
                Date sqlDateRet = rs.getDate("date_retour");

                e.setDateEmprunt(sqlDateEmp != null ? sqlDateEmp.toLocalDate() : null);
                e.setDateRetour(sqlDateRet != null ? sqlDateRet.toLocalDate() : null);

                historique.add(e);
            }
        }

        return historique;
    }
}
