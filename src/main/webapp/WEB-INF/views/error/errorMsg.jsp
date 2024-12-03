<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BHP SYSTEM</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<script>
		const title = '${title}';
		const msg   = '${msg}';  
		const icon  = '${icon}'; 
		const loc   = '${loc}' ; 
		const callback  = '${callback}';
		
		swal({
			title : title,
			text  : msg,
			icon  : icon
		}).then(function(){
			
			if(callback != '' && callback != null){
				eval(callback);
			}
			
			if(loc != '' && loc != null){
				if($(window.opener) != null){
					self.close();
				}
				location.href = loc; 
			}
		});
	</script>
</body>
</html>