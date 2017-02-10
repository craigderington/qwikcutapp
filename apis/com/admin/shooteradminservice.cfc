<cfcomponent displayname="shooteradminservice">

	<cffunction name="init" access="public" output="false" returntype="shooteradminservice" hint="I create an initialized shooter admin service data object.">
		<cfreturn this >
	</cffunction>
			
	<cffunction name="getshooters" output="false" returntype="query" access="remote" hint="I get the list of shooters.">
		<cfargument name="stateid" type="numeric" required="no">
		<cfargument name="isactive" type="any" required="no">
		<cfset var shooterlist = "" />
			<cfquery name="shooterlist">
					select sh.shooterid, sh.userid, sh.shooterfirstname, sh.shooterlastname, sh.shooteraddress1, sh.shooteraddress2, sh.shootercity, sh.shooterstateid, 
					       s.stateabbr, sh.shooterzip, sh.shooteremail, sh.shooterisactive, sh.shootercellphone, sh.shootercellprovider, sh.shooteralertpref,
						   us.userprofileimagepath, u.regcompletedate, u.regcomplete, u.useractive
					  from dbo.shooters sh, dbo.states s, dbo.users u, dbo.usersettings us
					 where sh.shooterstateid = s.stateid
					   and sh.userid = u.userid
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
						<cfif structkeyexists( arguments, "isactive" )>
							and sh.shooterisactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
							and u.useractive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
						</cfif>
						<cfif structkeyexists( arguments, "stateid" )>
							and s.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />
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
						   us.userprofileimagepath, u.regcomplete, u.regcompletedate, u.useractive, u.regcode, u.username, u.email
					  from dbo.shooters sh, dbo.states s, dbo.users u, dbo.usersettings us
					 where sh.shooterstateid = s.stateid
					   and sh.userid = u.userid
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
	
	<cffunction name="getfields" access="remote" output="false" hint="I get the list of fields.">		
		<cfargument name="stateid" required="no" type="numeric" default="#session.stateid#">
		<cfset var fieldlist = "" />
		<cfquery name="fieldlist">
			select f.fieldid, f.stateid, f.fieldname, f.fieldaddress1, f.fieldaddress2, f.fieldcity, f.fieldstate, f.fieldzip,
				   f.fieldcontactnumber, f.fieldcontactname, f.fieldcontacttitle, f.fieldactive, 
				   s.statename, s.stateabbr
			  from fields f, states s
			 where not exists( select sf1.shooterid from shooterfields sf1 where f.fieldid = sf1.fieldid )
			   and f.stateid = s.stateid
			   and f.fieldid <> <cfqueryparam value="155" cfsqltype="cf_sql_integer" />			   
				   <cfif structkeyexists( arguments, "stateid" )>						
						and s.stateid = <cfqueryparam value="#arguments.stateid#" cfsqltype="cf_sql_integer" />					
				   </cfif>
			 order by f.fieldname asc
		</cfquery>
		<cfreturn fieldlist>
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
	
	<cffunction name="getshooterregions" output="false" returntype="query" access="remote" hint="I get the shooter assigned regions.">
		<cfargument name="id" type="numeric" required="yes" default="#url.id#">
		<cfset var shooterregionslist = "" />
			<cfquery name="shooterregionslist">
				 select sr.shooterregionid, sr.shooterid, sr.regionid, 
						r.region_name, r.regionid, r.stateid, s.stateabbr, s.statename
				   from dbo.shooterregions sr, dbo.regions r, states s
				  where sr.regionid = r.regionid
                    and r.stateid = s.stateid				  
					and sr.shooterid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn shooterregionslist>
	</cffunction>
	
	<cffunction name="getshooterregiondetails" output="false" returntype="query" access="remote" hint="I get the shooter assigned region id.">
		<cfargument name="srid" type="numeric" required="yes" default="#url.srid#">
		<cfset var shooterregiondetails = "" />
			<cfquery name="shooterregiondetails">
				 select sr.shooterregionid, sr.shooterid, sr.regionid, r.region_name
				   from dbo.shooterregions sr, regions r
				  where sr.regionid = r.regionid
					and sr.shooterregionid = <cfqueryparam value="#arguments.srid#" cfsqltype="cf_sql_integer" />
			</cfquery>
		<cfreturn shooterregiondetails>
	</cffunction>
	
	<cffunction name="getregionshooters" output="false" returntype="query" access="remote" hint="I get the list of shooters.">		
		<cfargument name="regionid" type="numeric" required="yes">
		<cfset var shooterregionlist = "" />
			<cfquery name="shooterregionlist">
					select sh.shooterid, sh.userid, sh.shooterfirstname, sh.shooterlastname, sh.shooteraddress1, sh.shooteraddress2, sh.shootercity, sh.shooterstateid, 
					       sh.shooterzip, sh.shooteremail, sh.shooterisactive, sh.shootercellphone, sh.shootercellprovider, sh.shooteralertpref,
						   u.useractive
					  from dbo.shooters sh, dbo.shooterregions sr, dbo.regions r, dbo.users u
					 where sh.shooterid = sr.shooterid
					   and sh.userid = u.userid
					   and sr.regionid = r.regionid
					   and sh.shooterisactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />					
					   and u.useractive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
					   and r.regionid = <cfqueryparam value="#arguments.regionid#" cfsqltype="cf_sql_integer" />
				  order by sh.shooterlastname asc				
			</cfquery>
		<cfreturn shooterregionlist>
	</cffunction>	
	
	<cffunction name="getshooterassignments" output="false" returntype="query" access="remote" hint="I get the shooter assignments.">
		<cfargument name="shooterid" type="numeric" required="yes">
		<cfset var shooterassignments = "" />
		<cfquery name="shooterassignments">
			select sa.shooterassignmentid, sa.shooterassigndate, sa.shooteracceptdate, sa.shooterassignstatus,
				   v.hometeam, v.awayteam, v.gamedate, v.gamestatus, v.gametime, f.fieldname
			  from shooterassignments sa 
			       inner join shooters s on sa.shooterid = s.shooterid
				   inner join versus v on sa.vsid = v.vsid
			       inner join fields f on v.fieldid = f.fieldid
			 where sa.shooterid = <cfqueryparam value="#arguments.shooterid#" cfsqltype="cf_sql_integer" />
			order by sa.shooterassigndate asc 
		</cfquery>
		<cfreturn shooterassignments>
	</cffunction>

</cfcomponent>