<cfcomponent displayname="useradminservice">		
	
	<cffunction name="init" access="public" output="false" returntype="useradminservice" hint="I create an initialized user admin service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getusers" output="false" returntype="query" access="remote" hint="I get the list of users">
		<cfargument name="stateid" type="numeric" required="yes" default="#session.stateid#">
		<cfargument name="userrole" type="string" required="yes" default="admin">
		<cfset var userlist = "" />
			<cfquery name="userlist">
					select users.userid, username, firstname, lastname, password, confid, lastloginip, lastlogindate, email, 
					       userrole, useracl, useractive, usersettings.userprofileimagepath
				      from dbo.users, dbo.usersettings
					 where dbo.users.userid = dbo.usersettings.userid						
					   and userrole = <cfqueryparam value="#arguments.userrole#" cfsqltype="cf_sql_varchar" />						
					   and stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />						
					   and users.useractive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
				  order by lastname, firstname asc
			</cfquery>
		<cfreturn userlist>
	</cffunction>
			
	<cffunction name="getuserdetail" output="false" returntype="query" access="remote" hint="I get the user detail.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
			<cfset var userdetail = "" />
				<cfquery name="userdetail">
					select userid, confid, username, firstname, lastname, password, confid, lastloginip, 
					       lastlogindate, email, userrole, useracl, teamname
					  from dbo.users
					 where userid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" /> 
				</cfquery>
		<cfreturn userdetail>
	</cffunction>			
			
</cfcomponent>