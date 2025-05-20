<%@page import="com.DAO.MembreDAO"%>
<%@page import="com.model.Livre"%>
<%@page import="com.model.Membre"%>
<%@page import="com.DAO.LivreDAO"%>
<%@page import="com.DAO.EmpruntDAO"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Emprunt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Emprunt> emprunts = new EmpruntDAO().listerEmpruntsRetournes();
    request.getAttribute("empruntsRetournes");
    List<Livre> livres = new LivreDAO().listerLivres();
    List<Membre> membres = new MembreDAO().listerMembres();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Retours d'emprunts</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f6f9 !important; 
            display: flex;
        }

        /* Sidebar */
        .sidebar {
            width: 220px;
            height: 100vh;
            background-color: #343a40;
            padding: 20px 0;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            position: fixed;
        }

        .sidebar h4 {
            color: white;
            margin-bottom: 30px;
        }

        .sidebar a {
            display: block;
            color: #ddd;
            padding: 12px 25px;
            text-decoration: none;
            transition: 0.3s;
            font-size: 15px;
        }

        .sidebar a:hover,
        .sidebar a.active {
            background-color: #007bff;
            color: white;
        }

        /* Contenu principal */
        .main {
            margin-left: 220px;
            padding: 30px;
            flex: 1;
        }

        h1 {
            margin-bottom: 25px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f6fa;
        }

        tr:hover {
            background-color: #e2ecf6;
        }

        .amende {
            font-weight: bold;
            color: #cc0000;
        }
    </style>
       <link rel="stylesheet" href="../css/bootstrap.min.css" />
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h4 class="text-center"><a href="Accueil.jsp" style="color: white;">📚 BiblioXpert</a></h4>
        <a href="GestionLivre.jsp">📖 Gestion des livres</a>
        <a href="Membre.jsp">👥 Gestion des Membres</a>
        <a href="Emprunt.jsp">📦 Gestion des emprunts</a>
        <a href="RetourEmprunt.jsp" class="active">🔁 Gestion des retours</a>
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

    <!-- Contenu principal -->
    <div class="main">
        <h1 class="text-primary">📄 Liste des emprunts retournés</h1>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Livre</th>
                    <th>Membre</th>
                    <th>Date Emprunt</th>
                    <th>Date Retour Prévue</th>
                    <th>Date Retour</th>
                    <th>Amende</th>
                </tr>
            </thead>
            <tbody>
            <% 
                if (emprunts != null && !emprunts.isEmpty()) {
                for (Emprunt emp : emprunts) { 
                Membre membre = trouverMembreParId(membres, emp.getIdMembre());
                Livre livre = trouverLivreParId(livres, emp.getIdLivre());
            %>
                    <tr>
                        <td><%= emp.getId() %></td>
                        <td><%= livre != null ? livre.getTitre()  : "Inconnu" %></td>
                        <td><%= membre != null ? membre.getNom() + " " + membre.getPrenom() : "Inconnu" %></td>
                        <td><%= emp.getDateEmprunt() %></td>
                        <td><%= emp.getDateRetourPrevue() %></td>
                        <td><%= emp.getDateRetour() %></td>
                        <td class="amende"><%= emp.getAmende() %> FCFA</td>
                    </tr>
            <%  }
            } else { %>
                <tr>
                    <td colspan="7" style="text-align:center; padding: 20px;">Aucun emprunt retourné trouvé.</td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

</body>
</html>
