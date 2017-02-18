<cfcomponent displayname="payrolladminservice">

	<cffunction name="init" access="public" output="false" returntype="payrolladminservice" hint="I create an initialized payroll admin service data object.">
		<cfreturn this >
	</cffunction>
	
	<cffunction name="getpayroll" access="remote" output="false" returntype="query" hint="I get the recent payroll objects.">
		<cfargument name="sdate" type="date" required="no">
		<cfargument name="edate" type="date" required="no">
		<cfset var payroll = "" />
		<cfquery name="payroll">
			select payrollid, payrollbegindate, payrollenddate, payrollstatus, payrollprocessed, payrollprocessby,
			       payrollapproveby, payrollsenttobank
			  from payroll
			order by payrollid desc
		</cfquery>
		<cfreturn payroll>
	</cffunction>
	
	<cffunction name="getpayrollinfo" access="remote" output="false" returntype="query" hint="I get the selected payroll object.">
		<cfargument name="id" type="numeric" required="yes" default="#session.payrollid#">		
		<cfset var payrollinfo = "" />
		<cfquery name="payrollinfo">
			select payrollid, payrollbegindate, payrollenddate, payrollstatus, payrollprocessed, payrollprocessby,
			       payrollapproveby, payrollsenttobank
			  from payroll
			 where payrollid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			order by payrollid desc
		</cfquery>
		<cfreturn payrollinfo>
	</cffunction>
	
	<cffunction name="getpayrolldetails" access="remote" output="false" returntype="query" hint="I get the payroll detail objects.">
		<cfargument name="id" type="numeric" required="yes" default="#session.payrollid#">		
		<cfset var payrolldetails = "" />
		<cfquery name="payrolldetails">
			select p.payrollbegindate, p.payrollenddate, p.payrollstatus, p.payrollprocessed,
			       pd.payrolldetailid, pd.shooterid, pd.payhours, pd.payrate, pd.payratetype, pd.paycomments, 
				   pd.payamounttotal, pd.payadditionalamount, pd.payadditionalcomment, pd.paystatus, pd.paysenttobank, 
				   pd.paychargeback, pd.paychargebackstatus, pd.paychargebackreason, pd.assignmentid,
				   s.shooterfirstname, s.shooterlastname, s.shooterbankname, s.shooterbankaccountnumber, s.shooterbankroutingnumber
			  from payroll p
			       inner join payrolldetails pd on p.payrollid = pd.payrollid
				   inner join shooters s on pd.shooterid = s.shooterid
			 where pd.payrollid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			order by pd.payrolldetailid asc
		</cfquery>
		<cfreturn payrolldetails>
	</cffunction>
	
	<cffunction name="getpayrollshooters" access="remote" output="false" returntype="query" hint="I get the shooters for this payroll detail object.">
		<cfargument name="id" type="numeric" required="yes" default="#session.payrollid#">
		<cfargument name="sdate" type="date" required="yes">
		<cfargument name="edate" type="date" required="yes">
		<cfset var payrollshooters = "" />
		<cfquery name="payrollshooters">
			select sa.*, s.shooterfirstname, s.shooterlastname, s.shooterisactive, s.shooterbankname, s.shooterbankroutingnumber,
				   s.shooterbankaccountnumber, v.vsid, v.hometeam, v.awayteam, v.gamedate
			  from shooterassignments sa
				   inner join shooters s on sa.shooterid = s.shooterid
				   inner join versus v on sa.vsid = v.vsid
			 where not exists(select pd.assignmentid from payrolldetails pd where pd.assignmentid = sa.shooterassignmentid)
			   and shooterassigndate between '2/1/2017' and '2/28/2017'
			   and sa.shooteracceptedassignment = 1
			   and sa.shooteracceptdate is not NULL
			   and sa.shooterassignstatus = 'completed'
			   and sa.payrolldetailid is NULL
			   and sa.paidassignment = 0
		</cfquery>
		<cfreturn payrollshooters>
	</cffunction>
	
	
	
	
</cfcomponent>