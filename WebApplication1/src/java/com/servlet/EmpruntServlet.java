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
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
@WebServlet(name = "EmpruntServlet", urlPatterns = {"/page-jsp/Emprunt"})
public class EmpruntServlet extends HttpServlet {

    private EmpruntDAO empruntDAO = new EmpruntDAO();

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
       try {
            List<Emprunt> emprunts = empruntDAO.listerEmprunts();
            request.setAttribute("emprunts", emprunts);
            request.getRequestDispatcher("Emprunt.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
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
        int idMembre = Integer.parseInt(request.getParameter("idMembre"));
        int idLivre = Integer.parseInt(request.getParameter("idLivre"));
//        LocalDate dateEmprunt = LocalDate.parse(request.getParameter("dateEmprunt"));
//        LocalDate dateRetour = LocalDate.parse(request.getParameter("dateRetour"));
        LocalDate dateRetourPrevue = LocalDate.parse(request.getParameter("dateRetourPrevue"));
//        int amende = Integer.parseInt(request.getParameter("amende"));


//        Emprunt emprunt = new Emprunt(0, idMembre, idLivre, dateEmprunt, dateRetour, dateRetourPrevue, amende);

        Emprunt emprunt = new Emprunt();
        emprunt.setIdMembre(idMembre);
        emprunt.setIdLivre(idLivre);
        emprunt.setDateRetourPrevue(dateRetourPrevue);

        try {
            empruntDAO.enregistrerEmprunt(emprunt);
        } catch (SQLException ex) {
            Logger.getLogger(EmpruntServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
//        try {
//            empruntDAO.enregistrerEmprunt(emprunt);
//        } 
        catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("message", "Emprunt enregistré avec succès !");
        response.sendRedirect("Emprunt.jsp");
        
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
