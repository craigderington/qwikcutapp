<cfcomponent displayname="gamesnotificationservice">

	<cffunction name="init" access="public" output="false" returntype="gamesnotificationservice" hint="I create an initialized games notification service object.">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getgamenotifications" access="public" returntype="query" output="false" hint="I get the game notifications.">
		<cfargument name="vsid" required="yes" type="numeric" default="#session.vsid#">
		<cfset var gamenotifications = "" />
		<cfquery name="gamenotifications">
			select n.vsid, n.gameid, n.notificationtype, n.notificationtext, n.notificationtimestamp, n.notificationstatus, 
			       n.shooterid, n.notificationqueued, n.notificationsent,
				   s.shooterfirstname, s.shooterlastname
			  from dbo.notifications n left join shooters s on n.shooterid = s.shooterid
			 where n.vsid = <cfqueryparam value="#arguments.vsid#" cfsqltype="cf_sql_integer" />
			order by n.notificationid desc, n.notificationtimestamp desc
		</cfquery>
		<cfreturn gamenotifications>
	</cffunction>
	
	<cffunction name="getnotificationsfromqueue" access="public" output="false" returntype="query" hint="I get the queued notifications.">
		<cfset notificationqueue = "" />
		<cfquery name="notificationqueue">
			select top 1 notificationid, vsid, gameid, notificationtype, notificationtext, notificationtimestamp, notificationstatus,
			       shooterid, notificationqueued, notificationsent
			  from dbo.notifications
			 where notifications.notificationqueued = <cfqueryparam value="1" cfsqltype="cf_sql_bit" />
			   and notifications.notificationsent = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
		</cfquery>
		<cfreturn notificationqueue>
	</cffunction>
	

	<cffunction name="sendgamenotifications" access="public" output="false" returntype="any" hint="I send the games notifications.">
			<cfargument name="shooteremail" type="any" required="yes">
			<cfargument name="senderemail" type="any" required="yes">
			<cfargument name="sendtype" type="any" required="yes">
			<cfargument name="shootername" type="any" required="yes">
			<cfargument name="notificationtype" type="any" required="yes">
			
			<cfset arguments.senderemail = "info@qwikcut.com"  />
			<cfset msgstatus = "" />
			
			<cfif trim( arguments.sendtype ) eq "email">
			
				<cfmail from="#arguments.senderemail#" to="#arguments.shooteremail#" bcc="craig@craigderington.me,todd@qwikcut.com" subject="#ucase( arguments.notificationtype )#" type="HTML"><cfoutput><div align="center"><a href="http://www.qwikcut.com"><img src="http://qwikcut.cloudapp.net/qwikcutapp/img/qc-logo-600x176.jpg" height="176" width="600"></a></div>
				
<div style="padding:7px;">			
<h3>Hi, #shootername#</h3>
				
<p>You have a new #ucase( arguments.notificationtype )#.</p>

<p>Please login to the QC+ App to accept your game assignments, update your Videographer profile, change your alert preferences and more...</p>

<p>&nbsp;</p>

<p><a href="http://qwikcut.cloudapp.net/qwikcutapp/index.cfm" style="-moz-box-shadow:inset 0px 1px 0px 0px ##9acc85;-webkit-box-shadow:inset 0px 1px 0px 0px ##9acc85;box-shadow:inset 0px 1px 0px 0px ##9acc85;background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, ##74ad5a), color-stop(1, ##68a54b));background:-moz-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:-webkit-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:-o-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:-ms-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:linear-gradient(to bottom, ##74ad5a 5%, ##68a54b 100%);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='##74ad5a', endColorstr='##68a54b',GradientType=0);background-color:##74ad5a;-moz-border-radius:11px;-webkit-border-radius:11px;border-radius:11px;border:3px solid ##3b6e22;display:inline-block;cursor:pointer;color:##ffffff;font-family:Verdana;font-size:18px;font-weight:bold;padding:10px 21px;text-decoration:none;text-shadow:0px 1px 0px ##92b879;"> Login Now &raquo;</a></p>	

<br /><br /><br /><br />

<p><small>This is an automated email sent from a unattended mailbox. Please do not reply to this email directly.  Please direct all questions or comments to info@qwikcut.com</small></p>
<p><small>Email sent on behalf of QwikCut.com on #dateformat( now(), "mm/dd/yyyy" )# at #timeformat( now(), "hh:mm:ss tt" )#</small></p>
</div>
</cfoutput>
				<cfmailparam name="reply-to" value="info@qwikcut.com">
				
		
				</cfmail>
				
				
			<cfelse>
			
				<!--- // send text message.  limit messages to 100 characters to avoid splitting --->
				<cfmail from="#arguments.senderemail#" to="#arguments.shooteremail#" subject="#arguments.notificationtype#">You have a new notification.  Please login to Qwikcut App for more information.
					<cfmailparam name="reply-to" value="info@qwikcut.com">
				</cfmail>
		
		
			</cfif>
				
				
			<cfset msgstatus = "Message Sent!" />
		<cfreturn msgstatus>
	</cffunction>
	
</cfcomponent>