

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>

        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">        <link href="css/mycss.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 82%, 65% 94%, 30% 93%, 0 100%, 0 0);
            }
        </style>
    </head>
    <body>

        <%@include file="navbar_normal.jsp" %>

        <main class="primary-background banner-background  " style="padding-bottom: 80px; padding-top: 10px;">

            <div class="container">
                <div class="col-md-6 offset-md-3 mt-2">
                    <div class="card">
                        <div class="card-header text-center login-background text-white">
                            <span class="fa fa-3x fa-user-circle"></span>
                            <br>
                            Register here !
                        </div>
                        <div class="card-body">

                            <form id="reg-form" action="RegisterServlet" method="POST">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="user_name" placeholder="Enter name">
                                </div>


                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>


                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                </div>


                                <div class="form-group">
                                    <label for="gender">Gender :-</label>
                                    <br>
                                    <input type="radio" id="gender" name='gender' value="male"> Male
                                    <!--<br>-->
                                    <input type="radio" id="gender" name='gender' value="female"> Female
                                </div>

                                <div class="from-group">

                                    <textarea name="about" class="form-control" rows="5" placeholder="Enter Somthing Aboutr your Self"></textarea>

                                </div>


                                <div class="form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">terms & conditions</label>
                                </div>
                                <br>
                                <div class="container text-center" id="loader" style="display: none;">
                                    <span class="fa fa-refresh fa-spin fa-4x"></span>
                                    <h3>Please wait !!</h3>
                                </div>
                                <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
                            </form>

                        </div>


                        <!--                        <div class="card-footer">
                        
                        
                                                </div>-->


                    </div>

                </div>

            </div>

        </main>




        <!--javaScript-->

        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {
                console.log("Loaded....");

                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    $("#submit-btn").hide;
                    $("#loader").show();

//                     send Register servlet
                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $("#submit-btn").show;
                            $("#loader").hide();

                            if (data.trim() === 'done')
                            {

                                swal("Registered Successfully.. Let's go to Log in page")
                                        .then((value) => {
                                            window.location = "login_page.jsp"
//                                        swal(`The returned value is: ${value}`);
                                        });
                            } else {
                                
                                swal(data);

                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
//                            console.log(jqXHR);
                            $("#submit-btn").show;
                            $("#loader").hide();

                            swal("Something went Wrong try again..")
                        },
                        processData: false,
                        contentType: false

                    });
                });
            });


        </script>
    </body>
</html>
