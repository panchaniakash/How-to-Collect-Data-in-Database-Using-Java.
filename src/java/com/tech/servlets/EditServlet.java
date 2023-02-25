/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.tech.servlets;

import com.tech.dao.UserDao;
import com.tech.entities.Message;
import com.tech.entities.User;
import com.tech.helper.ConnectionProvider;
import com.tech.helper.Helper;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

/**
 *
 * @author HP
 */
@MultipartConfig
public class EditServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

//            fatch all data
            String userName = request.getParameter("user_name");
            String userEmail = request.getParameter("user_email");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");

            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

//            get the user from the sesstion
            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");

            user.setName(userName);
            user.setEmail(userEmail);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            String oldFile = user.getProfile();
            user.setProfile(imageName);

//            Update Database
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());

            boolean ans = userDao.updateUser(user);

            if (ans) {
                out.println("Updated to DataBase😉");

                String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();

//               profile pic change kar ne k bad old pic ko Delete karne ka code 
                String patholdFile = request.getRealPath("/") + "pics" + File.separator + oldFile;

//                new user sign up ke bad default png delete na ho use ke liye
                if (!oldFile.equals("default.png")) {
                    Helper.deleteFile(patholdFile);
                }

                if (Helper.saveFile(part.getInputStream(), path)) {
                    out.println("Profile Updated...after ");

                    Message msg = new Message("Profile details updated... ", "success", "alert-success");
                    s.setAttribute("msg", msg);

                } else {
                    Message msg = new Message("Something went wrong !! ", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                }

            } else {
                out.println("Not Updated...😒");
                Message msg = new Message("Something went wrong !!", "error", "alert-danger");
                s.setAttribute("msg", msg);
            }

            response.sendRedirect("profile.jsp");

            out.println("</body>");
            out.println("</html>");
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
