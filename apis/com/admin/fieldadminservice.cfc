<cfcomponent displayname="fieldadminservice">
	
	<cffunction name="init" access="public" output="false" returntype="fieldadminservice" hint="I return an initialized field admin service object.">
		<cfreturn this >
	</cffunction>

	<cffunction name="getfields" access="remote" output="false" hint="I get the list of fields.">
		<cfargument name="conferenceid" type="numeric" required="yes" default="1">
		<cfset var fieldlist = "" />
		<cfquery name="fieldlist">
			select f.fieldid, f.confid, f.fieldname, f.fieldaddress1, f.fieldaddress2, f.fieldcity, f.fieldstate, f.fieldzip,
				   f.fieldcontactnumber, f.fieldcontactname, f.fieldcontacttitle, f.fieldactive, 
				   c.conftype, c.confname, s.statename
			  from fields f, conferences c, states s
			 where f.confid = c.confid
			   and c.stateid = s.stateid
			   <!---and f.confid = <cfqueryparam value="#arguments.conferenceid#" cfsqltype="cf_sql_integer" />--->
			   <cfif structkeyexists( form, "filterresults" )>
					<cfif structkeyexists( form, "state" )>
						and s.stateid = <cfqueryparam value="#form.state#" cfsqltype="cf_sql_integer" />
					</cfif>
			   </cfif>
			 order by f.fieldname asc
		</cfquery>
		<cfreturn fieldlist>
	</cffunction>
	
	<cffunction name="getfielddetail" access="remote" output="false" hint="I get the field details.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
		<cfset var fielddetail = "" />
		<cfquery name="fielddetail">
			select f.fieldid, f.confid, f.fieldname, f.fieldaddress1, f.fieldaddress2, f.fieldcity, f.fieldstate, f.fieldzip,
				   f.fieldcontactnumber, f.fieldcontactname, f.fieldcontacttitle, f.fieldactive, 
				   c.conftype, c.confname, c.stateid, s.statename
			  from fields f, conferences c, states s
			 where f.confid = c.confid
			   and c.stateid = s.stateid
			   and f.fieldid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn fielddetail>
	</cffunction>

</cfcomponent>