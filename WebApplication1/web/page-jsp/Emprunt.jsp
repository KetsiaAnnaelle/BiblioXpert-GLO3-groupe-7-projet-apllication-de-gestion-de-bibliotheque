<%@page import="com.DAO.MembreDAO"%>
<%@page import="com.DAO.LivreDAO"%>
<%@page import="com.DAO.EmpruntDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Emprunt" %>
<%@ page import="com.model.Livre" %>
<%@ page import="com.model.Membre" %>

<%
    List<Emprunt> emprunts = new EmpruntDAO().listerEmprunts();
    List<Livre> livres = new LivreDAO().listerLivres();
    List<Membre> membres = new MembreDAO().listerMembres();
    request.setAttribute("emprunts", emprunts);
    java.time.LocalDate aujourdHui = java.time.LocalDate.now();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Emprunts</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<div class="sidebar">
    <h4 class="text-center mb-4"><a href="Accueil.jsp" style="color: white;">📚 BiblioXpert</a></h4>
    <!--<a href="">🏠 Tableau de bord</a>-->
    <a href="GestionLivre.jsp">📖 Gestion des livres</a>
    <a href="Membre.jsp">👥 Gestion des Membres</a>
    <a href="Emprunt.jsp" class="active">📦 Gestion des emprunts</a>
    <a href="RetourEmprunt.jsp">🔁 Gestion des retours</a>
<!--    <a href="#">📊 Statistiques</a>
    <a href="#">⚙️ Paramètres</a>-->
</div>

<div class="main-content">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Liste des Emprunts</h2>
    </div>

    <div class="d-flex justify-content-around mb-4">
        <div class="form-group">
            <input type="text" class="form-control" id="searchInput" placeholder="Rechercher un emprunt...">
        </div>
        <button class="btn btn-primary mb-3" data-toggle="modal" data-target="#empruntModal">Nouvel Emprunt</button>
    </div>

<%! 
public Membre trouverMembreParId(List<Membre> membres, int id) {
    for (Membre m : membres) {
        if (m.getId() == id) return m;
    }
    return null;
}

public Livre trouverLivreParId(List<Livre> livres, int id) {
    for (Livre l : livres) {
        if (l.getId() == id) return l;
    }
    return null;
}
%>
<div class="d-flex justify-content-between mb-4">
    <div class="form-group w-50 mr-2">
        <label for="filtreLivre">📚 Filtrer par livre</label>
        <select class="form-control" id="filtreLivre">
            <option value="">-- Tous les livres --</option>
            <% for (Livre livre : livres) { %>
                <option value="<%= livre.getTitre().toUpperCase() %>"><%= livre.getTitre() %></option>
            <% } %>
        </select>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-bordered table-striped w-full" id="empruntTable">
        <thead>
            <tr>
                <th>#</th>
                <th>Membre</th>
                <th>Livre</th>
                <th>Date Emprunt</th>
                <th>Date Retour Prévue</th>
                <th>Date Retour</th>
                <th>Amende</th>
                <th>Retard</th>
                <th>Actions</th>
                
            </tr>
        </thead>
        <tbody>
        <%
            int i = 1;
            for (Emprunt emprunt : emprunts) {
                Membre membre = trouverMembreParId(membres, emprunt.getIdMembre());
                Livre livre = trouverLivreParId(livres, emprunt.getIdLivre());
        %>
            <tr>
                <td><%= i++ %></td>
                <td><%= membre != null ? membre.getNom() + " " + membre.getPrenom() : "Inconnu" %></td>
                <td><%= livre != null ? livre.getTitre() : "Inconnu" %></td>
                <td><%= emprunt.getDateEmprunt() %></td>
                <td><%= emprunt.getDateRetourPrevue() %></td>
                <td><%= emprunt.getDateRetour() != null ? emprunt.getDateRetour() : "Non rendu" %></td>
                <td><%= (emprunt.getAmende() > 0) ? emprunt.getAmende() + " FCFA" : "-" %></td>
                <td>
                    
                    <%
                        java.time.LocalDate datePrevue = emprunt.getDateRetourPrevue();
                        java.time.LocalDate dateRetour = emprunt.getDateRetour();
                    %>
                    
                    <% if (dateRetour != null) { %>
                        <% if (dateRetour.isAfter(datePrevue)) { %>
                            <span class="badge badge-danger text-warning">⏰ En retard</span>
                        <% } else { %>
                            <span class="badge badge-success text-warning">✔ À temps</span>
                        <% } %>
                    <% } else { %>
                        <% if (aujourdHui.isAfter(datePrevue)) { %>
                            <span class="badge badge-danger text-danger">⏰ En retard (non retourné)</span>
                        <% } else { %>
                            <span class="badge badge-success text-primary">✔ À temps</span>
                        <% } %>
                    <% } %>
                    
                    
                    
                </td>
                <td class="d-flex gap-3 w-100">
                    <% if (emprunt.getDateRetour() == null) { %>
                        <!--<a href="/page-jsp/RetourEmpruntServlet?id=<%= emprunt.getId() %>" class="btn btn-sm btn-success">📦 Retour</a>-->
                        <button class="btn btn-sm btn-success retour-btn" onclick="retourner(<%= emprunt.getId() %>)">📦 Retour</button>

                    <% } else { %>
                        <span class="btn btn-sm btn-danger">✔ Remis</span>
                    <% } %>
                    <!--<a href="#" class="btn btn-sm btn-warning">✏️</a>-->
                    <a href="#" onclick="supprimerEmprunt(<%= emprunt.getId() %>)"  class="btn btn-md fw-bold text-danger">🗑 Delete️</a>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- Modal pour ajout -->
<div class="modal fade" id="empruntModal" tabindex="-1" role="dialog" aria-labelledby="empruntModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <form action="/WebApplication1/page-jsp/Emprunt" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Nouvel Emprunt</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Fermer">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="idMembre">Membre</label>
                        <select class="form-control" name="idMembre" required>
                            <% for (Membre membre : membres) { %>
                                <option value="<%= membre.getId() %>"><%= membre.getNom() %> <%= membre.getPrenom() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="idLivre">Livre</label>
                        <select class="form-control" name="idLivre" required>
                            <% for (Livre livre : livres) { %>
                                <option value="<%= livre.getId() %>"><%= livre.getTitre() %></option>
                            <% } %>
                        </select>
                    </div>
<!--                    <div class="form-group">
                        <label for="dateEmprunt">Date Emprunt</label>
                        <input type="date" class="form-control" name="dateEmprunt" required>
                    </div>-->
                    <div class="form-group">
                        <label for="dateRetour">Date Retour Prevue</label>
                        <input type="date" class="form-control" name="dateRetourPrevue">
                    </div>
                    
<!--                    <div class="form-group">
                        <label for="dateRetourPrevue">Date retour prévue :</label>
                        <input type="date" class="form-control" name="dateRetourPrevue" id="dateRetourPrevue" required>
                    </div>-->

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                    <button type="submit" class="btn btn-primary">Enregistrer</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.getElementById("searchInput").addEventListener("keyup", function () {
    var filter = this.value.toUpperCase();
    var rows = document.querySelectorAll("#empruntTable tbody tr");
    rows.forEach(function(row) {
        var text = row.textContent.toUpperCase();
        row.style.display = text.indexOf(filter) > -1 ? "" : "none";
    });
});
</script>

<script>
    function retourner(id) {
        console.log(id); // Vérifie que l'id s'affiche bien

        fetch('<%= request.getContextPath() %>/RetourEmpruntServlet?id=' + id, {
        method: 'POST' 
      })
          .then(response => {
            if (!response.ok) {
              throw new Error("Erreur lors du retour.");
            }
            return response.text();
          })
          .then(data => {
            // Alerte de succès avec SweetAlert
            Swal.fire({
              icon: 'success',
              title: 'Succès !',
              text: 'Le livre a été retourné avec succès.',
              timer: 2000,
              showConfirmButton: false
            }).then(() => {
              location.reload(); // Recharge la page après l'alerte
            });
          })
          .catch(error => {
            // Alerte d'erreur avec SweetAlert
            Swal.fire({
              icon: 'error',
              title: 'Erreur',
              text: error.message
            });
        });
    }

//    document.querySelectorAll(".retour-btn").forEach(btn => {
//        btn.addEventListener("click", function () {
//            const id = this.getAttribute("data-id");
//            const button = this;
//
//            fetch(`<%= request.getContextPath() %>/RetourEmpruntServlet?id=${id}` , {
//                method: "GET"
//            })
//            .then(response => {
//                console.log(id);
//                if (!response.ok) throw new Error("Erreur lors du retour");
//                return response.text();
//            })
//            .then(() => {
//                // Changer le bouton en "✔ Remis"
//                button.outerHTML = '<span class="btn btn-sm btn-danger">✔ Remis</span>';
//
//                // Afficher l'alerte
//                Swal.fire({
//                    icon: 'success',
//                    title: 'Succès !',
//                    text: 'Le livre a été retourné avec succès.',
//                    timer: 2000,
//                    showConfirmButton: false
//                });
//            })
//            .catch(error => {
//                Swal.fire({
//                    icon: 'error',
//                    title: 'Erreur',
//                    text: error.message
//                });
//            });
//        });
//    });
    
    
    function supprimerEmprunt(id) {
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
      fetch( '<%= request.getContextPath() %>/DeleteEmprunt?id=' + id, {
        method: 'POST' 
      })
      .then(response => {
        if (response.ok) {
          swalWithBootstrapButtons.fire({
            title: "Supprimé !",
            text: "L'enprunt a été supprimé avec succès.",
            icon: "success",
            timer: 1500,
            showConfirmButton: false
          }).then(() => {
            window.location.reload();
          });
        } else {
          swalWithBootstrapButtons.fire({
            title: "Erreur",
            text: "Impossible de supprimer l'enprunt.",
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
        text: "L'enprunt n’a pas été supprimé.",
        icon: "error"
      });
    }
  });
}




</script>


<!--filtre les emprunts par livre-->

<script>
    document.getElementById("filtreLivre").addEventListener("change", function () {
        const selectedTitle = this.value.toUpperCase();
        const rows = document.querySelectorAll("#empruntTable tbody tr");

        rows.forEach(row => {
            const titreCell = row.cells[2]; // Colonne "Livre"
            if (!selectedTitle || titreCell.textContent.toUpperCase().includes(selectedTitle)) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    });
</script>



<script src="../js/sweetalert2.all.min.js"></script>

</body>
</html>
