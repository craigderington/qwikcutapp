<cfcomponent displayname="teamadminservice">

	<cffunction name="init" access="public" output="false" returntype="teamadminservice" hint="I return an initialized team admin service object.">
		<cfreturn this >
	</cffunction>

	<cffunction name="getteams" access="remote" output="false" hint="I get the list of teams.">
		<cfargument name="stateid" type="numeric" required="no">
		<cfargument name="conferenceid" type="numeric" required="no" default="0">
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
					<cfif structkeyexists( arguments, "stateid" )>
						and s.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
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
			       t.teamlevel, t.teamorgname, c.confname, c.confid, c.conftype, s.stateabbr, tl.teamlevelname,
				   tl.teamlevelcode, tl.teamlevelid, t.homefieldid
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
		<cfargument name="conferenceid" type="numeric" required="yes" default="1">
		<cfset var teamlevels = "" />
		<cfquery name="teamlevels">
			select tl.confid, tl.teamlevelid, tl.teamlevelname, tl.teamlevelcode, tl.teamlevelconftype,
						 c.confname
			  from teamlevels tl inner join conferences c on tl.confid = c.confid
				<cfif structkeyexists( arguments, "conferenceid" )>
					where tl.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
				</cfif>
			  <cfif structkeyexists( form, "teamlevel" )>
				and tl.teamlevelconftype = <cfqueryparam value="#trim( arguments.teamlevel )#" cfsqltype="cf_sql_varchar" />
			  </cfif>
		  order by tl.teamlevelconftype desc, tl.teamlevelid asc
		</cfquery>
		<cfreturn teamlevels>
	</cffunction>

	<cffunction name="getteamlevel" access="remote" output="false" hint="I get the team level details.">
		<cfargument name="id" type="any" required="no" default="#url.id#">
		<cfargument name="conferenceid" type="numeric" required="yes" default="1">
		<cfset var teamlevel = "" />
		<cfquery name="teamlevel">
			select tl.teamlevelid, c2.confname, tl.teamlevelname, tl.teamlevelcode, tl.teamlevelconftype
			  from teamlevels tl, conferences c2
				where tl.confid = c2.confid
			 and tl.teamlevelid = <cfqueryparam value="#trim( arguments.id )#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn teamlevel>
	</cffunction>

	<cffunction name="getteamlevelsforconference" access="remote" output="false" hint="I get the team levels for the conference type.">
		<cfargument name="teamlevelconftype" type="any" required="yes">
		<cfargument name="conferenceid" type="numeric" required="yes">
		<cfset var teamlevels = "" />
		<cfquery name="teamlevels">
			select tl.teamlevelid, c.confname, tl.teamlevelname, tl.teamlevelcode, tl.teamlevelconftype, tl.confid
			  from teamlevels tl, conferences c
			 where tl.confid = c.confid
			   and tl.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
			   and tl.teamlevelconftype = <cfqueryparam value="#arguments.teamlevelconftype#" cfsqltype="cf_sql_varchar" />
		  order by tl.teamlevelid asc
		</cfquery>
		<cfreturn teamlevels>
	</cffunction>

	<cffunction name="getconferenceteams" access="remote" output="false" hint="I get the list of teams for conference admins.">
		<cfargument name="stateid" type="numeric" required="no">
		<cfargument name="conferenceid" type="numeric" required="yes" default="0">
		<cfset var teamlist = "" />
		<cfquery name="conferenceteamlist">
			select distinct(t.teamorgname), count(t.teamid) as totalteams
			 from teams t, conferences c
			where t.confid = c.confid
			  and t.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
			group by t.teamorgname
			order by t.teamorgname asc
		</cfquery>
		<cfreturn conferenceteamlist>
	</cffunction>

	<cffunction name="getteamsbyname" access="remote" output="false" hint="I get the teams by team level.">
		<cfargument name="teamname" type="any" required="yes">
		<cfargument name="conferenceid" type="numeric" required="yes" default="0">
		<cfset var teamslist = "" />
		<cfquery name="teamslist">
			select t.teamid, t.teamname, t.teammascot, t.teamlevelid, tl.teamlevelname
			  from teams t, teamlevels tl
			  where t.teamlevelid = tl.teamlevelid
			    and t.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />
				and t.teamorgname like <cfqueryparam value="#trim( arguments.teamname )#%" cfsqltype="cf_sql_varchar" />
			order by t.teamlevelid, t.teamname
		</cfquery>
		<cfreturn teamslist>
	</cffunction>

	<cffunction name="getteamrecord" access="remote" output="false" hint="I get the team W/L record by game season">
		<cfargument name="id" type="any" required="yes">
		<cfargument name="gameseasonid" type="numeric" required="yes">
		<cfset var teamrecord = "" />
			<cfquery name="teamrecord">
				select teamid, sum(wins) as wins,
					   sum(losses) as losses
				  from teamrecords
				 where teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
				   and gameseasonid = <cfqueryparam value="#arguments.gameseasonid#" cfsqltype="cf_sql_integer" />
			  group by teamid
			</cfquery>
		<cfreturn teamrecord>
	</cffunction>
	
	<cffunction name="getteamcontacts" access="remote" output="false" hint="I get the team contacts">
		<cfargument name="id" type="any" required="yes">		
		<cfset var teamcontacts = "" />
			<cfquery name="teamcontacts">
				select contactid, contactname, contactnumber, contactemail, contactactive, contactactivedate,
				       contactprovider, coachlastname
				  from teamcontacts
				 where teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			  order by contactname asc
			</cfquery>
		<cfreturn teamcontacts>
	</cffunction>
	
	<cffunction name="getteamcontactdetails" access="remote" output="false" hint="I get the team contact details">
		<cfargument name="tcid" type="any" required="yes">		
		<cfset var teamcontactdetails = "" />
			<cfquery name="teamcontactdetails">
				select contactid, teamid, contactname, contactnumber, contactemail, contactactive, contactactivedate,
				       contactprovider, coachlastname
				  from teamcontacts
				 where contactid = <cfqueryparam value="#arguments.tcid#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn teamcontactdetails>
	</cffunction>
	
	<cffunction name="getteamroster" access="remote" output="false" hint="I get the team roster by player name.">
		<cfargument name="id" type="any" required="yes">		
		<cfset var teamroster = "" />
			<cfquery name="teamroster">
				select rosterid, teamid, playername, playernumber, playerposition, playerstatus
				  from teamrosters
				 where teamid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn teamroster>
	</cffunction>
	
	<cffunction name="getplayerdetails" access="remote" output="false" hint="I get the player details from the team roster.">
		<cfargument name="trid" type="any" required="yes">		
		<cfset var playerdetails = "" />
			<cfquery name="playerdetails">
				select rosterid, teamid, playername, playernumber, playerstatus, playerposition
				  from teamrosters
				 where rosterid = <cfqueryparam value="#arguments.trid#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn playerdetails>
	</cffunction>


</cfcomponent>
