<cfcomponent displayname="userservice">
	<cffunction name="init" access="public" output="false" returntype="userservice" hint="I initialize the user data object.">
		<cfreturn this >
	</cffunction>
	<cffunction name="getuserprofile" access="public" returntype="query" output="false" hint="I get the user profile.">
		<cfargument name="id" type="numeric" required="yes" default="#session.userid#">
		<cfset var userprofile ="" />
		<cfquery name="userprofile">
			select u.firstname, u.lastname, u.username, u.password, u.lastlogindate, u.lastloginip, u.email, u.userrole
			  from users u
			 where u.userid =<cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn userprofile>
	</cffunction>
	<cffunction name="getusersettings" access="public" output="false" returntype="query" hint="I get the user settings.">
		<cfargument name="id" type="any" required="yes" default="#session.userid#">
			<cfset var usersettings = "" />
			<cfquery name="usersettings">
				select us.usersettingid, us.userid, us.mailserver, us.mailserverport, us.mailserverusername, us.mailserverpassword,
				       us.mailserveractive, us.lastconnectdate, us.lastconnectstatus, us.useralertpref, us.usertextmsgaddress,
					   us.userprofileimagepath
				  from usersettings us, users u
				 where us.userid = u.userid
				   and us.userid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" /> 
			</cfquery>
		<cfreturn usersettings>
	</cffunction>
</cfcomponent>