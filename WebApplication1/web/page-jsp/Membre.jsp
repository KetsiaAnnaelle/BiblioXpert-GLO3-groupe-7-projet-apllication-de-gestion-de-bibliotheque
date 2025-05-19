<%@page import="com.DAO.MembreDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Membre" %>


<%
    List<Membre> membres = new MembreDAO().listerMembres();
    // Tu peux ajouter d'autres appels DAO ici si nécessaire
%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Membres</title>
    <!-- Bootstrap CSS -->
      <link rel="stylesheet" href="../css/bootstrap.min.css" />
      <link rel="stylesheet" href="../css/style.css">


    <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">-->
</head>

<body>
    
    <!-- Sidebar -->
<div class="sidebar">
    <h4 class="text-center mb-4"> <a href="Accueil.jsp" style="color: white;">📚 BiblioXpert </a></h4>
    <a href="/Accueil.jsp">🏠 Tableau de bord</a>
    <a href="GestionLivre.jsp" >📖 Gestion des livres</a>    
    <a href="Membre.jsp" class="active" >📖 Gestion des Membres</a>
    <a href="Emprunt.jsp">📦 Gestion des emprunts</a>
    <a href="#">🔁 Gestion des retours</a>
    <a href="#">👥 Gestion des membres</a>
<!--    <a href="#">📊 Statistiques</a>
    <a href="#">⚙️ Paramètres</a>-->
  </div>
    

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>Liste des Membres</h2>
    </div>

    <div class="d-flex justify-content-around">
      <div class="form-group">
        <input type="text" class="form-control" id="searchInput" placeholder="Rechercher un membre...">
      </div>

        <!-- Bouton d'ajout -->
      <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#membreModal">
          Ajouter un membre
      </button>
    </div>

    <!-- Tableau des livres -->
    <div class="table-responsive">
      <table class="table table-bordered table-striped">
        <thead>
          <tr>
            <th>#</th>
            <th>Nom</th>
            <th>Prenom</th>
            <th>Telephone</th>
            <!-- <th>Actions</th> -->
          </tr>
        </thead>
        <tbody id="membreTable">
          <%
            int i = 1;
            for (Membre membre : membres) {
          %>
            <tr>
              <td><%= i++ %></td>
              <td><%= membre.getNom() %></td>
              <td><%= membre.getPrenom() %></td>
              <td><%= membre.getTelephone() %></td>

            </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>


<!-- Modal Bootstrap pour ajout de membre -->
<div class="modal fade" id="membreModal" tabindex="-1" role="dialog" aria-labelledby="membreModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <form action="/WebApplication1/page-jsp/Membre" method="post">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="membreModalLabel">Ajouter un Membre</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Fermer">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="form-group">
              <label for="nom">Nom</label>
              <input type="text" class="form-control" name="nom" id="nom" required>
          </div>
          <div class="form-group">
              <label for="prenom">Prénom</label>
              <input type="text" class="form-control" name="prenom" id="prenom" required>
          </div>
          <div class="form-group">
              <label for="telephone">Téléphone</label>
              <input type="text" class="form-control" name="telephone" id="telephone">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
          <button type="submit" class="btn btn-primary">Enregistrer</button>
        </div>
      </div>
    </form>
  </div>
</div>

<!-- Bootstrap JS + jQuery -->

<!-- Script pour filtrer le tableau -->
<script>
    document.getElementById("searchInput").addEventListener("keyup", function () {
        const filter = this.value.toUpperCase();
        const rows = document.querySelectorAll("#membreTable tr");

        rows.forEach(row => {
            const text = row.textContent.toUpperCase();
            row.style.display = text.includes(filter) ? "" : "none";
        });
    });
</script>




 <script src="../js/bootstrap.bundle.js"></script>
  
</body>
</html>