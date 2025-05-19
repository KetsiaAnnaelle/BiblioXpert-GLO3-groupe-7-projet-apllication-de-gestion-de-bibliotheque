

//function supprimerLivre(id) {
//    if (confirm("Confirmer la suppression ?")) {
//      fetch('<%= request.getContextPath() %>/supprimerLivre?id=' + id, {
//        method: 'DELETE'
//      }).then(response => {
//        if (response.ok) {
//          window.location.reload();
//        } else {
//          alert("Erreur lors de la suppression.");
//        }
//      });
//    }
//}




function remplirFormulaireModification(id, titre, auteur, isbn, annee) {
  document.getElementById("update-id").value = id;
  document.getElementById("update-titre").value = titre;
  document.getElementById("update-auteur").value = auteur;
  document.getElementById("update-isbn").value = isbn;
  document.getElementById("update-annee").value = annee;
}
