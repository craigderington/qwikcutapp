<cfcomponent displayname="shooteradminservice">

	<cffunction name="init" access="public" output="false" returntype="shooteradminservice" hint="I create an initialized shooter admin service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getshooters" output="false" returntype="query" access="remote" hint="I get the list of shooters.">
		<cfset var shooterlist = "" />
			<cfquery name="shooterlist">
					select sh.shooterid, sh.userid, sh.shooterfirstname, sh.shooterlastname, sh.shooteraddress1, sh.shooteraddress2, sh.shootercity, sh.shooterstateid, 
					       s.stateabbr, sh.shooterzip, sh.shooteremail, sh.shooterisactive, sh.shootercellphone, sh.shootercellprovider, sh.shooteralertpref,
						   us.userprofileimagepath
					  from dbo.shooters sh, dbo.states s, dbo.usersettings us
					 where sh.shooterstateid = s.stateid
					   and sh.userid = us.userid
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
					       s.stateabbr, sh.shooterzip, sh.shooteremail, sh.shooterisactive, sh.shootercellphone, sh.shootercellprovider, sh.shooteralertpref,
						   us.userprofileimagepath
					  from dbo.shooters sh, dbo.states s, dbo.usersettings us
					 where sh.shooterstateid = s.stateid
					   and sh.userid = us.userid
					   and sh.shooterid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn shooter>
	</cffunction>
	
	<cffunction name="getshooterfields" output="false" returntype="query" access="remote" hint="I get the shooter assigned fields.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
		<cfset var shooterfieldslist = "" />
			<cfquery name="shooterfieldslist">
				 select sf.shooterfieldid, sf.shooterid, sf.fieldid, 
						f.fieldname, f.fieldcity, f.fieldstate, 
						f.fieldzip, f.stateid, s.statename, s.stateabbr
				   from dbo.shooterfields sf, dbo.fields f, dbo.states s
				  where sf.fieldid = f.fieldid
					and f.stateid = s.stateid
					and sf.shooterid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn shooterfieldslist>
	</cffunction>
	
	<cffunction name="getshooterfielddetails" output="false" returntype="query" access="remote" hint="I get the shooter assigned field id.">
		<cfargument name="sfid" type="numeric" required="yes" default="#url.sfid#">
		<cfset var shooterfielddetails = "" />
			<cfquery name="shooterfielddetails">
				 select sf.shooterfieldid, f.fieldname, f.fieldid
				   from dbo.shooterfields sf, dbo.fields f
				  where sf.fieldid = f.fieldid
					and sf.shooterfieldid = <cfqueryparam value="#arguments.sfid#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn shooterfielddetails>
	</cffunction>
	
	<cffunction name="getshooterdates" output="false" returntype="query" access="remote" hint="I get the shooter block out dates.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
		<cfset var shooterblockdates = "" />
			<cfquery name="shooterblockdates">
				 select sbd.shooterblockid, sbd.shooterid, sbd.fromdate, sbd.todate, sbd.blockreason
				   from dbo.shooterblockoutdates sbd
				  where sbd.shooterid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn shooterblockdates>
	</cffunction>
	
	<cffunction name="getshooterpayrates" output="false" returntype="query" access="remote" hint="I get the shooter pay rates.">
		<cfset var payrateslist = "" />
		<cfquery name="payrateslist">
			select pr.payrate, pr.payratenumgames, pt.paytype
			  from payrates pr, payratetype pt
			 where payratetypeid = pt.paytypeid
		  order by pt.paytype desc, pr.payratenumgames desc
		</cfquery>
		<cfreturn payrateslist>
	</cffunction>

</cfcomponent>