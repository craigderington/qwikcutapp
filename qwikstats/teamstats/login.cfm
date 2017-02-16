<!DOCTYPE html>
	<html>
		<head>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<cfoutput><title>#application.title#</title></cfoutput>
			<link href="../../css/bootstrap.min.css" rel="stylesheet">
			<link href="../../font-awesome/css/font-awesome.css" rel="stylesheet">
			<link href="../../css/animate.css" rel="stylesheet">
			<link href="../../css/style.css" rel="stylesheet">
		</head>

		<cfoutput>
			<body class="gray-bg">

				<!--- // system messages --->
				<cfif isdefined( "REQUEST.badlogin" )>
					<div class="alert alert-danger alert-dismissable fade in">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
							<h4 class="alert-heading"><i class="fa fa-warning"></i> Login Failed!</h4>
								<p>Sorry, your login credentials have failed.  Either your username OR password was entered incorrectly.  Please try again...</p>
					</div>
				<cfelseif isdefined( "REQUEST.nostatsdata" )>
					<div class="alert alert-info alert-dismissable fade in">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
							<h3 class="alert-heading"><i class="fa fa-warning"></i> Your login is working OK!</h3>
								<p>However, we're still crunching your numbers.  Your team's stats will be ready soon.  Please check back.</p>
					</div>
				<cfelseif isdefined( "url.logout" ) and url.logout eq 1>
					<div class="alert alert-success alert-dismissable fade in">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
							<h4 class="alert-heading"><i class="fa fa-check-square"></i> THANK YOU!</h4>
							<p>Your logout request was processed successfully.  To continue, please login again or close this window.</p>
					</div>
				</cfif>



				<div class="middle-box text-center loginscreen animated fadeInDown">
					<div>
						<div>
							<h1 class="logo-name"><i class="fa fa-soccer-ball-o"></i></h1>
						</div>
						<h3>QwikStats</h3>
						<p>A QwikCut Video and Analytics App</p>
						<p>Login required to proceed.</p>





						<form class="m-t" role="form" action="https://app.qwikcut.com/qwikstats/teamstats/index.cfm?event=dashboard" method="post">
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><i class="fa fa-user"></i></div>
									<input type="text" name="j_username" class="form-control" placeholder="Enter Username" autocomplete="off" autofocus>
									<input type="hidden" name="login" value="">
								</div>
							</div>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><i class="fa fa-lock"></i></div>
									<input type="password" name="j_password" class="form-control" placeholder="Enter Password">
								</div>
							</div>
							<button type="submit" class="btn btn-primary block full-width m-b">Login</button>
							
							<!---<a href="javascript:void(0);"><small>Forgot password?</small></a>--->
							<p class="text-muted text-center"><small>Don't have an account?</small></p>
							<a class="btn btn-sm btn-white btn-block" href="mailto:todd@qwikcut.com?subject=QwikStats">Contact QwikStats</a>
						</form>

						<p class="m-t">
							<small>&copy; QwikStats Video &amp; Analytics  #year( now() )#.  All Rights Reserved.</small>
						</p>

						<!---
						<p>

							<cfquery name="testusers">
								select *
								from dbo.users
							</cfquery>

							<cfdump var="#testusers#" label="User List">

						</p>
						--->



					</div>
				</div>

				<!-- Mainly scripts -->
				<script src="../../js/jquery-2.1.1.js"></script>
				<script src="../../js/bootstrap.min.js"></script>

			</body>
			</cfoutput>
	</html>
