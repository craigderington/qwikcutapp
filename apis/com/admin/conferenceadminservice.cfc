<cfcomponent displayname="conferenceadminservice">		
	
	<cffunction name="init" access="public" output="false" returntype="conferenceadminservice" hint="I create an initialized conference admin service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getconferences" output="false" returntype="query" access="remote" hint="I get the list of conferences.">
		<cfset var conferencelist = "" />
			<cfquery name="conferencelist">
					select c.stateid, c.confid, c.confname, c.conftype, c.confactive, 
					       s.statename, s.stateabbr					       
					  from dbo.conferences c, dbo.states s
					 where c.stateid = s.stateid
				  order by c.stateid, c.confname asc
			</cfquery>
		<cfreturn conferencelist>
	</cffunction>
			
	<cffunction name="getconferencedetail" output="false" returntype="query" access="remote" hint="I get the conference detail.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
			<cfset var conferencedetail = "" />
				<cfquery name="conferencedetail">
					 select c.stateid, c.confid, c.confname, c.conftype, c.confactive, 
							s.statename, s.stateabbr            
					   from dbo.conferences c, dbo.states s
					  where c.stateid = s.stateid
					    and c.confid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" /> 
				</cfquery>
		<cfreturn conferencedetail>
	</cffunction>			
			
</cfcomponent>