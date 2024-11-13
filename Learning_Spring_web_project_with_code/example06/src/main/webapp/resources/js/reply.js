console.log("Reply Module ...");

const replyService = (function() {

	function add(reply, callback, error) {
		console.log("add reply ...");
		
		$.ajax({
			type: 'post',
			url: '/replies/new',
			data: JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error: function(xhr, status, err) {
				if (error) {
					error(err);
				}
			}
		});
	}
	
	function getList(param, callback, error) {
		
		const bno = param.bno;
		const page = param.page || 1;
		
		$.getJSON(
			`/replies/pages/${bno}/${page}.json`,
			function({ replyCnt, list }) {
				if (callback) {
					callback(replyCnt, list);
				}
			}
		).fail(function(xhr, status, err) {
			if (error) error();
		})		
	}
	
	function remove(rno, replyer, callback, error) {
		$.ajax({
			type: 'delete',
			url: `/replies/${rno}`,
			data: JSON.stringify({ rno, replyer }),
			contentType: 'application/json; charset=utf-8',
			success: function(deleteResult, status, xhr) {
				if (callback) callback(deleteResult);
			},
			error: function(xhr, status, err) {
				if (error) error(err);
			}
		});
	}
	
	function update(reply, callback, error) {
		console.log(`RNO: ${reply.rno}`);
		
		$.ajax({
			type: 'put',
			url: `/replies/${reply.rno}`,
			data: JSON.stringify(reply),
			contentType: 'application/json; charset=utf-8',
			success: function(result, status, xhr) {
				if (callback) callback(result);
			},
			error: function(xhr, status, err) {
				if (error) error(err);
			}
		});
	}
	
	function get(rno, callback, error) {
		$.get(
			`/replies/${rno}.json`,
			function(result) {
				if (callback) callback(result);
			}
		).fail(function(xhr, status, err) {
			if (error) error();
		})
	}
	
	function displayTime(timeValue) {
		const today = new Date();
		const gap = today.getTime() - timeValue;
		const dateObj = new Date(timeValue);
		
		let str = '';
		
		if (gap < (1000 * 60 * 60 * 24)) {
			const hh = dateObj.getHours();
			const mi = dateObj.getMinutes();
			const ss = dateObj.getSeconds();
			
			return [
				(hh > 9 ? '' : '0') + hh, ':',
				(mi > 9 ? '' : '0') + mi, ':',
				(ss > 9 ? '' : '0') + ss,
			].join('');
		} else {
			const yy = dateObj.getFullYear();
			const mm = dateObj.getMonth() + 1;
			const dd = dateObj.getDate();
			
			return [
				yy, '/',
				(mm > 9 ? '' : '0') + mm, '/',
				(dd > 9 ? '' : '0') + dd
			].join('');
		}
	}

	return { add, getList, remove, update, get, displayTime };
})();