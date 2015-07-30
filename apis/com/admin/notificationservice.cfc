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
			<cfmail from="#arguments.senderemail#" to="#arguments.shooteremail#" bcc="craig@craigderington.me,todd@qwikcut.com" subject="QwikCut - Videographer Registration - Action Required" type="HTML"><cfoutput><h3>Hi #shootername#</h3>
<p>****** TESTING SHOOTER REGISTRATION INVITE ******</p>
			
<p>Great News!  Your QwikCut videographer profile has been created.</p>

<p>We now need you to complete your registration by updating your videographer profile, address, phone number and system automated alert preferences.</p>

<p>Please click the link below to complete your QwikCut registration.</p>

<p><a href="http://qwikcut.cloudapp.net/qwikcutapp/register/index.cfm?beginregistration=true&regcode=#arguments.shooterregcode#&email=#arguments.shooteremail#" style="-moz-box-shadow:inset 0px 1px 0px 0px ##9acc85;-webkit-box-shadow:inset 0px 1px 0px 0px ##9acc85;box-shadow:inset 0px 1px 0px 0px ##9acc85;background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, ##74ad5a), color-stop(1, ##68a54b));background:-moz-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:-webkit-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:-o-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:-ms-linear-gradient(top, ##74ad5a 5%, ##68a54b 100%);background:linear-gradient(to bottom, ##74ad5a 5%, ##68a54b 100%);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='##74ad5a', endColorstr='##68a54b',GradientType=0);background-color:##74ad5a;-moz-border-radius:11px;-webkit-border-radius:11px;border-radius:11px;border:3px solid ##3b6e22;display:inline-block;cursor:pointer;color:##ffffff;font-family:Verdana;font-size:18px;font-weight:bold;padding:10px 21px;text-decoration:none;text-shadow:0px 1px 0px ##92b879;"> Complete Videographer Registration</a></p>	
</cfoutput>		
			</cfmail>
			<cfset msgstatus = "Message Sent!" />
		<cfreturn msgstatus>
	</cffunction>
	
	
</cfcomponent>