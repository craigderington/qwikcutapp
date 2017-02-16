


		<!doctype html>
			<html lang="en">			
				<head>
					<cfoutput>
						<title>#application.title#</title>
					</cfoutput>									
									
					<meta charset="utf-8">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<meta name="apple-mobile-web-app-capable" content="yes">
										
					<!-- bootstrap and fa4 -->
					<link href="css/bootstrap.min.css" rel="stylesheet">
					<link href="font-awesome/css/font-awesome.css" rel="stylesheet">
					<link href="css/animate.css" rel="stylesheet">
					<link href="css/style.css" rel="stylesheet">					
					<link href="css/plugins/datapicker/datepicker3.css" rel="stylesheet">
					<link href="css/plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet">
					<link href="css/plugins/clockpicker/clockpicker.css" rel="stylesheet">

					<!--- // make sure that none of our dynamic pages are cached by the users browser --->
					<cfheader name="cache-control" value="no-cache,no-store,must-revalidate" >
					<cfheader name="pragma" value="no-cache" >
					<cfheader name="expires" value="#getHttpTimeString( Now() )#" >
					
					<!--- // shortcut icons // add to homescreen --->
					<link rel="shortcut icon" href="//app.qwikcut.com/favicon.ico?v=2" type="image/x-icon" />
					<link rel="icon" href="//app.qwikcut.com/favicon.ico?v=2" type="image/x-icon">
					<link rel="apple-touch-icon" href="//app.qwikcut.com/img/QCIcon.png"/>
					
					
					<!--- // also ensure that non-dynamic pages are not cached by the users browser --->
					<META HTTP-EQUIV="expires" CONTENT="-1">
					<META HTTP-EQUIV="pragma" CONTENT="no-cache">
					<META HTTP-EQUIV="cache-control" CONTENT="no-cache,no-store,must-revalidate">
				
				</head>
				
				<body class="top-navigation">				
					<div id="wrapper">					
						<div id="page-wrapper" class="gray-bg">
							<div class="row border-bottom white-bg">
								<cfinclude template="sub-nav.cfm">
							</div>