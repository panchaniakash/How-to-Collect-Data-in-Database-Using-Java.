/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.tech.servlets;

import com.tech.dao.UserDao;
import com.tech.entities.Message;
import com.tech.entities.User;
import com.tech.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

//            Log in 
//            fatch user-name and password from request
            String userEmail = request.getParameter("email");
            String userPassword = request.getParameter("password");
            
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            
            User u = dao.getUserByEmailAndPassword(userEmail, userPassword);
            
            if (u == null) {
//                login.....
//                error..///
//                out.println("Invalid Details..try again ");

                Message msg = new Message("Invalid Details ! Try another", "error", "alert-danger");
                HttpSession s = request.getSession();
                s.setAttribute("msg", msg);
                
                response.sendRedirect("login_page.jsp");
                
            } else {
//                Log in access..

                HttpSession s = request.getSession();
                s.setAttribute("currentUser", u);
                response.sendRedirect("profile.jsp");
                
            }
            
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
        processRequest(request, response);
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
