<cfcomponent displayname="teamadminservice">
	
	<cffunction name="init" access="public" output="false" returntype="teamadminservice" hint="I return an initialized team admin service object.">
		<cfreturn this >
	</cffunction>

	<cffunction name="getteams" access="remote" output="false" hint="I get the list of teams.">
		<cfargument name="conferenceid" type="numeric" required="no" default="1">
		<cfset var teamlist = "" />
		<cfquery name="teamlist">
			select t.teamid, t.teamname, t.teamcity, t.teamcolors, t.teammascot, t.teamactive, t.teamrecord, 
			       t.teamlevel, t.teamorgname, c.conftype, c.confname, s.stateabbr, tl.teamlevelname, tl.teamlevelcode
			  from teams t, conferences c, states s, teamlevels tl
			 where t.confid = c.confid
			   and c.stateid = s.stateid
			   and t.teamlevelid = tl.teamlevelid
				    <cfif structkeyexists( form, "filterresults" )>
						<!---
						<cfif structkeyexists( form, "conferenceid" ) and form.conferenceid neq "">
							and t.confid = <cfqueryparam value="#form.conferenceid#" cfsqltype="cf_sql_integer" />												
						</cfif>
						<cfif structkeyexists( form, "teamlevelid" ) and form.teamlevelid neq "">
							and tl.teamlevelid = <cfqueryparam value="#form.teamlevelid#" cfsqltype="cf_sql_integer" />						
						</cfif>
						--->
						<cfif structkeyexists( form, "teamname" ) and form.teamname neq "">
							and t.teamname LIKE <cfqueryparam value="%#trim( form.teamname )#%" cfsqltype="cf_sql_varchar" />
						</cfif>
						<cfif structkeyexists( form, "teamcity" ) and form.teamcity neq "">
							and t.teamcity LIKE <cfqueryparam value="%#trim( form.teamcity )#%" cfsqltype="cf_sql_varchar" />
						</cfif>			
				    </cfif>
					<cfif structkeyexists( session, "conferenceid" )>					
						and t.confid = <cfqueryparam value="#session.conferenceid#" cfsqltype="cf_sql_integer" />
					</cfif>
					<cfif structkeyexists( session, "teamlevelid" )>
						and tl.teamlevelid = <cfqueryparam value="#session.teamlevelid#" cfsqltype="cf_sql_integer" />
					</cfif>
			 order by c.confid, t.teamname, tl.teamlevelid asc
		</cfquery>
		<cfreturn teamlist>
	</cffunction>
	
	<cffunction name="getteamdetail" access="remote" output="false" hint="I get the team details.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
		<cfset var teamdetail = "" />
		<cfquery name="teamdetail">
			select t.teamid, t.teamname, t.teamcity, t.teamcolors, t.teammascot, t.teamactive, t.teamrecord, 
			       t.teamlevel, t.teamorgname, c.confname, c.confid, c.conftype, s.stateabbr
			  from teams t, conferences c, states s, teamlevels tl
			 where t.confid = c.confid
			   and c.stateid = s.stateid
			   and t.teamlevelid = tl.teamlevelid
			   and t.teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn teamdetail>
	</cffunction>	
	
	<cffunction name="getteamlevels" access="remote" output="false" hint="I get the team levels.">
		<cfargument name="teamlevel" type="any" required="no">
		<cfset var teamlevels = "" />
		<cfquery name="teamlevels">
			select tl.teamlevelid, tl.teamlevelname, tl.teamlevelcode, tl.teamlevelconftype
			  from teamlevels tl
			  <cfif structkeyexists( form, "teamlevel" )>
				where tl.teamlevelconftype = <cfqueryparam value="#trim( arguments.teamlevel )#" cfsqltype="cf_sql_varchar" />
			  </cfif>
		  order by tl.teamlevelconftype desc, tl.teamlevelid asc
		</cfquery>
		<cfreturn teamlevels>
	</cffunction>
	
	<cffunction name="getteamlevel" access="remote" output="false" hint="I get the team level details.">
		<cfargument name="id" type="any" required="no" default="#url.id#">
		<cfset var teamlevel = "" />
		<cfquery name="teamlevel">
			select tl.teamlevelid, tl.teamlevelname, tl.teamlevelcode, tl.teamlevelconftype
			  from teamlevels tl
			 where tl.teamlevelid = <cfqueryparam value="#trim( arguments.id )#" cfsqltype="cf_sql_integer" />			  
		</cfquery>
		<cfreturn teamlevel>
	</cffunction>
	
	<cffunction name="getteamlevelsforconference" access="remote" output="false" hint="I get the team levels for the conference type.">
		<cfargument name="teamlevelconftype" type="any" required="yes" default="#trim( form.teamlevelconftype )#">
		<cfset var teamlevels = "" />
		<cfquery name="teamlevels">
			select tl.teamlevelid, tl.teamlevelname, tl.teamlevelcode, tl.teamlevelconftype
			  from teamlevels tl
			 where tl.teamlevelconftype = <cfqueryparam value="#arguments.teamlevelconftype#" cfsqltype="cf_sql_varchar" />
		  order by tl.teamlevelid asc
		</cfquery>
		<cfreturn teamlevels>
	</cffunction>
	

</cfcomponent>