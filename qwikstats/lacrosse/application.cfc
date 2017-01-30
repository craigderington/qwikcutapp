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
			application.title = "QwikStats:  Video and Analytics";
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
			
				
		
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>
 
	
	
 
 
		
 
	
 
	
</cfcomponent>