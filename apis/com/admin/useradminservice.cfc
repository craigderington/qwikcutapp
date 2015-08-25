<cfcomponent displayname="useradminservice">		
	
	<cffunction name="init" access="public" output="false" returntype="useradminservice" hint="I create an initialized user admin service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getusers" output="false" returntype="query" access="remote" hint="I get the list of users">
		<cfargument name="stateid" type="numeric" required="yes" default="#session.stateid#">
		<cfset var userlist = "" />
			<cfquery name="userlist">
					select users.userid, username, firstname, lastname, password, confid, lastloginip, lastlogindate, email, 
					       userrole, useracl, usersettings.userprofileimagepath
				      from dbo.users, dbo.usersettings
					 where dbo.users.userid = dbo.usersettings.userid 
				    <cfif not structkeyexists( form, "filterresults" )>
						and userrole = <cfqueryparam value="admin" cfsqltype="cf_sql_varchar" />   
				    <cfelse>
						<cfif structkeyexists( form, "usertype" ) and trim( form.usertype ) neq "">
						and userrole = <cfqueryparam value="#trim( form.usertype )#" cfsqltype="cf_sql_varchar" />
						</cfif>						
					</cfif>
					<cfif structkeyexists( arguments, "stateid" )>
						and stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
					</cfif>
				  order by lastname, firstname asc
			</cfquery>
		<cfreturn userlist>
	</cffunction>
			
	<cffunction name="getuserdetail" output="false" returntype="query" access="remote" hint="I get the user detail.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
			<cfset var userdetail = "" />
				<cfquery name="userdetail">
					select userid, username, firstname, lastname, password, confid, lastloginip, lastlogindate, email, userrole, useracl
					  from dbo.users
					 where userid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" /> 
				</cfquery>
		<cfreturn userdetail>
	</cffunction>			
			
</cfcomponent>