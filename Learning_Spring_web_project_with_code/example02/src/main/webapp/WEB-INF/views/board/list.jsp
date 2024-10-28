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

    <title>SB Admin 2 - Tables</title>

    <!-- Custom fonts for this template -->
    <link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>

<body id="page-top">

	<%@include file="../includes/header.jsp" %>

    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Tables</h1>
        <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
            For more information about DataTables, please visit the <a target="_blank"
                href="https://datatables.net">official DataTables documentation</a>.</p>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3 d-flex justify-content-between align-items-center">
                <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                <button id="regBtn" type="button" class="btn btn-xs pull-right">
                	Register New Board
               	</button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>#번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>수정일</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>#번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>수정일</th>
                            </tr>
                        </tfoot>
                        <tbody>
                        	<c:forEach items="${list}" var="board">
                        	<tr>
                        		<td>${board.bno}</td>
                        		<td>
                        			<a class='move' href='<c:out value="${board.bno}" />'>
                        				<c:out value="${board.title}" />
                       				</a>
                       			</td>
                        		<td>${board.writer}</td>
                        		<td>
                        			<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}" />
                        		</td>
                        		<td>
                        			<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updatedate}" />
                        		</td>
                        	</tr>
                        	</c:forEach>
                        </tbody>
                    </table>
                    
                    <div class='row justify-content-end px-3'>
                   		<form id="searchForm" action="/board/list" method="get" class="d-flex py-2 w-50">
                   			<select class="custom-select w-25" name="type">
                   				<option 
                   					value=""
                   					<c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" />
                 				>
                   					---
               					</option>
                   				<option 
                   					value="T"
                   					<c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}" />
                 				>
                 					제목
                 				</option>
                   				<option 
                   					value="C"
                   					<c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}" />
                   				>
                   					내용
                   				</option>
                   				<option 
                   					value="W"
                   					<c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}" />
                   				>
                   					작성자
                   				</option>
                   				<option 
                   					value="TC"
                   					<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}" />
                   				>
                   					제목 or 내용
                   				</option>
                   				<option 
                   					value="TW"
                   					<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}" />
                   				>
                   					제목 or 작성자
                   				</option>
                   				<option 
                   					value="TWC"
                   					<c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : ''}" />
                   				>
                   					제목 or 내용 or 작성자
                   				</option>
                   			</select>
                   			<input 
                   				class="form-control mx-2" 
                   				name="keyword"
                   				value='<c:out value="${pageMaker.cri.keyword}" />' 
                   			/>
                   			<input 
                   				type="hidden" 
                   				name="pageNum" 
                   				value='<c:out value="${pageMaker.cri.pageNum}" />' 
                   			/>
                   			<input 
                   				type="hidden" 
                   				name="amount" 
                   				value='<c:out value="${pageMaker.cri.amount}" />' 
                   			/>
                   			<button class="btn btn-default">Search</button>
                   		</form>
                    </div>
                    
                    <nav aria-label="Page navigation">
					  <ul class="pagination justify-content-end mt-3">
                   		<c:if test="${pageMaker.prev}">
                   			<li class="page-item previous">
                   				<a class="page-link" href="#">Previous</a>
                   			</li>
                   		</c:if>
                   		
                   		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                   			<li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">
                   				<a class="page-link" href="${num}">${num}</a>
                   			</li>
                   		</c:forEach>
                   		
                   		<c:if test="${pageMaker.next}">
                   			<li class="page-item next">
                   				<a class="page-link" href="#">Next</a>
                   			</li>
                   		</c:if>
					  </ul>
					</nav>
					
					<form id="actionForm" action="/board/list" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}" />' />
						<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}" />' />
					</form>
					
					<!-- Modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					    <div class="modal-dialog" role="document">
					        <div class="modal-content">
					            <div class="modal-header">
					                <h5 class="modal-title" id="myModalLabel">Modal title</h5>
					                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close">&times;</button>
					            </div>
					            <div class="modal-body">처리가 완료되었습니다.</div>
					            <div class="modal-footer"><button class="btn btn-secondary" type="button" data-bs-dismiss="modal">Close</button><button class="btn btn-primary" type="button">Save changes</button></div>
					        </div>
					    </div>
					</div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.container-fluid -->

	<%@include file="../includes/footer.jsp" %>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			const result = '<c:out value="${result}" />';
			
			checkModal(result);
			
			history.replaceState({}, null, null);
			
			function checkModal(result) {
				if (result === '' || history.state) return;
			
				if (parseInt(result) > 0) {
					$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
				}
				
				$("#myModal").modal("show");
			}
			
			$("#regBtn").on("click", function() {
				self.location = "/board/register";
			});
			
			const actionForm = $("#actionForm");
			
			$(".page-item a").on("click", function(e) {
				e.preventDefault();
				
				actionForm.find("input[name='pageNum']").val($(this).attr('href'));
				actionForm.submit();
			})
			
			$(".move").on("click", function(e) {
				e.preventDefault();
				
				actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "' >");
				actionForm.attr("action", "/board/get");
				actionForm.submit();
			})
			
			const searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function(e) {
				e.preventDefault();
				
				if (!searchForm.find("option:selected").val()) {
					alert("검색 종류를 선택하세요.");
					return;
				}
				
				if (!searchForm.find("input[name='keyword']").val()) {
					alert("키워드를 입력하세요.");
					return;
				}
				
				searchForm.find("input[name='pageNum']").val("1");
				searchForm.submit();
			})
		});
		
	    $.extend( $.fn.dataTable.defaults, {
	    	"bFilter": false, 
	    	"bInfo": false,
	    	"bSort": false,
	        "bPaginate": false,
	        "bLengthChange": false,
	    } );
	</script>
</body>

</html>