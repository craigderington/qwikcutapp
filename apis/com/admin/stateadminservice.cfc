<cfcomponent displayname="stateadminservice">		
	
	<cffunction name="init" access="public" output="false" returntype="stateadminservice" hint="I create an initialized state admin service data object.">
		<cfreturn this >
	</cffunction>
	
	<cffunction name="getmystate" output="false" returntype="string" access="remote" hint="I get my state name.">
		<cfargument name="stateid" type="numeric" required="yes" default="#session.stateid#">
		<cfset var mystate = "" />
			<cfquery name="getstatename">
					select stateid, statename, stateabbr
					  from dbo.states
					 where stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" /> 
			</cfquery>
			<cfset mystate = getstatename.statename />
		<cfreturn mystate>
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
			
	<cffunction name="getstatedetail" output="false" returntype="query" access="remote" hint="I get the state detail.">
		<cfargument name="stateid" type="numeric" required="yes" default="#url.stateid#">
			<cfset var statedetail = "" />
				<cfquery name="statedetail">
					select stateid, statename, stateabbr
					  from dbo.states
					 where stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" /> 
				</cfquery>
		<cfreturn statedetail>
	</cffunction>
	
</cfcomponent>