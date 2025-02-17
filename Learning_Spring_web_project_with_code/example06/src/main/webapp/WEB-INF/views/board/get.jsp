<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Register</title>

<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
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

	<%@include file="../includes/header.jsp"%>

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
							<div class="form-group">
								<label>Bno</label> <input class="form-control" name="bno"
									value='<c:out value="${board.bno}" />' readonly="readonly" />
							</div>
							<div class="form-group">
								<label>Title</label> <input class="form-control" name="title"
									value='<c:out value="${board.title}" />' readonly="readonly" />
							</div>
							<div class="form-group">
								<label>Text area</label>
								<textarea class="form-control" rows="5" name="content"
									readonly="readonly"><c:out value="${board.content}" /></textarea>
							</div>
							<div class="form-group">
								<label>Writer</label> <input class="form-control" name="writer"
									value='<c:out value="${board.writer}" />' readonly="readonly" />
							</div>
							<div class="d-flex justify-content-center">
								<sec:authentication property="principal" var="pinfo"/>
								<sec:authorize access="isAuthenticated()">
									<c:if test="${pinfo.username eq board.writer}">
									<button data-oper="modify"
										onclick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'"
										class="btn btn-default">Modify</button>
									</c:if>
								</sec:authorize>
								<button data-oper="list" onclick="location.href='/board/list'"
									class="btn btn-default mx-2">List</button>

								<form id="operForm" action="/board/modify" method="get">
									<input type="hidden" id="bno" name="bno"
										value='<c:out value="${board.bno}" />' /> <input
										type="hidden" name="pageNum"
										value='<c:out value="${cri.pageNum}" />' /> <input
										type="hidden" name="amount"
										value='<c:out value="${cri.amount}" />' /> <input
										type="hidden" name="keyword"
										value='<c:out value="${cri.keyword}" />' /> <input
										type="hidden" name="type"
										value='<c:out value="${cri.type}" />' />
								</form>
							</div>
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
							<div class='uploadResult'>
								<ul>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- ./ end row -->
			</div>
		</div>

		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<div class='row'>
					<div class='col-lg-12'>
						<div class='p-5'>
							<div
								class='card-title d-flex align-items-center justify-content-between'>
								<p>
									<i class='fa fa-comments fa-fw'></i> Reply
								</p>
								<sec:authorize access="isAuthenticated()">
								<button id='addReplyBtn'
									class="btn btn-primary btn-xs pull-right">New Reply</button>
								</sec:authorize>
							</div>

							<div class="chat"></div>

							<div class="footer-pagination"></div>
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

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">REPLY MODAL</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Reply</label> <input class="form-control" name="reply" />
					</div>
					<div class='form-group'>
						<label>Replyer</label> <input class="form-control" name="replyer" readonly="readonly" />
					</div>
					<div class='form-group'>
						<label>Reply Date</label> <input class="form-control"
							name="replyDate" value="" />
					</div>
				</div>
				<div class="modal-footer">
					<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
					<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
					<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
					<button id="modalCloseBtn" type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<%@include file="../includes/footer.jsp"%>

	<script type="text/javascript" src="/resources/js/reply.js"></script>
	<script type="text/javascript">
		$('.uploadResult').on('click', 'li', function(e) {
			console.log('view image');
			
			const liObj = $(this);
			const path = encodeURIComponent(`\${liObj.data('path')}/\${liObj.data('uuid')}_\${liObj.data('filename')}`);
			
			if (liObj.data('type')) {
				showImage(path.replace(new RegExp(/\\/g), '/'));
			} else {
				// download
				self.location = `/download?fileName=\${path}`;
			}
			
			function showImage(fileCallPath) {
				alert(fileCallPath);
				
				$('.bigPictureWrapper').css('display', 'flex').show();
				
				$('.bigPicture')
					.html(`<img src='/display?fileName=\${fileCallPath}' />`)
					.animate({ width: '100%', height: '100%' }, 1000);
			}
		})
		
		$('.bigPictureWrapper').on('click', function(e) {
			$('.bigPicture').animate({ width: '0%', height: '0%' }, 1000);
			setTimeout(function() {
				$('.bigPictureWrapper').hide();
			}, 1000);
		})
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
										<img src='/display?fileName=\${fileCallPath}' />
									</div>
								</li>
							`;
						} else {
							str += `
								<li data-path='\${attach.uploadPath}' data-uuid='\${attach.uuid}' data-filename='\${attach.fileName}' data-type='\${attach.fileType}'>
									<span>\${attach.fileName}</span>
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
			const bno = '<c:out value="${board.bno}" />';
			const reply = $('.chat');
			
			/*
			replyService.add(
				{ reply: "JS TEST", replyer: "tester", bno },
				function(result) { alert('RESULT: ' + result); }
			);
			*/
			
			/*
			replyService.remove(
				15,
				function(count) {
					console.log(count);
					
					if (count === 'success') alert('REMOVED');
				},
				function(err) {
					alert('ERRPR ...');
				}
			);
			*/
			
			/*
			replyService.update({
				rno: 14,
				bno,
				reply: 'Modified Reply ...'
			}, function(result) {
				alert('수정 완료 ...');
			});
			*/
			
			replyService.getList(
				{ bno, page: 1 },
				function(list) {
					const len = list.length || 0;
					
					for (let i = 0; i < len; i++) {
						console.log(list[i]);
					}
				}
			);
			
			replyService.get(10, function(data) { console.log(data); });
			
			showList(1);
			
			function showList(page) {
				
				replyService.getList({ bno, page: page || 1 }, function(replyCnt, list) {

					if (page === -1) {
						pageNum = Math.ceil(replyCnt / 10.0);
						showList(pageNum);
						return;
					}
					
					let str = '';
					
					if (!list || list.length === 0) {
						return;
					}
					
					const len = list.length || 0;
					
					for (let i = 0; i < len; i++) {
						str += `
							<div class='card-text' data-rno='\${list[i].rno}'>
								<div class='header'>
									<strong class='primary-font'>\${list[i].replyer}</strong>
									<small class='pull-right text-muted'>
										\${replyService.displayTime(list[i].replyDate)}
									</small>
								</div>
								<p>\${list[i].reply}</p>
		        			</div>
						`;
					}
					
					reply.html(str);
					
					showReplyPage(replyCnt);
				}); // end getList function
			} // end showList
			
			const modal = $('.modal');
			
			const modalInputReply = modal.find(`input[name='reply']`);
			const modalInputReplyer = modal.find(`input[name='replyer']`);
			const modalInputReplyDate = modal.find(`input[name='replyDate']`);
			
			const modalModBtn = $('#modalModBtn');
			const modalRemoveBtn = $('#modalRemoveBtn');
			const modalRegisterBtn = $('#modalRegisterBtn');
			
			let replyer = null;
			
			<sec:authorize access="isAuthenticated()">
			replyer = '<sec:authentication property="principal.username" />';
			</sec:authorize>
				
			const csrfHeaderName = "${_csrf.headerName}";
			const csrfTokenValue = "${_csrf.token}";
			
			$(document).ajaxSend(function(e, xhr, options) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			});
			
			$('#addReplyBtn').on('click', function(e) {
				
				modal.find('input').val('');
				modal.find('input[name="replyer"]').val(replyer);
				console.log(modal.find('input[name="replyer"]'));
				modalInputReplyDate.closest('div').hide();
				modal.find('button[id != "modalCloseBtn"]').hide();
				
				modalRegisterBtn.show();
				
				$('.modal').modal('show');
			})
			
			modalRegisterBtn.on('click', function(e) {
				
				const reply = {
					reply: modalInputReply.val(),
					replyer: modalInputReplyer.val(),
					bno,
				};
				
				replyService.add(reply, function(result) {
					alert(result);
					
					modal.find('input').val();
					modal.modal('hide');
					
					showList(-1);
				});
			})
			
			$('.chat').on('click', '.card-text', function(e) {
				
				const rno = $(this).data('rno');

				replyService.get(rno, function(reply) {
					modalInputReply.val(reply.reply);
					modalInputReplyer.val(reply.replyer);
					modalInputReplyDate
						.val(replyService.displayTime(reply.replyDate))
						.attr('readonly', 'readonly');
				
					modal.data('rno', reply.rno);
					modal.find('button[id != "modalCloseBtn"]').hide();
					modalModBtn.show();
					modalRemoveBtn.show();
					
					$('.modal').modal('show');
				})
			})
			
			modalModBtn.on('click', function(e) {
				
				const originalReplyer = modalInputReplyer.val();
				
				const reply = {
					rno: modal.data('rno'),
					reply: modalInputReply.val(),
					replyer: originalReplyer
				};
				
				if (!replyer) {
					alert("로그인 후 수정이 가능합니다.");
					modal.modal("hide");
					return;
				}
				
				console.log("Original Replyer: " + originalReplyer);
				
				if (reypler != originalReplyer) {
					alert("자신이 작성한 댓글만 수정이 가능합니다.");
					modal.modal("hide");
					return;
				}
				
				replyService.update(reply, function(result) {
					alert(result);
					modal.modal('hide');
					showList(pageNum);
				})
			})
			
			modalRemoveBtn.on('click', function(e) {
				
				const rno = modal.data('rno');
				
				console.log("RNO: " + rno);
				console.log("REPLYER: " + replyer);
				
				if (!replyer) {
					alert("로그인 후 삭제가 가능합니다.");
					modal.modal("hide");
					return;
				}
				
				const originalReplyer = modalInputReplyer.val();
				
				console.log("Original Replyer: " + originalReplyer); // 댓글의 원래 작성자
				
				if (replyer != originalReplyer) {
					alert("자신이 작성한 댓글만 삭제가 가능합니다.");
					modal.modal("hide");
					return;
				}
				
				replyService.remove(rno, originalReplyer, function(result) {
					alert(result);
					modal.modal('hide');
					showList(pageNum);
				})
			})
			
			let pageNum = 1;
			const replyPageFooter = $('.footer-pagination');
			
			replyPageFooter.on("click", "li a", function(e) {
				e.preventDefault();
				
				console.log('page click');
				
				const targetPageNum = $(this).attr('href');
				
				console.log('target page num : ' + targetPageNum);
				
				pageNum = targetPageNum;
				
				showList(pageNum);
			})
			
			function showReplyPage(replyCnt) {
				
				let endNum = Math.ceil(pageNum / 10.0) * 10;
				let startNum = endNum - 9;
				
				let prev = startNum != 1;
				let next = false;
				
				if (endNum * 10 >= replyCnt) {
					endNum = Math.ceil(replyCnt / 10.0);
				}
				
				if (endNum * 10 < replyCnt) {
					next = true;
				}
				
				let str = `<ul class="pagination justify-content-end mt-3">`;
				
				if (prev) {
					str += `
						<li class="page-item previous">
	           				<a class="page-link" href="\${startNum - 1}">Previous</a>
	           			</li>
					`;
				}
				
				for (let i = startNum; i <= endNum; i++) {
					const active = pageNum == i ? 'active' : '';
					
					str += `
               			<li class="page-item \${active}">
	           				<a class="page-link" href="\${i}">\${i}</a>
	           			</li>
					`;
				}
				
				if (next) {
					str += `
						<li class="page-item next">
	           				<a class="page-link" href="\${endNum + 1}">Next</a>
	           			</li>
					`;
				}
				
				str += `</ul>`;
				
				replyPageFooter.html(str);
			}
		})
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			const operForm = $("#operForm");
			
			$("button[data-oper='modify']").on("click", function(e) {
				operForm.attr("action", "/board/modify").submit();
			})
			
			$("button[data-oper='list']").on("click", function(e) {
				operForm.find("#bno").remove();
				operForm.attr("action", "/board/list")
				operForm.submit();
			})
		})
	</script>

</body>

</html>