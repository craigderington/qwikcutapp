<cfcomponent displayname="teamadminservice">
	
	<cffunction name="init" access="public" output="false" returntype="teamadminservice" hint="I return an initialized team admin service object.">
		<cfreturn this >
	</cffunction>

	<cffunction name="getteams" access="remote" output="false" hint="I get the list of teams.">
		<cfargument name="conferenceid" type="numeric" required="no" default="1">
		<cfset var teamlist = "" />
		<cfquery name="teamlist">
			select t.teamid, t.teamname, t.teamcity, t.teamcolors, t.teammascot, t.teamactive, t.teamrecord, 
			       t.teamlevel, t.teamorgname, c.confname
			  from teams t, conferences c
			 where t.confid = c.confid			  
				   <cfif structkeyexists( form, "filterresults" )>
						<cfif structkeyexists( form, "conferenceid" )>
							and t.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
						</cfif>
				   </cfif>
			 order by c.confid, t.teamname asc
		</cfquery>
		<cfreturn teamlist>
	</cffunction>
	
	<cffunction name="getteamdetail" access="remote" output="false" hint="I get the team details.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
		<cfset var teamdetail = "" />
		<cfquery name="teamdetail">
			select t.teamid, t.teamname, t.teamcity, t.teamcolors, t.teammascot, t.teamactive, t.teamrecord, 
			       t.teamlevel, t.teamorgname, c.confname
			  from teams t, conferences c
			 where t.confid = c.confid
			   and t.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn teamdetail>
	</cffunction>

</cfcomponent>