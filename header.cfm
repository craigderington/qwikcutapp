


		<!doctype html>
			<html lang="en">			
				<head>
					<cfoutput>
						<title>#application.title#</title>
					</cfoutput>									
									
					<meta charset="utf-8">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<meta name="apple-mobile-web-app-capable" content="yes"> 				
					
					<!-- Boostrap and Font-Awesome -->
					<link href="css/bootstrap.min.css" rel="stylesheet">
					<link href="font-awesome/css/font-awesome.css" rel="stylesheet">
					<link href="css/animate.css" rel="stylesheet">
					<link href="css/style.css" rel="stylesheet">			

					<!--- // make sure that none of our dynamic pages are cached by the users browser --->
					<cfheader name="cache-control" value="no-cache,no-store,must-revalidate" >
					<cfheader name="pragma" value="no-cache" >
					<cfheader name="expires" value="#getHttpTimeString( Now() )#" >
					
					<!--- // also ensure that non-dynamic pages are not cached by the users browser --->
					<META HTTP-EQUIV="expires" CONTENT="-1">
					<META HTTP-EQUIV="pragma" CONTENT="no-cache">
					<META HTTP-EQUIV="cache-control" CONTENT="no-cache,no-store,must-revalidate">
				
				</head>
				
				<body class="top-navigation">
					<div id="wrapper">
						<div id="page-wrapper" class="gray-bg">
							<div class="row border-bottom white-bg">
								<nav class="navbar navbar-static-top" role="navigation">
									<div class="navbar-header">
										<button aria-controls="navbar" aria-expanded="false" data-target="#navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
											<i class="fa fa-reorder"></i>
										</button>
										<a href="#" class="navbar-brand">QWIKCUT</a>
									</div>
					
										<div class="navbar-collapse collapse" id="navbar">
											<ul class="nav navbar-nav">
												<li class="active">
													<a aria-expanded="false" role="button" href="index.cfm"> Game Video &amp; Analytics</a>
												</li>
												<li class="dropdown">
													<a aria-expanded="false" role="button" href="#" class="dropdown-toggle" data-toggle="dropdown"> Conferences <span class="caret"></span></a>
													<ul role="menu" class="dropdown-menu">
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
													</ul>
												</li>
												<li class="dropdown">
													<a aria-expanded="false" role="button" href="#" class="dropdown-toggle" data-toggle="dropdown"> Teams <span class="caret"></span></a>
													<ul role="menu" class="dropdown-menu">
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
													</ul>
												</li>
												<li class="dropdown">
													<a aria-expanded="false" role="button" href="#" class="dropdown-toggle" data-toggle="dropdown"> Game Schedules <span class="caret"></span></a>
													<ul role="menu" class="dropdown-menu">
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
													</ul>
												</li>
												<li class="dropdown">
													<a aria-expanded="false" role="button" href="#" class="dropdown-toggle" data-toggle="dropdown"> My Profile <span class="caret"></span></a>
													<ul role="menu" class="dropdown-menu">
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
													</ul>
												</li>
												
												<li class="dropdown">
													<a aria-expanded="false" role="button" href="#" class="dropdown-toggle" data-toggle="dropdown"> Administration <span class="caret"></span></a>
													<ul role="menu" class="dropdown-menu">
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
														<li><a href="">Menu item</a></li>
													</ul>
												</li>
												

											</ul>
											<ul class="nav navbar-top-links navbar-right">
												<li>
													<a href="logout.cfm">
														<i class="fa fa-sign-out"></i> Log out
													</a>
												</li>
											</ul>
										</div>
								</nav>
							</div>