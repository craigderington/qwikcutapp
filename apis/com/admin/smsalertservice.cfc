<cfcomponent displayname="smsalertservice">
	<cffunction name="getqueuedalerts" access="public" returntype="query" output="false" hint="I get the list of queued alerts.">
		<cfset var queuedalertslist = "" />
		<cfquery name="queuedalertslist">
			select a.alertid, a.contactid, a.alertdatetime, a.alerttype, a.alerttext, a.alertread, a.alertdismissed,
				   a.alertqueued, a.alertsent, a.alertsentdate, a.gameid, a.sid,
				   tc.contactname, tc.contactemail, tc.contactnumber, tc.contactprovider, tc.contactmethod,
				   vs.gamedate, vs.hometeam, vs.awayteam, g.fieldid
			  from alerts a 
			       left join teamcontacts tc on a.contactid = tc.contactid 
			       left join games g on a.gameid = g.gameid
				   left join versus vs on g.vsid = vs.vsid			
		     where a.alertsent = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
			   and a.alertqueued = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />		
		  order by a.alertdatetime desc, a.alertid asc
		</cfquery>
		<cfreturn queuedalertslist>	
	</cffunction>
	<cffunction name="getsentalerts" access="public" returntype="query" output="false" hint="I get the list of sent alerts.">
		<cfset var sentalertslist = "" />
		<cfquery name="sentalertslist">
			select a.alertid, a.contactid, a.alertdatetime, a.alerttype, a.alerttext, a.alertread, a.alertdismissed,
				   a.alertqueued, a.alertsent, a.alertsentdate, a.gameid, a.sid,
				   tc.contactname, tc.contactemail, tc.contactnumber, tc.contactprovider, tc.contactmethod,
				   vs.gamedate, vs.hometeam, vs.awayteam, g.fieldid
			  from alerts a 
			       left join teamcontacts tc on a.contactid = tc.contactid 
			       left join games g on a.gameid = g.gameid
				   left join versus vs on g.vsid = vs.vsid			
		     where a.alertsent = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			   and a.alertqueued = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />		
		  order by a.alertdatetime desc, a.alertid asc
		</cfquery>
		<cfreturn sentalertslist>	
	</cffunction>
	<cffunction name="getshooterqueuedalerts" access="public" returntype="query" output="false" hint="I get the list of shooter queued alerts.">
		<cfset var shooterqueuedlist = "" />
		<cfquery name="shooterqueuedlist">
			select sa.shooteralertid, sa.shooterid, sa.alertdatetime, sa.alerttype, sa.alerttext, sa.alertread, sa.alertdismissed,
				   sa.alertqueued, sa.alertsent, sa.alertsentdate, s.shooterfirstname, s.shooterlastname, s.shootercellphone
			  from shooteralerts sa 
			       left join shooters s on sa.shooterid = s.shooterid			       		
		     where sa.alertsent = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
			   and sa.alertqueued = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />		
		  order by sa.alertdatetime desc, sa.shooteralertid asc
		</cfquery>
		<cfreturn shooterqueuedlist>	
	</cffunction>
	<cffunction name="getshootersentalerts" access="public" returntype="query" output="false" hint="I get the list of sent shooter alerts.">
		<cfset var shootersentlist = "" />
		<cfquery name="shootersentlist">
			select sa.shooteralertid, sa.shooterid, sa.alertdatetime, sa.alerttype, sa.alerttext, sa.alertread, sa.alertdismissed,
				   sa.alertqueued, sa.alertsent, sa.alertsentdate, sa.sid, s.shooterfirstname, s.shooterlastname, s.shootercellphone
			  from shooteralerts sa 
			       left join shooters s on sa.shooterid = s.shooterid		       	
		     where sa.alertsent = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			   and sa.alertqueued = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />		
		  order by sa.alertdatetime desc, sa.shooteralertid asc
		</cfquery>
		<cfreturn shootersentlist>	
	</cffunction>
	<cffunction name="getcontacts" access="remote" output="false" hint="I get the team contacts">				
		<cfset var contactslist = "" />
			<cfquery name="contactslist">
				select contactid, teamid, contactname, contactnumber, contactemail, contactactive, contactactivedate,
				       contactprovider, coachlastname, numalerts
				  from teamcontacts
				 where contactactive = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			  order by contactname, contactnumber asc
			</cfquery>
		<cfreturn contactslist>
	</cffunction>
</cfcomponent>