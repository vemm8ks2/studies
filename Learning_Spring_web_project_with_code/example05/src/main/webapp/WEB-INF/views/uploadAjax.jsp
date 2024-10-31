<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<body>
	<h1>Upload with Ajax</h1>
	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>
	<div class='uploadResult'>
		<ul></ul>
	</div>
	<button id='uploadBtn'>Upload</button>
	
	<div class='bigPictureWrapper'>
		<div class='bigPicture'></div>
	</div>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>

	<script>
		function showImage(fileCallPath) {
			$('.bigPictureWrapper').css('display', 'flex').show();
			$('.bigPicture')
				.html(`<img src='/display?fileName=\${encodeURI(fileCallPath)}' />`)
				.animate({ width: '100%', height: '100%' }, 1000);
		}
		
		$(".bigPictureWrapper").on("click", function(e) {
			$(".bigPicture").animate({ width: '0%', height: '0%' }, 1000);
			setTimeout(() => { $(this).hide(); }, 1000);
		})
	
		$(document).ready(function() {
			const regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			const maxSize = 5242880; // 5MB
			
			function checkExtension(fileName, fileSize) {
				
				if (fileSize >= maxSize) {
					alert('파일 사이즈 초과');
					return;
				}
				
				if (regex.test(fileName)) {
					alert('해당 종류의 파일은 업로드할 수 없습니다.');
					return;
				}
				
				return true;
			}
			
			const cloneObj = $(".uploadDiv").clone();
			const uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr) {
				
				let str = '';
				
				$(uploadResultArr).each(function(i, obj) {
					if (!obj.image) {
						const fileCallPath = encodeURIComponent(`\${obj.uploadPath}/\${obj.uuid}_\${obj.filename}`);
						
						str += `
							<li>
								<a href='/download?fileName=\${fileCallPath}'>
									<img src='/resources/img/attach.png' />
									\${obj.filename}
								</a>
							</li>
						`;
					} else {
						const fileCallPath = encodeURIComponent(`\${obj.uploadPath}/s_\${obj.uuid}_\${obj.filename}`);
						let originPath = `\${obj.uploadPath}\\\${obj.uuid}_\${obj.filename}`;
						
						originPath = originPath.replace(new RegExp(/\\/g), "/");
						
						str += `
							<li>
								<a href='javascript:showImage("\${originPath}")'>
									<img src='/display?fileName=\${fileCallPath}' />
								</a>
							</li>
						`;
					}
				});
				
				uploadResult.append(str);
			}
			
			$("#uploadBtn").on("click", function(e) {
				const formData = new FormData();
				const inputFile = $("input[name='uploadFile']");
				const files = inputFile[0].files;
				
				console.log(files);
				
				for (let i = 0; i < files.length; i++) {
					if (!checkExtension(files[i].name, files[i].size)) {
						return;
					}
					
					formData.append("uploadFile", files[i]);
				}
				
				$.ajax({
					url: '/uploadAjaxAction',
					processData: false,
					contentType: false,
					data: formData,
					type: 'POST',
					dataType: 'json',
					success: function(result) {
						console.log(result);
						
						showUploadedFile(result);
						$(".uploadDiv").html(cloneObj.html());
					}
				});
			})
		})
	</script>
</body>
</html>