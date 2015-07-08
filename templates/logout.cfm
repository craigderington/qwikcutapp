


		<!--- pass any url vars we will need to direct back to the login page to provide status updates --->
		<cfparam name="rdurl" default="">
		
		<cfif structkeyexists( url, "rdurl" )>
			<cfset rdurl = #url.rdurl# />
		</cfif>
		
		<!--- // kill the user ID --->
		<cfif structkeyexists( session, "userid" )>
			<cfparam name="tempU" default="">
			<cfset tempU = structdelete( session, "userid" ) />
		</cfif>		
		
		<!--- // kill the jsessionid --->
		<cfif structkeyexists( session, "jsessionid" )>
			<cfparam name="tempJ" default="">
			<cfset tempJ = structdelete( session, "jsessionid" ) />
		</cfif>		
			
		<!--- // log out the user --->
		<cflogout>
		
		<!--- // redirect to index page --->		
		<cfif structkeyexists( url, "rdurl" ) and url.rdurl is not "">
			<cflocation url="#application.root#user.home&#url.rdurl#=1" addtoken="no">
		<cfelse>
			<cflocation url="#application.root#user.home&logout=1" addtoken="no">
		</cfif>