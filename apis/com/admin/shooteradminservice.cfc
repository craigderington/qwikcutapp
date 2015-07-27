<cfcomponent displayname="shooteradminservice">

	<cffunction name="init" access="public" output="false" returntype="shooteradminservice" hint="I create an initialized shooter admin service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getshooters" output="false" returntype="query" access="remote" hint="I get the list of shooters.">
		<cfset var shooterlist = "" />
			<cfquery name="shooterlist">
					select sh.shooterid, sh.userid, sh.shooterfirstname, sh.shooterlastname, sh.shooteraddress1, sh.shooteraddress2, sh.shootercity, sh.shooterstateid, 
					       s.stateabbr, sh.shooterzip, sh.shooteremail, sh.shooterisactive, shootercellphone, shootercellprovider, shooteralertpref
					  from dbo.shooters sh, dbo.states s
					 where sh.shooterstateid = s.stateid
						<cfif structkeyexists( form, "filterresults" )>
							<cfif structkeyexists( form, "shooterstatus" ) and trim( form.shooterstatus ) neq "">
								and sh.shooterisactive = <cfqueryparam value="#form.shooterstatus#" cfsqltype="cf_sql_bit" />
							</cfif>
							<cfif structkeyexists( form, "stateid" ) and trim( form.stateid ) neq "">
								and sh.shooterstateid = <cfqueryparam value="#form.stateid#" cfsqltype="cf_sql_integer" />
							</cfif>
							<cfif structkeyexists( form, "shootername" ) and trim( form.shootername ) neq "">
								and sh.shooterfirstname + ' ' + sh.shooterlastname LIKE <cfqueryparam value="%#trim( form.shootername )#%" cfsqltype="cf_sql_varchar" />
							</cfif>
						</cfif>
				  order by sh.shooterlastname asc
			</cfquery>
		<cfreturn shooterlist>
	</cffunction>
	
	<cffunction name="getshooter" output="false" returntype="query" access="remote" hint="I get the shooter details.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
		<cfset var shooter = "" />
			<cfquery name="shooter">
					select sh.shooterid, sh.userid, sh.shooterfirstname, sh.shooterlastname, sh.shooteraddress1, sh.shooteraddress2, sh.shootercity, sh.shooterstateid, 
					       s.stateabbr, sh.shooterzip, sh.shooteremail, sh.shooterisactive, shootercellphone, shootercellprovider, shooteralertpref
					  from dbo.shooters sh, dbo.states s
					 where sh.shooterstateid = s.stateid
					   and sh.shooterid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn shooter>
	</cffunction>

</cfcomponent>