<cfcomponent	
	displayname="Application"
	output="true"
	hint="Handle the application.">	
	
	<!--- default application settings --->
	<cfscript>
       
	   // define application name
	   this.name = hash( getcurrenttemplatepath() );
	   
	   // define application session variables
	   this.sessiontype = "j2ee";
	   
	   // define default datasource
	   this.defaultdatasource = "qwikcutapp";
	   
	   // define application and client timeout
	   this.applicationtimeout = createtimespan(1,0,0,0);
       
	   // define client management settings
	   this.clientmanagement = "true";       
       
	   // enable session management
	   this.sessionmanagement = "true";
       
	   // define session timeout
	   this.sessiontimeout = createtimespan(0,1,30,0);
       
	   // define client login storage
	   this.loginstorage = "session";
	   
	   // define client cookie settings
	   this.setclientcookies = "false";       
       
	   // enable cross site scripting protection
	   this.scriptprotect = "all";
	   
	   // converts FORM fields of the same name to an array
	   this.sameFormFieldsAsArray = "true";
	   
	   // converts URL fields of the samme name to an array
	   this.sameURLFieldsAsArray = "true";
	   
   </cfscript>
	
 
	<!--- Define the page request properties. --->
	<cfsetting
		requesttimeout="120"
		showdebugoutput="true"
		enablecfoutputonly="false"
		/>
 
 
	<cffunction
		name="OnApplicationStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires when the application is first created.">	
		
		 <cfscript>
			//set your app vars for the application			
			application.title = "Qwikcut Game Day Video Application";
			application.developer = "Craig Derington, Inc.";
			application.bootver = "v 3.3.2";
			application.softver = "v 1.0.0 Alpha";
			application.root = "index.cfm?event=";
			application.sessions = 0;
		</cfscript>
		
		<cftry>
            <!--- Test whether the DB is accessible by selecting some data. --->
            <cfquery name="testdb" maxrows="2">
                select count(userid) 
                  from dbo.users
            </cfquery>
            <!--- If we get a database error, report an error to the user, log the error information, and do not start the application. --->
            <cfcatch type="database">
                <cflog file="#this.name#" type="error" 
                     text="DB not available. message: #cfcatch.message# Detail: #cfcatch.detail# Native Error: #cfcatch.NativeErrorCode#" >
            
                <cfthrow message="This application encountered an error connecting to the database. Please contact support." />      
            
                <cfreturn false>
            </cfcatch>
        </cftry>
       
       <cflog file="#this.name#" type="Information" text="Application #this.name# Started">
 
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>
 
 
	<cffunction
		name="OnSessionStart"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is first created.">
			
			
			<!--- Store date the session was created. --->
			<cfset session.dateInitialized = now() />
			
			
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
 
 
	<cffunction
		name="OnRequestStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires at first part of page processing.">
 
		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>
			
			<!--- // if the URL query string contains a reinit param, restart all application vars --->
			<cfif structkeyexists( url, "reinit" ) and url.reinit is "true" >
				<cfset onApplicationStart() />
			</cfif>
			
			<!--- // for direct web service api calls 
			<cfif trim( right( arguments.TargetPage, 4 )) eq ".cfc">
				<cfset structdelete( this, "OnRequestStart" ) />				
				<cfset structdelete( variables, "OnRequestStart" ) />				
			</cfif>		
			--->
			
			<!--- // perform login function --->
			<cflogin>
				<cfif NOT IsDefined("cflogin")>
					<cfinclude template="login.cfm">
					<cfabort>
				<cfelse>
					<cfif cflogin.name IS "" OR cflogin.password IS "">
						<cfset REQUEST.badlogin = true />
						<cfinclude template="login.cfm">
						<cfabort>
					<cfelse>						
						<cfquery name="loginquery">
							SELECT u.userid, u.username, u.password, u.confid, u.firstname, u.lastname,
								   u.userrole, u.useracl
							  FROM dbo.users u
							 WHERE u.username = <cfqueryparam value="#cflogin.name#" cfsqltype="cf_sql_varchar" />
							   AND u.password = <cfqueryparam value="#hash( cflogin.password, "SHA-384", "UTF-8" )#" cfsqltype="cf_sql_varchar" />							   
						</cfquery>
						<cfif loginquery.userid NEQ "">
							<cfloginuser 
								name = "#cflogin.name#" 
								password = "#hash( cflogin.password, "SHA-384", "UTF-8" )#" 
								roles="#loginquery.userrole#">
								
								<!--- Start a few session vars we will require for our queries --->								
								<cfset session.userid = #loginquery.userid# />								
								<cfset session.username = "#loginquery.firstname# #loginquery.lastname#" />							
								
								<!--- Log this users activity to the database --->
								<cfquery name="logUser">
									update dbo.users
									   set lastlogindate = <cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />,
									       lastloginip = <cfqueryparam value="#cgi.remote_addr#" cfsqltype="cf_sql_varchar" />
									 where userid = <cfqueryparam value="#loginquery.userid#" cfsqltype="cf_sql_integer" />									   
						        </cfquery>
							   
							    <!---Log this users activity to the login history table 
								<cfquery datasource="#application.dsn#" name="logUser">
									   insert into loginhistory(userid, logindate, loginip, username)
											 values(
													<cfqueryparam value="#session.userid#" cfsqltype="cf_sql_integer" />, 
													<cfqueryparam value="#CreateODBCDateTime(Now())#" cfsqltype="cf_sql_timestamp" />, 
													<cfqueryparam value="#cgi.remote_addr#" cfsqltype="cf_sql_varchar" />, 
													<cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar" />												
													);
									 									   
						        </cfquery>
							    --->						   		   
						<cfelse>
							<cfset REQUEST.badlogin = true />    
							<cfinclude template="login.cfm">
							<cfabort>
						</cfif>
						
					</cfif>    
				</cfif>
			</cflogin>			
			
			<cfif GetAuthUser() NEQ "">
				<cfoutput>
					 <form action="index.cfm" method="Post">
						<input type="submit" Name="Logout" value="Logout">
					</form>
				</cfoutput>
			</cfif>		
		
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>
 
	
	<cffunction
		name="OnRequest"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after pre page processing is complete.">
 
		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>
 
		<!--- Include the requested page. --->
		<cfinclude template="#ARGUMENTS.TargetPage#" />
 
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
	
 
	<cffunction
		name="OnRequestEnd"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after the page processing is complete."> 
		
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
 
 
	<cffunction
		name="OnSessionEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is terminated.">
 
		<!--- Define arguments. --->
		<cfargument
			name="sessionScope"
			type="struct"
			required="true"
			/>			
			
		<cfargument
			name="applicationScope"
			type="struct"
			required="false"
			default="#StructNew()#"
			/>
			
		<!--- output the cfid and cftoken values to the log. --->
		<cffile
			action="append"
			file="#getDirectoryFromPath( getCurrentTemplatePath() )#log.cfm"
			output="ENDED: #arguments.sessionScope.cfid#<br />"
			/>			
			
				
		<!--- Return out. --->
		<cfreturn />
	</cffunction>	
 
	<cffunction
		name="OnApplicationEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the application is terminated.">
 
		<!--- Define arguments. --->
		<cfargument
			name="ApplicationScope"
			type="struct"
			required="false"
			default="#StructNew()#">	
 
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
 
	
	<cffunction
		name="OnError"
		access="public"
		returntype="void"
		output="true"
		hint="Fires when an exception occures that is not caught by a try/catch.">
 
		<!--- Define arguments. --->
		<cfargument
			name="Exception"
			type="any"
			required="true"			
			/>
 
		<cfargument
			name="EventName"
			type="string"
			required="false"
			default=""
			/>			
			
			<!--- log the error --->
			<cfif cgi.server_name eq "localhost" or cgi.server_name eq "127.0.0.1">
				<!--- // for development only // 
				     // write error to dev server logs //
					 // handle the error // --->
				<cfinclude template="cferror.cfm">
					<cflog file="#this.name#" type="error" text="Event Name: #arguments.eventname#" >
					<cflog file="#this.name#" type="error" text="Message: #arguments.exception.message#">
					<cflog file="#this.name#" type="error" text="Root Cause Message: #arguments.exception.rootcause.message#">			
			<cfelse>
				<cfif len( arguments.eventname )>
					<cfdump var="#arguments.eventname#" label="Error Event Name"/>
				</cfif>
				<cfdump var="#arguments.exception#" label="Error Exception" />			
			</cfif>		
		
		<cfreturn />
	</cffunction> <!--- // return out --->
</cfcomponent>