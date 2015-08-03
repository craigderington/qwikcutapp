<cfcomponent displayname="fieldadminservice">
	
	<cffunction name="init" access="public" output="false" returntype="fieldadminservice" hint="I return an initialized field admin service object.">
		<cfreturn this >
	</cffunction>

	<cffunction name="getfields" access="remote" output="false" hint="I get the list of fields.">		
		<cfset var fieldlist = "" />
		<cfquery name="fieldlist">
			select f.fieldid, f.stateid, f.fieldname, f.fieldaddress1, f.fieldaddress2, f.fieldcity, f.fieldstate, f.fieldzip,
				   f.fieldcontactnumber, f.fieldcontactname, f.fieldcontacttitle, f.fieldactive, 
				   s.statename, s.stateabbr
			  from fields f, states s
			 where f.stateid = s.stateid			  
				   <cfif structkeyexists( form, "filterresults" )>						
						<cfif structkeyexists( form, "fieldname" ) and form.fieldname neq "">
							and f.fieldname LIKE <cfqueryparam value="#trim( form.fieldname )#%" cfsqltype="cf_sql_varchar" />
						</cfif>
						<cfif structkeyexists( form, "fieldzipcode" ) and form.fieldzipcode neq "">
							and f.fieldzip = <cfqueryparam value="#form.fieldzipcode#" cfsqltype="cf_sql_numeric" />
						</cfif>
				   </cfif>
				   <cfif structkeyexists( session, "stateid" )>						
						and s.stateid = <cfqueryparam value="#session.stateid#" cfsqltype="cf_sql_integer" />					
				   </cfif>
			 order by f.fieldname asc
		</cfquery>
		<cfreturn fieldlist>
	</cffunction>
	
	<cffunction name="getfielddetail" access="remote" output="false" hint="I get the field details.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
		<cfset var fielddetail = "" />
		<cfquery name="fielddetail">
			select f.fieldid, f.stateid, f.fieldname, f.fieldaddress1, f.fieldaddress2, f.fieldcity, f.fieldstate, f.fieldzip,
				   f.fieldcontactnumber, f.fieldcontactname, f.fieldcontacttitle, f.fieldactive, f.fieldoptionid,
				   s.statename, s.stateabbr
			  from fields f, states s
			 where f.stateid = s.stateid
			   and f.fieldid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn fielddetail>
	</cffunction>
	
	<cffunction name="getfieldcontacts" access="remote" output="false" hint="I get the field contacts list.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
		<cfset var fieldcontacts = "" />
		<cfquery name="fieldcontacts">
			select fc.fieldcontactid, fc.fieldid, fc.fieldcontactname, fc.fieldcontactnumber, fc.fieldcontacttitle, 
			       fc.fieldcontactemail, f.fieldname, fc.fieldcontactorg
			  from fieldcontacts fc, fields f
			 where f.fieldid = fc.fieldid
			   and fc.fieldid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn fieldcontacts>
	</cffunction>
	
	<cffunction name="getfieldcontact" access="remote" output="false" hint="I get the field contact details.">
		<cfargument name="id" type="numeric" required="yes" default="#url.contactid#">
		<cfset var fieldcontactdetails = "" />
		<cfquery name="fieldcontactdetails">
			select fc.fieldcontactid, fc.fieldid, fc.fieldcontactname, fc.fieldcontactnumber, fc.fieldcontacttitle, 
			       fc.fieldcontactemail, f.fieldname, fc.fieldcontactorg
			  from fieldcontacts fc, fields f
			 where f.fieldid = fc.fieldid
			   and fc.fieldcontactid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn fieldcontactdetails>
	</cffunction>
	
	<cffunction name="getfieldoptions" access="public" output="false" returntype="query" hint="I get the list of field options.">
		<cfset var fieldoptions = "" />
			<cfquery name="fieldoptions">
				select fieldoptionid, fieldoptiondescr
				  from fieldoptions
				 where fieldoptionid <> <cfqueryparam value="4" cfsqltype="cf_sql_integer" />
			  order by fieldoptiondescr asc
			</cfquery>
		<cfreturn fieldoptions>
	</cffunction>
	

</cfcomponent>