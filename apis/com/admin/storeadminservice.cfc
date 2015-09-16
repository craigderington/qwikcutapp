<cfcomponent displayname="storeadminservice">
	<cffunction name="init" access="public" returntype="storeadminservice" output="false" hint="I initialize the store admin service object.">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getstoredashboard" access="public" returntype="query" output="false" hint="I get the store admin dashboard order count.">
		<cfset var storedashboard = "" />
		<cfquery name="storedashboard">
			select count(*) as totalorders
			  from dbo.orders
		</cfquery>
		<cfreturn storedashboard>
	</cffunction>

</cfcomponent>