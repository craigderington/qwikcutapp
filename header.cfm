


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
				
				<body class="fixed-nav">
					<div id="wrapper">
						<div id="page-wrapper" class="gray-bg">
							<div class="row border-bottom white-bg">
								<cfinclude template="sub-nav.cfm">
							</div>