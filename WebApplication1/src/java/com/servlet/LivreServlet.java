/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.DAO.LivreDAO;
import com.model.Livre;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
@WebServlet(name = "LivreServlet", urlPatterns = {"/page-jsp/GestionLivre"})
public class LivreServlet extends HttpServlet {

    private LivreDAO BookDAO = new LivreDAO();
     
//     public LivreServlet(){
////         super();
//         BookDAO = new LivreDAO();
//     }
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

    String idParam = request.getParameter("id");

    if (idParam != null) {
        // Suppression d’un livre
        int id = Integer.parseInt(idParam);
        try {
            BookDAO.supprimerLivre(id);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        // Redirection vers la liste après suppression
    } 
            response.sendRedirect("/WebApplication1/page-jsp/GestionLivre.jsp");

//    else {
//        // Sinon, afficher le formulaire ou la page HTML
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/page-jsp/GestionLivre.html");
//        dispatcher.forward(request, response);
//    }
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
//        processRequest(request, response);
        String titre = request.getParameter("titre");
        String auteur = request.getParameter("auteur");
        String isbn = request.getParameter("isbn");
        int annee = Integer.parseInt(request.getParameter("annee"));
        boolean disponible = true;
        
        Livre book = new Livre(titre,auteur,isbn,annee,disponible);
        
        
         
        try{
            try {
                BookDAO.ajouterLivre(book);
            } catch (SQLException ex) {
                Logger.getLogger(LivreServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            // récupère la liste mise à jour
        List<Livre> livres = BookDAO.listerLivres();

        // envoie la liste à la JSP
        request.setAttribute("listeLivres", livres);

        // transfert vers la page JSP qui va afficher les livres
        request.getRequestDispatcher("/page-jsp/GestionLivre.jsp").forward(request, response);
         
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        } catch (SQLException ex) {
            Logger.getLogger(LivreServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

//        RequestDispatcher dispatcher = request.getRequestDispatcher("/page-jsp/Accueil.html");
//        dispatcher.forward(request, response);
    }


    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>

//}
