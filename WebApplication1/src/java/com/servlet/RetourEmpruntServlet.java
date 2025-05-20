/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.DAO.EmpruntDAO;
import com.model.Emprunt;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author DELL
 */
@WebServlet(name = "RetourEmpruntServlet", urlPatterns = {"/RetourEmpruntServlet"})
public class RetourEmpruntServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
       
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmpruntDAO empruntDAO = new EmpruntDAO();

        try {
            List<Emprunt> empruntsRetournes = empruntDAO.listerEmpruntsRetournes();
            request.setAttribute("empruntsRetournes", empruntsRetournes);
            request.getRequestDispatcher("/page-jsp/RetourEmprunt.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la récupération des emprunts retournés.");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        try {
        String idParam = request.getParameter("id");
        EmpruntDAO dao = new EmpruntDAO();

        if (idParam != null) {
            int idEmprunt = Integer.parseInt(idParam);
            LocalDate dateRetour = LocalDate.now();

            // Mise à jour
            dao.retournerLivre(idEmprunt, dateRetour);

            // Réponse directe au fetch (important !)
            response.setContentType("text/plain");
            response.getWriter().write("OK");
            return; // NE PAS faire de forward après un fetch
        }

        // Sinon, fonctionnement classique (ex : si appel depuis un navigateur)
        List<Emprunt> emprunts = dao.empruntsNonRendus();
        request.setAttribute("emprunts", emprunts);
        request.getRequestDispatcher("page-jsp/RetourEmprunt.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        response.setContentType("text/plain");
        response.getWriter().write("Erreur : " + e.getMessage());
    }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
