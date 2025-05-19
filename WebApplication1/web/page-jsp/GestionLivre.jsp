<%@ page import="java.util.List" %>
<%@ page import="com.model.Livre" %>
<%@ page import="com.DAO.LivreDAO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Livre> livres = new LivreDAO().listerLivres();
    // Tu peux ajouter d'autres appels DAO ici si nécessaire
%>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Gestion des Livres</title>
  <link rel="stylesheet" href="../css/bootstrap.min.css">
   <link rel="stylesheet" href="../css/style.css">
  
</head>
<body>

  <!-- Sidebar -->
  <div class="sidebar">
    <h4 class="text-center mb-4"> <a href="Accueil.jsp" style="color: white;">📚 BiblioXpert </a></h4>
    <a href="">🏠 Tableau de bord</a>
    <a href="GestionLivre.jsp" class="active">📖 Gestion des livres</a>
        <a href="Membre.jsp">👥 Gestion des Membres</a>
    <a href="Emprunt.jsp">📦 Gestion des emprunts</a>
    <a href="#">🔁 Gestion des retours</a>
    <!--<a href="#">👥 Gestion des membres</a>-->
    <a href="#">📊 Statistiques</a>
    <a href="#">⚙️ Paramètres</a> 
  </div>

  <!-- Contenu principal -->
  <div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2>Gestion des Livres</h2>
     
    </div>
      
    <div class="d-flex justify-content-around mb-4">
      <div class="form-group">
        <input type="text" class="form-control" id="searchInput" placeholder="Rechercher un membre...">
      </div>

        <!-- Bouton d'ajout -->
       <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalLivre">
        ➕ Ajouter un livre
      </button>
    </div>

    <!-- Tableau des livres -->
    <div class="table-responsive">
      <table class="table table-bordered table-striped table-hover shadow-sm w-full">
        <thead>
          <tr>
            <th>#</th>
            <th>Titre</th>
            <th>Auteur</th>
            <th>ISBN</th>
            <th>Année</th>
            <th>Date ajout</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody id="LivreTable">
          <%
            int i = 1;
            for (Livre livre : livres) {
          %>
            <tr>
              <td><%= i++ %></td>
              <td><%= livre.getTitre() %></td>
              <td><%= livre.getAuteur() %></td>
              <td><%= livre.getIsbn() %></td>
              <td><%= livre.getAnnee() %></td>
              <td><%= new java.util.Date() %></td> <!-- Remplace par livre.getDateAjout() si disponible -->
              <td>
                <a href="#"  data-bs-toggle="modal" data-bs-target="#modalUpdate" onclick="remplirFormulaireModification(<%= livre.getId() %>, '<%= livre.getTitre().replace("'", "\\'") %>', '<%= livre.getAuteur().replace("'", "\\'") %>', '<%= livre.getIsbn() %>', <%= livre.getAnnee() %>)" class="btn btn-sm btn-warning">✏️</a>
                <a href="#" onclick="supprimerLivre(<%= livre.getId() %>)"  class="btn btn-sm btn-danger">🗑️</a>
              </td>
            </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Modal Ajout Livre -->
  <div class="modal fade" id="modalLivre" tabindex="-1" aria-labelledby="modalLivreLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
      <div class="modal-content">
        <form method="post" action="/WebApplication1/page-jsp/GestionLivre">
          <div class="modal-header">
            <h5 class="modal-title" id="modalLivreLabel">Ajouter un Livre</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
          </div>
          <div class="modal-body">
            <div class="row g-3">
              <div class="col-md-6">
                <label for="titre" class="form-label">Titre</label>
                <input type="text" class="form-control" name="titre" id="Titre" required>
              </div>
              <div class="col-md-6">
                <label for="auteur" class="form-label">Auteur</label>
                <input type="text" class="form-control" name="auteur" id="auteur" required>
              </div>
              <div class="col-md-6">
                <label for="isbn" class="form-label">ISBN</label>
                <input type="text" class="form-control" name="isbn" id="isbn" required>
              </div>
              <div class="col-md-6">
                <label for="annee" class="form-label">Année</label>
                <input type="number" class="form-control" name="annee" id="annee" required>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-success">💾 Enregistrer</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  
  
  <!-- Modal de modification -->
<div class="modal fade" id="modalUpdate" tabindex="-1" aria-labelledby="modalUpdateLabel" aria-hidden="true">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <form method="post" action="<%= request.getContextPath() %>/modifierLivre">
        <div class="modal-header">
          <h5 class="modal-title" id="modalUpdateLabel">Modifier un Livre</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
        </div>
        <div class="modal-body">
          <input type="hidden" name="id" id="update-id">
          <div class="row g-3">
            <div class="col-md-6">
              <label for="update-titre" class="form-label">Titre</label>
              <input type="text" class="form-control" name="titre" id="update-titre" required>
            </div>
            <div class="col-md-6">
              <label for="update-auteur" class="form-label">Auteur</label>
              <input type="text" class="form-control" name="auteur" id="update-auteur" required>
            </div>
            <div class="col-md-6">
              <label for="update-isbn" class="form-label">ISBN</label>
              <input type="text" class="form-control" name="isbn" id="update-isbn" required>
            </div>
            <div class="col-md-6">
              <label for="update-annee" class="form-label">Année</label>
              <input type="number" class="form-control" name="annee" id="update-annee" required>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-success">💾 Modifier</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
        </div>
      </form>
    </div>
  </div>
</div>

  
  

  
  <script>
//   function supprimerLivre(id) {
//      if (confirm("Confirmer la suppression ?")) {
//        fetch('<%= request.getContextPath() %>/supprimerLivre?id=' + id, {
//          method: 'DELETE'
//        }).then(response => {
//          if (response.ok) {
//            window.location.reload();
//          } else {
//            alert("Erreur lors de la suppression.");
//          }
//        });
//      }
//      
//    }


function supprimerLivre(id) {
  const swalWithBootstrapButtons = Swal.mixin({
    customClass: {
      confirmButton: "btn btn-success",
      cancelButton: "btn btn-danger"
    },
    buttonsStyling: false
  });

  swalWithBootstrapButtons.fire({
    title: "Êtes-vous sûr ?",
    text: "Cette action est irréversible !",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Oui, supprimer !",
    cancelButtonText: "Non, annuler !",
    reverseButtons: true
  }).then((result) => {
    if (result.isConfirmed) {
      fetch( '<%= request.getContextPath() %>/supprimerLivre?id=' + id, {
        method: 'POST' // ✅ Utiliser GET car ton servlet écoute doGet
      })
      .then(response => {
        if (response.ok) {
          swalWithBootstrapButtons.fire({
            title: "Supprimé !",
            text: "Le livre a été supprimé avec succès.",
            icon: "success",
            timer: 1500,
            showConfirmButton: false
          }).then(() => {
            window.location.reload();
          });
        } else {
          swalWithBootstrapButtons.fire({
            title: "Erreur",
            text: "Impossible de supprimer le livre.",
            icon: "error"
          });
        }
      })
      .catch(error => {
        swalWithBootstrapButtons.fire({
          title: "Erreur",
          text: error.message,
          icon: "error"
        });
      });
    } else if (result.dismiss === Swal.DismissReason.cancel) {
      swalWithBootstrapButtons.fire({
        title: "Annulé",
        text: "Le livre n’a pas été supprimé.",
        icon: "error"
      });
    }
  });
}

    
    
    
    function remplirFormulaireModification(id, titre, auteur, isbn, annee) {
      document.getElementById("update-id").value = id;
      document.getElementById("update-titre").value = titre;
      document.getElementById("update-auteur").value = auteur;
      document.getElementById("update-isbn").value = isbn;
      document.getElementById("update-annee").value = annee;
    }
    
    document.getElementById("searchInput").addEventListener("keyup", function () {
        const filter = this.value.toUpperCase();
        const rows = document.querySelectorAll("#LivreTable tr");

        rows.forEach(row => {
            const text = row.textContent.toUpperCase();
            row.style.display = text.includes(filter) ? "" : "none";
        });
    });

  </script>
  
  <script src="../js/sweetalert2.all.min.js"></script>
  
  <!-- Bootstrap JS -->
  <script src="../js/bootstrap.bundle.js"></script>
  <!--<script src="../js/Livre.js"></script>-->

</body>
</html>
