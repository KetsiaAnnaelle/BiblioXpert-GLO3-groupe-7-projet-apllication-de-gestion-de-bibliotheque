/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet;

import com.DAO.UserDAO;
import com.model.User;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
//import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/page-jsp/login"})
public class LoginServlet extends HttpServlet {
    
    private UserDAO utiisateurDAO = new UserDAO();

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
//       
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
//        processRequest(request, response);
//        response.getWriter().append("served at:").append(request.getContentPath());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/page-jsp/login.html");
        dispatcher.forward(request, response);
//        System.out.print("je suis");
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/page-jsp/Accueil.html");
                response.sendRedirect("/WebApplication1/page-jsp/Accueil.html");

//        dispatcher.forward(request, response);
//        String email = request.getParameter("email");
//        String mdp = request.getParameter("mdp");
//
//        User utilisateur = new User();
//        utilisateur.setEmail(email);
//        utilisateur.setMdp(mdp);
        
//        try{
//
//            if(utiisateurDAO.Connexion(utilisateur)){
//                HttpSession session = request.getSession();
//                session.setAttribute("user",utilisateur);
//                response.sendRedirect("/WebApplication1/page-jsp/Accueil.html");
//            }else{
//                request.setAttribute("message", "Email ou mot de passe incorrect");
//                response.sendRedirect("/WebApplication1/page-jsp/login.html");
//            }
//            
//        }catch (ClassNotFoundException e){
//            e.printStackTrace();
//        } catch (SQLException ex) {
//            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
//        } 
//        catch (SQLException ex) {
//            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
//        }
        }
        
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
