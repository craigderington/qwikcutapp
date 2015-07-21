<cfcomponent displayname="teamadminservice">
	
	<cffunction name="init" access="public" output="false" returntype="teamadminservice" hint="I return an initialized team admin service object.">
		<cfreturn this >
	</cffunction>

	<cffunction name="getteams" access="remote" output="false" hint="I get the list of teams.">
		<cfargument name="conferenceid" type="numeric" required="no" default="1">
		<cfset var teamlist = "" />
		<cfquery name="teamlist">
			select t.teamid, t.teamname, t.teamcity, t.teamcolors, t.teammascot, t.teamactive, t.teamrecord, 
			       t.teamlevel, t.teamorgname, c.confname, s.stateabbr
			  from teams t, conferences c, states s
			 where t.confid = c.confid
			   and c.stateid = s.stateid
				   <cfif structkeyexists( form, "filterresults" )>
						<cfif structkeyexists( form, "conferenceid" ) and form.conferenceid neq "">
							and t.confid = <cfqueryparam value="#form.conferenceid#" cfsqltype="cf_sql_integer" />
						</cfif>
						<cfif structkeyexists( form, "teamname" ) and form.teamname neq "">
							and t.teamname LIKE <cfqueryparam value="%#trim( form.teamname )#%" cfsqltype="cf_sql_varchar" />
						</cfif>
						<cfif structkeyexists( form, "teamcity" ) and form.teamcity neq "">
							and t.teamcity LIKE <cfqueryparam value="#trim( form.teamcity )#%" cfsqltype="cf_sql_varchar" />
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
			       t.teamlevel, t.teamorgname, c.confname, c.confid, c.conftype
			  from teams t, conferences c
			 where t.confid = c.confid
			   and t.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn teamdetail>
	</cffunction>

</cfcomponent>