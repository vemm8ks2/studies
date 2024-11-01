<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
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
    
	<style type="text/css">
	.uploadResult {
		width: 100%;
		background-color: gray;
	}
	
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}
	
	.uploadResult ul li img {
		width: 100px;
	}
	
	.uploadResult ul li span {
		color: white;
	}
	
	.bigPictureWrapper {
		position: absolute;
		display: none;
		justify-content: center;
		align-items: center;
		top: 0%;
		width: 100%;
		height: 100%;
		background-color: gray;
		z-index: 100;
		background: rgba(255, 255, 255, 0.5);
	}
	
	.bigPicture {
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.bigPicture img {
		width: 600px;
	}
	</style>

</head>

<body class="bg-gradient-primary">

	<%@include file="../includes/header.jsp" %>

	<!-- Begin Page Content -->
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
                            <form role="form" action="/board/modify" method="post">
                            	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}" />' />
                            	<input type="hidden" name="amount" value='<c:out value="${cri.amount}" />'>
                            	<input type="hidden" name="type" value='<c:out value="${cri.type}" />'>
                            	<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}" />'>
                            	
                                <div class="form-group">
                                	<label>Bno</label>
                                	<input class="form-control" name="bno" value='<c:out value="${board.bno}" />' readonly="readonly" />
                                </div>
                                <div class="form-group">
                                	<label>Title</label>
                                	<input class="form-control" name="title" value='<c:out value="${board.title}" />' />
                                </div>
                                <div class="form-group">
                                	<label>Text area</label>
                                	<textarea class="form-control" rows="5" name="content"><c:out value="${board.content}" /></textarea>
                                </div>
                                <div class="form-group">
                                	<label>Writer</label>
                                	<input class="form-control" name="writer" value='<c:out value="${board.writer}" />' readonly="readonly" />
                                </div>
                                <div class="form-group">
                                	<label>Reg Date</label>
                                	<input class="form-control" name="regDate" 
                                		value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}" />' readonly="readonly" />
                                </div>
                                <div class="form-group">
                                	<label>Update Date</label>
                                	<input class="form-control" name="updateDate" 
                                		value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updatedate}" />' readonly="readonly" />
                                </div>
                                <div class="d-flex justify-content-center">
	                                <button data-oper="modify" class="btn btn-default">
	                                	Modify
	                                </button>
	                                <button data-oper="remove" class="btn btn-danger mx-2">
	                                	Remove
	                                </button>
	                                <button data-oper="list" class="btn btn-info">
	                                	List
	                                </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<div class='row'>
					<div class='col-lg-12'>
						<div class='p-5'>
							<div class='card-title'>Files</div>
							<div class='uploadDiv'>
								<input type='file' name="uploadFile" multiple>
							</div>
							<div class='uploadResult mt-2'>
								<ul>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- ./ end row -->
			</div>
		</div>
    </div>
    <!-- /.container-fluid -->

	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>

	<%@include file="../includes/footer.jsp" %>
	
	<script type="text/javascript">
		$('.uploadResult').on('click', 'button', function(e) {
			console.log('delete file');
			
			if (confirm('Remove this file?')) {
				const targetLi = $(this).closest('li');
				targetLi.remove();	
			}
		});
		
		const regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		const maxSize = 5242880; // 5MB

		function checkExtension(fileName, fileSize) {
			if (fileSize >= maxSize) {
				alert('파일 사이즈 초과');
				return;
			}
			
			if (regex.test(fileName)) {
				alert('해당 종류의 파일은 업로드할 수 없습니다.')
				return;
			}
			
			return true;
		}
		
		$("input[type='file']").change(function(e) {
			const formData = new FormData();
			const inputFile = $("input[name='uploadFile']");
			const files = inputFile[0].files;
			
			for (let i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return;
				}
				
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: "/uploadAjaxAction",
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType: 'json',
				success: function(result) {
					console.log(result);
					showUploadResult(result); // 업로드 결과 처리 함수
				}
			})
		})
		
		function showUploadResult(uploadResultArr) {
			if (!uploadResultArr || uploadResultArr.length === 0) return;
			
			const uploadUL = $(".uploadResult ul");
			let str = '';
			
			$(uploadResultArr).each(function(i, obj) {
				// image type
				if (obj.image) {
					const fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.filename);
					
					str += `
						<li data-path='\${obj.uploadPath}' data-uuid='\${obj.uuid}' data-filename='\${obj.filename}' data-type='\${obj.image}'>
							<div>
								<span>\${obj.filename}</span>
								<button data-file='\${fileCallPath}' data-type='image' class='btn btn-warning btn-circle'>
									<i class='fa fa-times'></i>
								</button>
								<br>
								<img src='/display?fileName=\${fileCallPath}' />
							</div>
						</li>
					`;
				} else {
					const fileCallPath = encodeURIComponent(obj.uploadPath + "/_" + obj.uuid + "_" + obj.filename);
					const fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					
					str += `
						<li data-path='\${obj.uploadPath}' data-uuid='\${obj.uuid}' data-filename='\${obj.filename}' data-type='\${obj.image}'>
							<div>
								<span>\${obj.filename}</span>
								<button data-file='\${fileCallPath}' data-type='file' class='btn btn-warning btn-circle'>
									<i class='fa fa-times'></i>
								</button>
								<br>
								<img src='/resources/img/attach.png' />
							</div>
						</li>
					`;
				}
			});
			
			uploadUL.append(str);
		}
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			(function() {
				const bno = '<c:out value="${board.bno}" />';
				
				$.getJSON("/board/getAttachList", { bno }, function(arr) {
					console.log(arr);
					
					let str = '';
					
					$(arr).each(function(i, attach) {
						// image type
						if (attach.fileType) {
							const fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
							
							str += `
								<li data-path='\${attach.uploadPath}' data-uuid='\${attach.uuid}' data-filename='\${attach.fileName}' data-type='\${attach.fileType}'>
									<div>
										<span>\${attach.fileName}</span>
										<button data-file='\${fileCallPath}' data-type='image' class='btn btn-warning btn-circle'>
											<i class='fa fa-times'></i>
										</button>
										<br>
										<img src='/display?fileName=\${fileCallPath}' />
									</div>
								</li>
							`;
						} else {
							const fileCallPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
							
							str += `
								<li data-path='\${attach.uploadPath}' data-uuid='\${attach.uuid}' data-filename='\${attach.fileName}' data-type='\${attach.fileType}'>
									<span>\${attach.fileName}</span>
									<button data-file='\${fileCallPath}' data-type='file' class='btn btn-warning btn-circle'>
										<i class='fa fa-times'></i>
									</button>
									<br>
									<img src='/resources/img/attach.png' />
								</li>
							`;
						}
					});
					
					$(".uploadResult ul").html(str);
				});
			})();
		})
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			const formObj = $("form");
			
			$('button').on('click', function(e) {
				e.preventDefault();
				
				const operation = $(this).data("oper");
				
				if (operation === 'remove') {
					formObj.attr("action", "/board/remove");
				} else if (operation === 'list') {
					formObj
						.attr("action", "/board/list")
						.attr("method", "get");
					
					const pageNumTag = $("input[name='pageNum']").clone();
					const amountTag = $("input[name='amount']").clone();
					const keywordTag = $("input[name='keyword']").clone();
					const typeTag = $("input[name='type']").clone();
					
					formObj.empty();
					
					formObj.append(pageNumTag);
					formObj.append(amountTag);
					formObj.append(keywordTag);
					formObj.append(typeTag);
				}
				
				formObj.submit();
			})
			
		})
	</script>

</body>

</html>