package com.essai;

import com.connexion.Connexion;
import com.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserEssai {

    public boolean connexion(User user) {
      boolean statut = false;
      String sql = "SELECT * FROM app_bibliotheque WHERE email = ? AND password = ?";

      try {
          Connection connection = Connexion.getConnection();
          PreparedStatement preparedStatement = connection.prepareStatement(sql);
          preparedStatement.setString(1, user.getEmail());
          preparedStatement.setString(2, user.getMdp());

          System.out.println("Requête : " + preparedStatement);
          ResultSet rs = preparedStatement.executeQuery();

          if (rs.next()) {
              statut = true;
          }

          // fermeture manuelle car pas de try-with-resources
          rs.close();
          preparedStatement.close();
          connection.close();

      } catch (ClassNotFoundException e) {
          System.out.println("Pilote JDBC non trouvé : " + e.getMessage());
      } catch (SQLException e) {
          System.out.println("Erreur SQL : " + e.getMessage());
      }

      return statut;
    }

}



