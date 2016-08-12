<cfcomponent displayname="fieldadminservice">
	
	<cffunction name="init" access="public" output="false" returntype="fieldadminservice" hint="I return an initialized field admin service object.">
		<cfreturn this >
	</cffunction>

	<cffunction name="getfields" access="remote" output="false" hint="I get the list of fields.">		
		<cfargument name="stateid" required="no" type="numeric">
		<cfset var fieldlist = "" />
		<cfquery name="fieldlist">
			select f.fieldid, f.stateid, f.fieldname, f.fieldaddress1, f.fieldaddress2, f.fieldcity, f.fieldstate, f.fieldzip,
				   f.fieldcontactnumber, f.fieldcontactname, f.fieldcontacttitle, f.fieldactive, 
				   s.statename, s.stateabbr
			  from fields f, states s
			 where f.stateid = s.stateid
			   and f.fieldid <> <cfqueryparam value="155" cfsqltype="cf_sql_integer" />
				   <cfif structkeyexists( form, "filterresults" )>						
						<cfif structkeyexists( form, "fieldname" ) and form.fieldname neq "">
							and f.fieldname LIKE <cfqueryparam value="#trim( form.fieldname )#%" cfsqltype="cf_sql_varchar" />
						</cfif>
						<cfif structkeyexists( form, "fieldzipcode" ) and form.fieldzipcode neq "">
							<cfif isnumeric( form.fieldzipcode )>
								and f.fieldzip = <cfqueryparam value="#form.fieldzipcode#" cfsqltype="cf_sql_numeric" />
							<cfelse>
								and f.fieldzip = <cfqueryparam value="0" cfsqltype="cf_sql_numeric" />
							</cfif>
						</cfif>
				   </cfif>
				   <cfif structkeyexists( session, "fieldstateid" )>						
						and s.stateid = <cfqueryparam value="#session.fieldstateid#" cfsqltype="cf_sql_integer" />					
				   </cfif>
				   <cfif structkeyexists( arguments, "stateid" )>						
						and s.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />					
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
				   s.statename, s.stateabbr, r.regionid, r.region_name
			  from fields f, states s, regions r
			 where f.stateid = s.stateid
			   and f.regionid = r.regionid
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
	
	<cffunction name="gethomefield" access="public" returntype="query" output="false" hint="I get the team home field name.">
		<cfargument name="id" type="numeric" required="yes">
		<cfset var homefield = "" />
		<cfquery name="homefield">
			select f.fieldid, f.fieldname, f.fieldaddress1, f.fieldaddress2, f.fieldcity, f.stateid, 
			       s.stateabbr, f.fieldzip, f.fieldcontactname, f.fieldcontacttitle, f.fieldcontactnumber
			  from fields f, states s
			 where f.stateid = s.stateid
			   and f.fieldid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
		</cfquery>	
		<cfreturn homefield>
	</cffunction>
	
	<cffunction name="getregions" access="public" returntype="query" output="false" hint="I get the list of regions for regional field management.">
		<cfargument name="stateid" type="numeric" required="yes">
		<cfset var regionlist = "" />
		<cfquery name="regionlist">
			select s.stateid, s.statename, r.regionid, r.region_name
			  from regions r, states s
			 where r.stateid = s.stateid
			   and s.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
		   order by s.statename, r.region_name asc
		</cfquery>
		<cfreturn regionlist>	
	</cffunction>
	
	<cffunction name="getregion" access="public" returntype="query" output="false" hint="I get the region detail.">
		<cfargument name="regionid" type="numeric" required="yes">
		<cfset var regiondetail = "" />
		<cfquery name="regionlist">
			select s.stateid, s.statename, r.regionid, r.region_name
			  from regions r, states s
			 where r.stateid = s.stateid
			   and r.regionid = <cfqueryparam value="#arguments.regionid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn regiondetail>	
	</cffunction>
	

</cfcomponent>