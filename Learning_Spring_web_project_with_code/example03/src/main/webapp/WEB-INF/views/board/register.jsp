<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Register</title>

    <!-- Custom fonts for this template-->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">

	<%@include file="../includes/header.jsp" %>

	<!-- Begin Board Register Content -->
    <div class="container-fluid">
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Board Register</h1>
                            </div>
                            <form role="form" action="/board/register" method="post">
                                <div class="form-group">
                                	<label>Title</label>
                                	<input class="form-control" name="title" />
                                </div>
                                <div class="form-group">
                                	<label>Text area</label>
                                	<textarea class="form-control" rows="5" name="content"></textarea>
                                </div>
                                <div class="form-group">
                                	<label>Writer</label>
                                	<input class="form-control" name="writer" />
                                </div>
                                <div class="d-flex justify-content-center">
	                                <button type="submit" class="btn btn-default">
	                                	Submit
	                                </button>
	                                <button type="reset" class="btn btn-default mx-2">
	                                	Reset
	                                </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->
    
    
	<!-- Begin File Attach Content -->
    <div class="container-fluid">
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">File Attach</h1>
                            </div>
						   <div class="custom-file uploadDiv">
						     <input type="file" class="custom-file-input" id="inputGroupFile01" name="uploadFile" multiple>
						     <label class="custom-file-label" for="inputGroupFile01">파일 선택</label>
						   </div>
                            <div class="uploadResult">
                            	<ul>
                            	</ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->

	<%@include file="../includes/footer.jsp" %>

</body>

</html>