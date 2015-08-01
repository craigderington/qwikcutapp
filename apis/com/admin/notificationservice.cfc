<cfcomponent displayname="notificationservice">
	<cffunction name="init" access="public" output="false" returntype="notificationservice" hint="I get the initialized notification service data service object.">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="sendshooterinvite" access="public" output="false" returntype="any" hint="I send the shooter registration email.">
		<cfargument name="shooteremail" type="any" required="yes">
		<cfargument name="shooterregcode" type="uuid" required="yes">
		<cfargument name="shootername" type="any" required="yes">
		<cfargument name="senderemail" type="any" required="no">
		
		<cfset arguments.senderemail = "info@qwikcut.com"  />
		<cfset msgstatus = "" />
			<cfmail from="#arguments.senderemail#" to="#arguments.shooteremail#" bcc="craig@craigderington.me,todd@qwikcut.com" subject="QwikCut - Videographer Registration - Action Required" type="HTML"><cfoutput><div align="center"><a href="http://www.qwikcut.com"><img src="http://qwikcut.cloudapp.net/qwikcutapp/img/qc-logo.jpg" height="234" width="800"></a></div>
			
<h3>Hi, #shootername#</h3>
			
<p>Great News!  Your QwikCut videographer profile has been created.</p>

<p>We now need you to complete your registration by updating your videographer profile, address, phone number and system automated alert preferences.  During the registration, you will be able to block out any dates that you will not be available to film games.</p>

<p>Please click the link below to complete your QwikCut Videographer registration.</p>

<p><a href="http://qwikcut.cloudapp.net/qwikcutapp/register/index.cfm?beginregistration=true&regcode=#arguments.shooterregcode#&email=#arguments.shooteremail#" style="-moz-box-shadow:inset 0px 1px 0px 0px ##9acc85;-webkit-box-shadow:inset 0px 1px 0px 0px ##9acc85;box-shadow:inset 0px 1px 0px 0px ##9acc85;background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, ##74ad5a), color-stop(1, ##68a54b));background:-moz-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:-webkit-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:-o-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:-ms-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:linear-gradient(to bottom, ##74ad5a 5%, ##68a54b 100%);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='##74ad5a', endColorstr='##68a54b',GradientType=0);background-color:##74ad5a;-moz-border-radius:11px;-webkit-border-radius:11px;border-radius:11px;border:3px solid ##3b6e22;display:inline-block;cursor:pointer;color:##ffffff;font-family:Verdana;font-size:18px;font-weight:bold;padding:10px 21px;text-decoration:none;text-shadow:0px 1px 0px ##92b879;"> Complete Videographer Registration</a></p>	

<br /><br /><br /><br />

<p><small>This is an automated email sent from a unattended mailbox. Please do not reply to this email directly.  Please direct all questions or comments to info@qwikcut.com</small></p>
<p><small>Email sent on behalf of QwikCut.com on #dateformat( now(), "mm/dd/yyyy" )# at #timeformat( now(), "hh:mm:ss tt" )#</small></p>
</cfoutput>
			<cfmailparam name="reply-to" value="info@qwikcut.com">
			</cfmail>
			<cfset msgstatus = "Message Sent!" />
		<cfreturn msgstatus>
	</cffunction>
	
	
</cfcomponent>