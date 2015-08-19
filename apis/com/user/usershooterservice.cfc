<cfcomponent displayname="usershooterservice">
	<cffunction name="init" access="public" returntype="usershooterservice" output="false" hint="I create an initialized user shooter service object.">
		<cfreturn this>
	</cffunction>
	<cffunction name="getshooterassignments" access="public" returntype="query" output="false" hint="I get the shooter assignments.">
		<cfargument name="userid" type="numeric" required="yes">
		<cfset shooterassignments = "" />
			<cfquery name="shooterassignments">
				select sa.shooterassignmentid, sa.vsid, sa.shooterassignstatus, sa.shooterassignlastupdated,
				       sa.shooteracceptedassignment, shooterassigndate, sa.shooteracceptdate, sa.shooterid,
					   v.hometeam, v.awayteam, v.gamedate, v.gametime, f.fieldname
				  from shooterassignments sa, shooters s, users u, versus v, fields f
				 where sa.shooterid = s.shooterid
				   and s.userid = u.userid
				   and sa.vsid = v.vsid
				   and v.fieldid = f.fieldid
				   and s.userid = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" />
				   and sa.shooterassignstatus = <cfqueryparam value="Assigned" cfsqltype="cf_sql_varchar" />
				   and sa.shooteracceptedassignment = <cfqueryparam value="0" cfsqltype="cf_sql_bit" />
			  order by sa.shooterassignmentid desc
			</cfquery>
		<cfreturn shooterassignments>
	</cffunction>
	
	<cffunction name="getshootergames" access="public" returntype="query" output="false" hint="I get the shooter games.">
		<cfargument name="userid" type="numeric" required="yes">
		<cfset shootergames = "" />
			<cfquery name="shootergames">
				select sa.shooterassignmentid, sa.vsid, sa.shooterassignstatus, sa.shooterassignlastupdated,
				       sa.shooteracceptedassignment, shooterassigndate, sa.shooteracceptdate, sa.shooterid,
					   v.hometeam, v.awayteam, v.gamedate, v.gametime, v.fieldid, v.gamestatus, f.fieldname
				  from shooterassignments sa, shooters s, users u, versus v, fields f
				 where sa.shooterid = s.shooterid
				   and s.userid = u.userid
				   and sa.vsid = v.vsid
				   and v.fieldid = f.fieldid
				   and s.userid = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" />				  
			  order by sa.shooterassignmentid desc
			</cfquery>
		<cfreturn shootergames>
	</cffunction>

	<cffunction name="getgamestatus" access="public" returntype="query" output="false" hint="I get the shooter game statuses.">
		<cfargument name="sgid" type="numeric" required="yes" default="#url.sgid#">
		<cfset gamestatus = "" />
			<cfquery name="gamestatus">
				select gamestatusid, gameid, gamestatus, hometeamscore, awayteamscore, gamequarter, gamelastupdate, gamenotes
				  from gamestatus
				 where gameid = <cfqueryparam value="#arguments.sgid#" cfsqltype="cf_sql_integer" />				   				  
			  order by gamestatusid desc
			</cfquery>
		<cfreturn gamestatus>
	</cffunction>
	
	
	<cffunction name="gamecheckin" access="public" returntype="struct" output="false" hint="I get the shooter games struct.">
		<cfargument name="userid" type="numeric" required="yes" default="#session.userid#">
		<cfargument name="docheckin" type="numeric" required="yes">
		<cfargument name="fieldid" type="numeric" required="yes">
		<cfargument name="vsid" type="numeric" required="yes">
		<cfset strShooterGameManager = structnew() />
			<cfquery name="shootergamemanager">
				select sa.shooterassignmentid, sa.vsid, sa.shooterassignstatus, sa.shooterassignlastupdated,
				       sa.shooteracceptedassignment, shooterassigndate, sa.shooteracceptdate, sa.shooterid,
					   u.userid, v.hometeam, v.awayteam, v.gamedate, v.gametime, v.fieldid, v.gamestatus, f.fieldname
				  from shooterassignments sa, shooters s, users u, versus v, fields f
				 where sa.shooterid = s.shooterid
				   and s.userid = u.userid
				   and sa.vsid = v.vsid
				   and v.fieldid = f.fieldid
				   and v.vsid = <cfqueryparam value="#arguments.vsid#" cfsqltype="cf_sql_integer" />
				   and f.fieldid = <cfqueryparam value="#arguments.fieldid#" cfsqltype="cf_sql_integer" />
				   and u.userid = <cfqueryparam value="#arguments.userid#" cfsqltype="cf_sql_integer" />
			  order by sa.shooterassignmentid desc
			</cfquery>
			
			<!--- // get the game ids --->
			<cfquery name="getgameid">
				select top 1 gameid
				  from games
				 where vsid = <cfqueryparam value="#arguments.vsid#" cfsqltype="cf_sql_integer" />
			</cfquery>
			
			<!--- // create our shooter game manager struct --->
			<cfset vsid = structinsert( strShooterGameManager, "vsid", shootergamemanager.vsid ) />
			<cfset fieldid = structinsert( strShooterGameManager, "fieldid", shootergamemanager.fieldid ) />
			<cfset userid = structinsert( strShooterGameManager, "userid", shootergamemanager.userid ) />
			<cfset shooterid = structinsert( strShooterGameManager, "shooterid", shootergamemanager.shooterid ) />
			<cfset gameid = getgameid.gameid />
			<cfset thisnumber = vsid + fieldid + userid />
			<cfset notificationtype = "Game Notification" />
			<cfset notificationstatus = "Queued" />
			<cfset notificationtext = "Shooter checked in at game." />
			<cfset today = now() />
			
			<cfset chkgame = arguments.vsid + arguments.fieldid + arguments.userid  />
			
			<cfif chkgame eq thisnumber>		
				<cfset checkedinstatus = structinsert( strShooterGameManager, "checkedinstatus", "true" ) />
					<!--- // update assignment status as checked in at game --->
					<cfquery name="updateassignstatus">
						update shooterassignments
						   set shooterassignstatus = <cfqueryparam value="Checked In" cfsqltype="cf_sql_varchar" />,
						       shooterassignlastupdated = <cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />
						 where shooterassignmentid = <cfqueryparam value="#shootergamemanager.shooterassignmentid#" />
					</cfquery>
					<!--- // add game check-in to the notification service queue --->
					<cfquery name="creategamenotification">															
						insert into notifications(vsid, gameid, notificationtype, notificationtext, notificationtimestamp, notificationstatus, shooterid, notificationqueued, notificationsent)														  													   
							values(
									<cfqueryparam value="#strShooterGameManager.vsid#" cfsqltype="cf_sql_integer" />,
									<cfqueryparam value="#gameid#" cfsqltype="cf_sql_integer" />,
									<cfqueryparam value="#notificationtype#" cfsqltype="cf_sql_varchar" />,
									<cfqueryparam value="#notificationtext#" cfsqltype="cf_sql_varchar" />,
									<cfqueryparam value="#today#" cfsqltype="cf_sql_timestamp" />,
									<cfqueryparam value="#notificationstatus#" cfsqltype="cf_sql_varchar" />,
									<cfqueryparam value="#strShooterGameManager.shooterid#" cfsqltype="cf_sql_integer" />,
									<cfqueryparam value="1" cfsqltype="cf_sql_bit" />,
									<cfqueryparam value="0" cfsqltype="cf_sql_bit" />
								  );
					</cfquery>				
				<cfreturn strShooterGameManager>								
			<cfelse>
				<cfset checkedinstatus = structinsert( strShooterGameManager, "checkedinstatus", "false" ) />				
				<cfreturn strShooterGameManager>				
			</cfif>
	</cffunction>
	
	
	
</cfcomponent>