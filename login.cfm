<!DOCTYPE html>
	<html>
		<head>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<cfoutput><title>#application.title#</title></cfoutput>
			<link href="css/bootstrap.min.css" rel="stylesheet">
			<link href="font-awesome/css/font-awesome.css" rel="stylesheet">
			<link href="css/animate.css" rel="stylesheet">
			<link href="css/style.css" rel="stylesheet">
		</head>
		
		<cfoutput>
			<body class="gray-bg">
				<div class="middle-box text-center loginscreen animated fadeInDown">
					<div>
						<div>
							<h1 class="logo-name">QC+</h1>
						</div>
						<h3>Welcome to QwikCut App</h3>
						<p>Login required to proceed.</p>
						
						<form class="m-t" role="form" action="/index.cfm" method="post">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><i class="fa fa-user"></i></div>
									<input type="text" name="j_username" class="form-control" placeholder="Enter Username">
								</div>
							</div>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><i class="fa fa-lock"></i></div>
									<input type="password" name="j_password" class="form-control" placeholder="Enter Password">
								</div>
							</div>
							<button type="submit" class="btn btn-primary block full-width m-b">Login</button>

							<a href="javascript:void(0);"><small>Forgot password?</small></a>
							<p class="text-muted text-center"><small>Don't have an account?</small></p>
							<a class="btn btn-sm btn-white btn-block" href="register.cfm">Create an account</a>
						</form>
						
						<p class="m-t">							
							<small>&copy; Qwikcut.com  #year( now() )#.  All Rights Reserved. 
								<br />Game Film Video and Analytics.
							</small>							
						</p>
					</div>
				</div>

				<!-- Mainly scripts -->
				<script src="js/jquery-2.1.1.js"></script>
				<script src="js/bootstrap.min.js"></script>

			</body>
			</cfoutput>
	</html>
