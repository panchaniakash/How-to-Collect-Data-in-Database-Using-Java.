<%@page import="com.tech.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.entities.Category"%>
<%@page import="com.tech.entities.Post"%>
<%@page import="com.tech.dao.PostDao"%>
<%@page import="com.tech.helper.ConnectionProvider"%>
<%@page import="com.tech.entities.User"%>
<%@page errorPage="error_page.jsp" %>

<%
    
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>

<%    
    int postId = Integer.parseInt(request.getParameter("post_id"));
    
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostByPostId(postId);
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%> || Tech blog by Akash Patel</title>

        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mycss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 82%, 65% 94%, 30% 93%, 0 100%, 0 0);
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 20px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-size: 20px;
            }
            .row-user{
                border: 1px solid #cc0033;
                padding: 15px;
            }

            body{
                background:url(img/sunset.jpg);
                background-size: cover;
                background-attachment: fixed;

            }
        </style>

    </head>
    <body>



        <!--navbar-->

        <nav class="navbar navbar-expand-lg navbar-dark primary-background ">
            <a class="navbar-brand" href="index.jsp"> <span class="fa fa-gears"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="profile.jsp"> <span class="fa fa-bell-o"></span> Akash Patel <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="	fa fa-check-square-o"></span>  Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Action</a>
                            <a class="dropdown-item" href="#">Another action</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#"> <span class="fa fa-address-card-o	"></span> Contact</a>
                    </li>


                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"> <span class="	fa fa-bars"></span> Do Post</a>
                    </li>

                </ul>

                <!--for search box icon-->

                <!--                <form class="form-inline my-2 my-lg-0">
                                    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                                    <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
                                </form>-->
                <ul class="navbar-nav mr-right">

                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"> <span class="fa fa-user-circle-o"></span>  <%= user.getName()%></a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"> <span class="fa fa-user-times"></span> Log out</a>
                    </li>

                </ul>

            </div>
        </nav>

        <!--end of navbar-->

        <!--main content of the body-->

        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">

                    <div class="card">

                        <div class="card-header primary-background text-white">
                            <h4 class="post-title"> <%=  p.getpTitle()%> </h4>

                        </div>

                        <div class="card-body">

                            <img class="card-img-top my-2" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">

                            <div class="row my-3 row-user">
                                <div class="col-md-8">

                                    <%
                                        UserDao ud = new UserDao(ConnectionProvider.getConnection());
                                    %>

                                    <p class="post-user-info"> <a href="#!"> <%= ud.getUserByUserId(p.getUserId()).getName()%> </a> has posted : </p>

                                </div>
                                <div class="col-md-4">

                                    <p class="post-date">  <%= DateFormat.getDateTimeInstance().format(p.getpDate())%>  </p>

                                </div>

                            </div>


                            <p class="post-content"> <%= p.getpContent()%> </p>

                            <br>
                            <br>

                            <div class="post-code">
                                <pre> <%= p.getpCode()%> </pre>
                            </div>
                        </div>

                        <div class="card-footer login-background">

                            <%
                                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());                                
                            %>

                            <a href="#!" onclick="doLike(<%= p.getPid()%>,<%= user.getId()%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"> <span class="like-counter"> <%= ld.countLikeOnPost(p.getPid())%> </span> </i> </a>
                            <a href="#!" class="btn btn-outline-light btn-sm"> <i class="fa fa-commenting-o"> <span>5</span> </i> </a>


                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!--end of main content of the body-->


        <!--profile modal-->

        <!--         Button trigger modal
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#profile-modal ">
                    Launch demo modal
                </button>-->

        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class=" modal-header login-background text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel">Akash Patel</h5>


                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center" >

                            <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius: 50%; width: 200px">
                            <!--<br>-->

                            <h5 class="modal-title mt-3" id="exampleModalLabel"> <%= user.getName()%> </h5>
                        </div>

                        <!--profile details-->

                        <div id="profile-details">
                            <table class="table">

                                <tbody>
                                    <tr>
                                        <th scope="row"> ID :</th>
                                        <td> <%= user.getId()%> </td>

                                    </tr>
                                    <tr>
                                        <th scope="row"> Email ID :</th>
                                        <td> <%= user.getEmail()%> </td>

                                    </tr>
                                    <tr>
                                        <th scope="row"> Gender :</th>
                                        <td> <%= user.getGender()%> </td>

                                    </tr>
                                    <tr>
                                        <th scope="row"> About :</th>
                                        <td> <%= user.getAbout()%> </td>

                                    </tr>
                                    <tr>
                                        <th scope="row"> Registered on :</th>
                                        <td> <%= user.getDateTime().toString()%> </td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!--profile edit-->
                        <div id="profile-edit" style="display: none;">
                            <h3 class="mt-2">Please Edit Carefully</h3>
                            <form action="EditServlet" method="post" enctype="multipart/form-data">


                                <table class="table">
                                    <tr>
                                        <td>ID :</td>
                                        <td><%= user.getId()%> </td>
                                    </tr>
                                    <tr>
                                        <td>Name :</td>
                                        <td> <input type="text" class="from-control" name="user_name" value="<%= user.getName()%>"> </td>
                                    </tr>
                                    <tr>
                                        <td>Email ID :</td>
                                        <td> <input type="email" class="from-control" name="user_email" value="<%= user.getEmail()%>"> </td>
                                    </tr>
                                    <tr>
                                        <td>Password :</td>
                                        <td> <input type="password" class="from-control" name="user_password" value="<%= user.getPassword()%>"> </td>
                                    </tr>

                                    <tr>
                                        <td>Gender :</td>
                                        <td><%= user.getGender().toUpperCase()%></td>
                                    </tr>
                                    <tr>
                                        <td>About :</td>
                                        <td>
                                            <textarea rows="3" class="form-control" name="user_about"> <%= user.getAbout()%> 
                                            </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Profile pic:</td>
                                        <td>
                                            <input type="file" name="image" class="form-control">
                                        </td>
                                    </tr>
                                </table>
                                <div class="container text-center">    
                                    <button type="submit" class=" btn btn-outline-primary">Save</button>
                                </div>

                            </form>



                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--end profile modal-->

        <!--add post modal-->

        <!-- Button trigger modal -->

        <!--        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#add">
                    for button modal
                </button>-->


        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide post details...</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form id="add-post-form" action="AddPostServlet" method="post">

                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option selected disabled>---Select Category---</option>

                                    <%
                                        
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategories();
                                        
                                        for (Category c : list) {

                                    %>
                                    <option value=" <%= c.getCid()%> "> <%= c.getName()%>  </option>

                                    <%
                                        }
                                    %>

                                    <!--for manual user side select option for category-->
                                    <!--<option>cat1</option>-->

                                </select>

                            </div>
                            <div class="form-group">
                                <input name="pTitle" type="text" placeholder="Enter post title" class="form-control" >
                            </div>

                            <div class="form-group">
                                <textarea name="pContent" class="form-control" style="height: 150px" placeholder="Enter your content"></textarea>
                            </div>

                            <div class="form-group">
                                <textarea name="pCode" class="form-control" style="height: 150px" placeholder="Enter your program (if any)"></textarea>
                            </div>

                            <div class="form-group"> 
                                <b>  <label> Select your pic..</label></b>
                                <br>
                                <input type="file" name="pic">
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-dark" style="width: 100px; height: 40px; ">Post</button>
                            </div>


                        </form>

                    </div>

                    <!--                    <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>-->

                </div>
            </div>
        </div>

        <!--end add post modal-->


        <!--javaScript-->

        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

        <script>
                                $(document).ready(function () {
                                    let editStatus = false;
                                    $('#edit-profile-button').click(function ()
                                    {
                                        
//                        alert("button clicked")
                                        if (editStatus === false) {
                                            $("#profile-details").hide();
                                            $("#profile-edit").show();
                                            editStatus = true;
                                            $(this).text("back");
                                        } else
                                        {
                                            $("#profile-details").show();
                                            $("#profile-edit").hide();
                                            editStatus = false;
                                            $(this).text("Edit");
                                        }
                                        
                                    });
                                });
        </script>

        <!--now add post JS-->

        <script>
            $(document).ready(function (e) {
                
                $("#add-post-form").on("submit", function (event) {
//              this code gets called when form is submitted...
                    event.preventDefault();
                    console.log("really my boy ...");
                    let form = new FormData(this);
//                    now requesting to the server
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
//                            success....
                            console.log(data);
                            if (data.trim() == 'done') {
                                swal("Good job!", "Saved Successfully !", "success");
                            } else {
                                swal("Error!", "Something Went Wrong Try again!!", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
//                        error....
                            swal("Error!", "Something Went Wrong !", "Error");
                        },
                        processData: false,
                        contentType: false
                                
                    });
                });
            });
        </script>


    </body>
</html>
