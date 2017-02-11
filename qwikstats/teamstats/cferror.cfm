


			<cfsilent>
 
				<!---
					Check to see if the error object exists. Even though
					we have landed on this page, it is possible that
					someone called it directly without throwing an erorr.
					The error object only exists if an error was caught.
				--->
				<cfif StructKeyExists( VARIABLES, "Error" )>
			 
					<!---
						Mail out the error data (and whatever other scopes
						you would like to see at the time of the error). When
						you CFDump out the objects, make them Secure AND
						also be sure to use a TOP attribute when appropriate
						so that the CFDump doesn't recurse forever.
					--->
					<cfmail
						to="craig.derington@outlook.com"
						from="cderington@gmail.com"
						subject="Web Site Error"
						type="html">
			 
						<p>
							An error occurred at
							#DateFormat( Now(), "mmm d, yyyy" )# at
							#TimeFormat( Now(), "hh:mm TT" )#
						</p>
			 
						<h3>
							Error
						</h3>
			 
						<cfdump
							var="#MakeStructSecure( VARIABLES.Error )#"
							label="Error object."
							/>
			 
						<h3>
							CGI
						</h3>
			 
						<cfdump
							var="#MakeStructSecure( CGI )#"
							label="CGI object"
							/>
			 
						<h3>
							REQUEST
						</h3>
			 
						<cfdump
							var="#MakeStructSecure( REQUEST )#"
							label="REQUEST object"
							top="5"
							/>
			 
						<h3>
							FORM
						</h3>
			 
						<cfdump
							var="#MakeStructSecure( FORM )#"
							label="FORM object"
							top="5"
							/>
			 
						<h3>
							URL
						</h3>
			 
						<cfdump
							var="#MakeStructSecure( URL )#"
							label="URL object"
							top="5"
							/>
			 
						<h3>
							SESSION
						</h3>
			 
						<cfdump
							var="#MakeStructSecure( SESSION )#"
							label="SESSION object"
							top="5"
							/>
			 
					</cfmail>
			 
				</cfif>			 
			 
				<!---
					When setting the header information, be sure to put
					it in a CFTry / CFCatch. We can only send header
					information if the site has NOT already been flushed
					to the browser. Also set a flag so that we know if
					information has been committed.
				--->
				<cfset REQUEST.RequestCommitted = false />
			 
				<cftry>
					<!--- Set the status code to internal server error. --->
					<cfheader
						statuscode="500"
						statustext="Internal Server Error"
						/>
			 
					<!--- Set the content type. --->
					<cfcontent
						type="text/html"
						reset="true"
						/>
			 
					<!--- Catch any errors. --->
					<cfcatch>
			 
						<!---
							There was an error so flag the request as
							already being committed.
						--->
						<cfset REQUEST.RequestCommitted = true />
			 
					</cfcatch>
				</cftry>
			 
			</cfsilent>
			 
			<!---
				Check to see if the request has been committed. If it
				has, then it means that content has already been committed
				to the browser. In that case, we are gonna want to refresh
				the screen, unless we came from a refresh, in which case
				just let the page run.
			--->
			
			<cfif (
				StructKeyExists( VARIABLES, "Error" ) AND
				REQUEST.RequestCommitted AND
				( NOT StructKeyExists( URL, "norefresh" ) )
				)>
			 
				<script type="text/javascript">
			 
					window.location.href = "cferror.cfm?norefresh=true";
			 
				</script>
			 
				<!--- Exit out of the template. --->
				<cfexit />
			 
			</cfif>
			 
			 
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
					
					</head>
					
			
						<body class="top-navigation">
							<div id="wrapper">
								<div id="page-wrapper" class="gray-bg">
									<div class="row border-bottom white-bg" style="min-height:800px;">
										
										<nav class="navbar navbar-fixed-top" role="navigation">
											<div class="navbar-header">
												<button aria-controls="navbar" aria-expanded="false" data-target="##navbar" data-toggle="collapse" class="navbar-toggle collapsed" type="button">
													<i class="fa fa-reorder"></i>
												</button>
												<a href="##" class="navbar-brand"><i class="fa fa-upload"></i> QwikCut</a>
											</div>
											
											<div class="navbar-collapse collapse" id="navbar">										
												<ul class="nav navbar-nav">
													<li class="active">
														<a aria-expanded="false" role="button" href="#application.root#user.home"> Game Video &amp; Analytics <cfif structkeyexists( url, "event" ) and trim( url.event ) eq "user.home">| Dashboard</cfif></a>
													</li>
												</ul>											
											</div>
										</nav>
										
										<div class="container" style="margin-top:50px;">									
											
											<div class="ibox float-e-margins">
												
												
												<div class="ibox-content">												
													<div class="panel panel-success">
														<div class="panel-heading">
															<i class="fa fa-warning"></i> <strong>Internal Server Error</strong> <span class="wg-collapse-count">500</span>
														</div>
														<div class="panel-body">
															<p>Sorry, but an internal error has occured.</p>
															<p>Please see the Railo4 server log for detailed debugging information.</p>
														</div>
														<div class="panel-footer">
															Powered by Tomcat 7.0.3 <span class="pull-right"><a href="http://tomcat.apache.org">Apache Projects</a></span>
														</div>
													</div>												
												</div>
											</div>
										</div>
									</div>
								</div>
								
								
							<cfinclude template="footer.cfm">