<cfcomponent displayname="usershooterservice">
	<cffunction name="init" access="public" returntype="usershooterservice" output="false" hint="I create an initialized user shooter service object.">
		<cfreturn this>
	</cffunction>
	<cffunction name="getshooterassignments">
		<cfargument name="userid" type="numeric" required="yes">
		<cfset shooterassignments = "" />
			<cfquery name="shooterassignments">
				select sa.shooterassignmentid, sa.vsid, sa.shooterassignstatus, sa.shooterassignlastupdated,
				       sa.shooteracceptedassignment, shooterassigndate, sa.shooteracceptdate, sa.shooterid,
					   v.hometeam, v.awayteam, v.gamedate, v.gametime, f.fieldname
				  from shooterassignments sa, shooters s, users u, versus v, fields f
				 where sa.shooterid = s.shooterid
				   and s.userid = u.userid
				   and sa.vsid = v.vsid
				   and v.fieldid = f.fieldid
				   and s.userid = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" />
				   and sa.shooterassignstatus = <cfqueryparam value="Assigned" cfsqltype="cf_sql_varchar" />
				   and sa.shooteracceptedassignment = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
			  order by sa.shooterassignmentid desc
			</cfquery>
		<cfreturn shooterassignments>
	</cffunction>
</cfcomponent>