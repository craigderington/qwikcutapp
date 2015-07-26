<cfcomponent displayname="shooteradminservice">

	<cffunction name="init" access="public" output="false" returntype="shooteradminservice" hint="I create an initialized shooter admin service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getshooters" output="false" returntype="query" access="remote" hint="I get the list of shooters.">
		<cfset var shooterlist = "" />
			<cfquery name="shooterlist">
					select sh.shooterid, sh.userid, sh.shooterfirstname, sh.shooterlastname, sh.shooteraddress1, sh.shooteraddress2, sh.shootercity, sh.shooterstateid, 
					       s.stateabbr, sh.shooterzip, sh.shooteremail, sh.shooterisactive, shootercellphone, shootercellprovider, shooteralertpref
					  from dbo.shooters sh, dbo.states s
					 where sh.shooterstateid = s.stateid
					   and sh.shooterisactive = <cfqueryparam value="1" cfsqltype="cf_sql_integer" />
				  order by sh.shooterlastname asc
			</cfquery>
		<cfreturn shooterlist>
	</cffunction>

</cfcomponent>