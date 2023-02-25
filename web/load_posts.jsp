<%@page import="com.tech.entities.User"%>
<%@page import="com.tech.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.entities.Post"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page errorPage="error_page.jsp" %>


<div class="row">
    <%
        User uuu = (User) session.getAttribute("currentUser");

        Thread.sleep(200);
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if (cid == 0) {
            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }

        if (posts.size() == 0) {
            out.println("<h3 class='display-3 text-center'>No Posts in this category..</h3>");
            out.print("<a href='show_blog_page.jsp'> showBlogPage</a>");

            return;
        }

        for (Post p : posts) {

    %>

    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">

            <div class="card-body">
                <b> <%= p.getpTitle()%> </b>
                <p> <%= p.getpContent()%> </p>
                <!--<pre> <%= p.getpCode()%> </pre>-->

            </div>
            <div class="card-footer login-background text-center">

                <% LikeDao ld = new LikeDao(ConnectionProvider.getConnection());%>

                <!--like button me like update karne ke liye-->

                <a href="#!" onclick="doLike(<%= p.getPid()%>,<%= uuu.getId()%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"> <span class="like-counter"> <%= ld.countLikeOnPost(p.getPid())%> </span> </i> </a>
                <a href="#!" class="btn btn-outline-light btn-sm"> <i class="fa fa-commenting-o"> <span>5</span> </i> </a>
                <a href="show_blog_page.jsp?post_id=<%= p.getPid()%>" class="btn btn-outline-light btn-sm">Read more</a>
            </div>
        </div>

    </div>


    <%
        }
    %>
</div>