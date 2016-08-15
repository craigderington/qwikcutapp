<cfcomponent displayname="registrationservice">		
	
	<cffunction name="init" access="public" output="false" returntype="registrationservice" hint="I create an initialized shooter registration service data object.">
		<cfreturn this >
	</cffunction>
	
	<cffunction name="getshooterbyregcode" access="public" output="false" returntype="query" hint="I get the user registration details by code.">
		<cfargument name="regcode" type="any" required="yes">
		<cfargument name="email" type="any" required="yes">		
		<cfset var shooter = ""/>
		<cfquery name="shooter">
			select s.shooterid, s.shooterfirstname, s.shooterlastname, u.userid, u.username, u.regcode, u.regcomplete, u.regcompletedate
			  from shooters s, users u
			 where s.userid = u.userid
		 	   and u.regcode = <cfqueryparam value="#arguments.regcode#" cfsqltype="cf_sql_varchar" maxlength="35" />
			   and u.email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar" />
		</cfquery>
		<cfreturn shooter>
	</cffunction>
		
	<cffunction name="getshooterbyid" access="public" output="false" returntype="query" hint="I get the user registration details by ID.">
		<cfargument name="shooterid" type="numeric" required="yes">
		<cfargument name="userid" type="numeric" required="yes">		
		<cfset var shooter = ""/>
		<cfquery name="shooter">
			select s.shooterid, s.shooterfirstname, s.shooterlastname, u.userid, u.username, u.password, u.username, 
				   s.shooteraddress1, s.shooteraddress2, s.shootercity, s.shooterstateid, s.shooterzip, s.shooteremail,
				   s.shootercellphone, s.shootercellprovider, s.shooteralertpref, u.regcomplete, u.regcompletedate
			  from shooters s, users u
			 where s.userid = u.userid
		 	   and u.userid = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" />
			   and s.shooterid = <cfqueryparam value="#arguments.shooterid#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<cfreturn shooter>
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
	
	<cffunction name="getshooterdates" output="false" returntype="query" access="remote" hint="I get the shooter block out dates.">
		<cfargument name="shooterid" type="numeric" required="yes" default="#session.shooterid#">
		<cfset var shooterdates = "" />
			<cfquery name="shooterdates">
				 select sbd.shooterblockid, sbd.shooterid, sbd.fromdate, sbd.todate, sbd.blockreason
				   from dbo.shooterblockoutdates sbd
				  where sbd.shooterid = <cfqueryparam value="#arguments.shooterid#" cfsqltype="cf_sql_integer" />
				 order by sbd.fromdate, sbd.shooterblockid asc
			</cfquery>
		<cfreturn shooterdates>
	</cffunction>
	
	<cffunction name="sendregistrationcomplete" access="public" output="false" returntype="string" hint="I send the notification email.">
		<cfargument name="senderemail" required="yes" type="any">
		<cfargument name="shooteremail" required="yes" type="any">
		<cfargument name="shootername" required="yes" type="any">
		
		<cfset arguments.senderemail = "systems@qwikcut.com"  />
		<cfset msgstatus = "" />
			<cfmail from="#arguments.senderemail#" to="#arguments.shooteremail#" cc="todd@qwikcut.com" subject="QwikCut - Videographer Registration - Complete" type="HTML"><cfoutput><div align="center"><a href="http://www.qwikcut.com"><img src="http://qwikcut.cloudapp.net/qwikcutapp/img/qc-logo-600x176.jpg" height="176" width="600"></a></div>
<div style="padding:7px;">			
<h3>Thank You, #shootername#</h3>
			
<p>We appreciate your prompt response to our registration invitation.  Your QwikCut videographer profile has been successfully completed.</p>

<p>You will be contacted again once games are scheduled and you are ready to begin filming at the game fields.</p>

<p>In the mean time, log in to the website and add a profile image, meet other videographers and update your blockout dates.</p>

<p><a href="http://qwikcut.cloudapp.net/index.cfm">Update Profile</a></p>	

<br /><br /><br /><br />

<p><small>This is an automated email sent from a unattended mailbox. Please do not reply to this email directly.  Please direct all questions or comments to info@qwikcut.com</small></p>
<p><small>Email sent on behalf of QwikCut.com on #dateformat( now(), "mm/dd/yyyy" )# at #timeformat( now(), "hh:mm:ss tt" )#</small></p>
</div>
</cfoutput>
			<cfmailparam name="reply-to" value="systems@qwikcut.com">
			</cfmail>
			<cfset msgstatus = "Message Sent!" />
		<cfreturn msgstatus>
	
	</cffunction>
	
	
</cfcomponent>