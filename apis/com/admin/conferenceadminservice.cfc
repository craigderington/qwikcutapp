<cfcomponent displayname="conferenceadminservice">		
	
	<cffunction name="init" access="public" output="false" returntype="conferenceadminservice" hint="I create an initialized conference admin service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getconferences" output="false" returntype="query" access="remote" hint="I get the list of conferences.">
		<cfargument name="stateid" type="numeric" required="no">
		<cfset var conferencelist = "" />
			<cfquery name="conferencelist">
					select c.stateid, c.confid, c.confname, c.conftype, c.confactive, 
					       s.statename, s.stateabbr					       
					  from dbo.conferences c, dbo.states s
					 where c.stateid = s.stateid
						   <cfif structkeyexists( form, "filterresults" )>
								<cfif structkeyexists( form, "state" ) and trim( form.state ) neq "">
									and s.stateid = <cfqueryparam value="#form.state#" cfsqltype="cf_sql_integer" />
								</cfif>
								<cfif structkeyexists( form, "conferencetype" ) and trim( form.conferencetype ) neq "">
									and c.conftype = <cfqueryparam value="#form.conferencetype#" cfsqltype="cf_sql_varchar" />
								</cfif>
						   </cfif>
						   <cfif structkeyexists( arguments, "stateid" )>
								and c.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
						   </cfif>
				  order by c.stateid, c.confname asc
			</cfquery>
		<cfreturn conferencelist>
	</cffunction>
			
	<cffunction name="getadminconferencename" output="false" returntype="query" access="remote" hint="I get the conference name for the conference admin.">
		<cfargument name="id" type="numeric" required="yes">
			<cfset var conference = "" />
				<cfquery name="conference">
					 select c.confname         
					   from dbo.conferences c
					  where c.confid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" /> 
				</cfquery>
		<cfreturn conference>
	</cffunction>
	
	<cffunction name="getconferencedetail" output="false" returntype="query" access="remote" hint="I get the conference detail for the selected.">
		<cfargument name="id" type="numeric" required="yes">
			<cfset var conferencedetail = "" />
				<cfquery name="conferencedetail">
					 select c.confid, c.confname       
					   from dbo.conferences c
					  where c.confid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" /> 
				</cfquery>
		<cfreturn conferencedetail>
	</cffunction>
			
</cfcomponent>