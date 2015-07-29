<cfcomponent displayname="registrationservice">		
	
	<cffunction name="init" access="public" output="false" returntype="registrationservice" hint="I create an initialized shooter registration service data object.">
		<cfreturn this >
	</cffunction>
	
	<cffunction name="getshooterbyregcode" access="public" output="false" returntype="query" hint="I get the user registration details by code.">
		<cfargument name="regcode" type="any" required="yes">
		<cfargument name="email" type="any" required="yes">		
		<cfset var shooter = ""/>
		<cfquery name="shooter">
			select s.shooterid, s.shooterfirstname, s.shooterlastname, u.userid, u.username, u.regcode, u.regcomplete, u.regcompletedate
			  from shooters s, users u
			 where s.userid = u.userid
		 	   and u.regcode = <cfqueryparam value="#arguments.regcode#" cfsqltype="cf_sql_varchar" maxlength="35" />
			   and u.email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		<cfreturn shooter>
	</cffunction>
		
	<cffunction name="getshooterbyid" access="public" output="false" returntype="query" hint="I get the user registration details by ID.">
		<cfargument name="shooterid" type="numeric" required="yes">
		<cfargument name="userid" type="numeric" required="yes">		
		<cfset var shooter = ""/>
		<cfquery name="shooter">
			select s.shooterid, s.shooterfirstname, s.shooterlastname, u.userid, u.username, u.password, u.username, 
				   s.shooteraddress1, s.shooteraddress2, s.shootercity, s.shooterstateid, s.shooterzip, s.shooteremail,
				   s.shootercellphone, s.shootercellprovider, s.shooteralertpref, u.regcomplete, u.regcompletedate
			  from shooters s, users u
			 where s.userid = u.userid
		 	   and u.userid = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" />
			   and s.shooterid = <cfqueryparam value="#arguments.shooterid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn shooter>
	</cffunction>
	
	<cffunction name="getstates" output="false" returntype="query" access="remote" hint="I get the list of states">
		<cfset var statelist = "" />
			<cfquery name="statelist">
					select stateid, statename, stateabbr
					  from dbo.states
					order by stateid asc
			</cfquery>
		<cfreturn statelist>
	</cffunction>
	
	<cffunction name="getshooterdates" output="false" returntype="query" access="remote" hint="I get the shooter block out dates.">
		<cfargument name="shooterid" type="numeric" required="yes" default="#session.shooterid#">
		<cfset var shooterdates = "" />
			<cfquery name="shooterdates">
				 select sbd.shooterblockid, sbd.shooterid, sbd.fromdate, sbd.todate, sbd.blockreason
				   from dbo.shooterblockoutdates sbd
				  where sbd.shooterid = <cfqueryparam value="#arguments.shooterid#" cfsqltype="cf_sql_integer" />
				 order by sbd.fromdate, sbd.shooterblockid asc
			</cfquery>
		<cfreturn shooterdates>
	</cffunction>
</cfcomponent>