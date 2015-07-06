


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

					<!-- Toastr style -->
					<link href="css/plugins/toastr/toastr.min.css" rel="stylesheet">

					<!-- Gritter -->
					<link href="js/plugins/gritter/jquery.gritter.css" rel="stylesheet">

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
				
				<!--- // used to debug/track cfif and cftoken session variables 
				<cfinclude template="secchk.cfm">
				--->			
				
				<!--- include the top-bar header all users --->
				<cfinclude template="top-bar-nav.cfm">