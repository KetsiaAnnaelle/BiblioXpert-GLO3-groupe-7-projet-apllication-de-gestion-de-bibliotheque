///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package com.servlet;
//
//import com.DAO.EmpruntDAO;
//import com.DAO.LivreDAO;
//import com.model.Emprunt;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.sql.SQLException;
//import java.time.LocalDate;
//import java.util.logging.Level;
//import java.util.logging.Logger;
////import java.util.Date;
//
///**
// *
// * @author DELL
// */
//@WebServlet(name = "RetourEmpruntServlet", urlPatterns = {"/RetourEmpruntServlet"})
//public class RetourEmpruntServlet extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//                    }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//   protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int idEmprunt = Integer.parseInt(request.getParameter("id"));
//
//        EmpruntDAO empruntDAO = new EmpruntDAO();
//        Emprunt emprunt = null;
//        try {
//            emprunt = empruntDAO.trouverParId(idEmprunt);
//        } catch (SQLException ex) {
//            Logger.getLogger(RetourEmpruntServlet.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        if (emprunt != null) {
//            // Mettre à jour la date de retour réelle
//            emprunt.setDateRetour(LocalDate.now());
//            try {
//                empruntDAO.mettreAJour(emprunt);
//            } catch (SQLException ex) {
//                Logger.getLogger(RetourEmpruntServlet.class.getName()).log(Level.SEVERE, null, ex);
//            }
//
//            // Rendre le livre disponible
//            LivreDAO livreDAO = new LivreDAO();
//            try {
//                livreDAO.mettreAJourDisponibiliteLivre(emprunt.getIdLivre(), true);
//            } catch (SQLException ex) {
//                Logger.getLogger(RetourEmpruntServlet.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
//
//      request.setAttribute("message", "Livre retourné avec succès !");
//      response.sendRedirect("page-jsp/Emprunt.jsp");
////      request.getRequestDispatcher("/page-jsp/Emprunt.jsp").forward(request, response);
//
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}



package com.servlet;

import com.DAO.EmpruntDAO;
import com.model.Emprunt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

//@WebServlet("/RetourEmpruntServlet")
@WebServlet(name = "RetourEmpruntServlet", urlPatterns = {"/RetourEmpruntServlet"})
public class RetourEmpruntServlet extends HttpServlet {

//    @Override
   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 1. Récupération de l'ID à partir du paramètre GET
            String idParam = request.getParameter("id");

            EmpruntDAO dao = new EmpruntDAO(); // Déclaré une seule fois

            if (idParam != null) {
                int idEmprunt = Integer.parseInt(idParam);
                LocalDate dateRetour = LocalDate.now();

                // 2. Met à jour la date de retour dans la base de données
                dao.retournerLivre(idEmprunt, dateRetour);
            }

            // 3. Récupération des emprunts non rendus
            List<Emprunt> emprunts = dao.empruntsNonRendus();
            request.setAttribute("emprunts", emprunts);

            // 4. Affichage de la page JSP
            request.getRequestDispatcher("page-jsp/RetourEmprunt.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur : " + e.getMessage());
        }
    }
//protected void doGet(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//    try {
//        // 1. Récupération de l'ID à partir du paramètre GET
//        String idParam = request.getParameter("id");
//
//        if (idParam != null) {
//            int idEmprunt = Integer.parseInt(idParam);
//            LocalDate dateRetour = LocalDate.now();
//
//            EmpruntDAO dao = new EmpruntDAO();
//            dao.retournerLivre(idEmprunt, dateRetour);
//        }
//
//        // 2. Rechargement de la liste des emprunts non rendus
//        EmpruntDAO dao = new EmpruntDAO();
//        List<Emprunt> emprunts = dao.empruntsNonRendus();
//        request.setAttribute("emprunts", emprunts);
//
//        // 3. Affichage de la page JSP
//        request.getRequestDispatcher("/RetourEmprunt.jsp").forward(request, response);
//
//    } catch (Exception e) {
//        e.printStackTrace();
//        response.getWriter().println("Erreur: " + e.getMessage());
//    }
//}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idEmprunt = Integer.parseInt(request.getParameter("id"));
        LocalDate dateRetour = LocalDate.now();

//        try {
//            EmpruntDAO dao = new EmpruntDAO();
//            dao.retournerLivre(idEmprunt, dateRetour);
//            response.sendRedirect("/RetourEmprunt.jsp");
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//            response.getWriter().println("Erreur lors du retour du livre: " + e.getMessage());
//        }
    }
}
