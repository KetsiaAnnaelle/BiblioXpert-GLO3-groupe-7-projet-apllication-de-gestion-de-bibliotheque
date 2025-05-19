<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.time.*, models.Emprunt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Statistiques des Retours</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 20px;
        }

        .container {
            max-width: 900px;
            margin: auto;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        .stats-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .stat {
            margin-bottom: 10px;
            font-size: 18px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
        }

        th {
            background-color: #2c3e50;
            color: white;
        }

        .late {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Statistiques des Retours de Livres</h1>

    <div class="stats-box">
        <div class="stat">📚 Emprunts non rendus : <strong>${nonRendus}</strong></div>
        <div class="stat">⏰ Retours en retard : <strong>${retards}</strong></div>
        <div class="stat">💸 Total amendes : <strong>${totalAmendes} FCFA</strong></div>
        <div class="stat">📊 Moyenne jours de retard : <strong>${moyenneJoursRetard}</strong></div>
    </div>

    <h2>📖 Derniers Livres Retournés</h2>
    <table>
        <tr>
            <th>Nom</th>
            <th>Livre</th>
            <th>Date d'emprunt</th>
            <th>Date de retour</th>
            <th>Jours de retard</th>
            <th>Amende</th>
        </tr>
        <c:forEach var="emprunt" items="${derniersRetours}">
            <tr>
                <td>${emprunt.nomLecteur}</td>
                <td>${emprunt.titreLivre}</td>
                <td>${emprunt.dateEmprunt}</td>
                <td>${emprunt.dateRetour}</td>
                <td>
                    <c:choose>
                        <c:when test="${emprunt.joursRetard > 0}">
                            <span class="late">${emprunt.joursRetard}</span>
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${emprunt.amende > 0}">
                            <span class="late">${emprunt.amende} FCFA</span>
                        </c:when>
                        <c:otherwise>0 FCFA</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
