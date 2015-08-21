<cfcomponent displayname="reportservice">
	<cffunction name="init" access="public" returntype="reportservice" output="false" hint="I initialize the report service data object.">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getreportfolders" access="public" output="false" hint="I get the report folder hierachy...">		
		<cfset var reportfolders = "" />
			<cfquery name="reportfolders">
				select distinct(reportfoldername) as reportfolder, 
					   reportfolderslug as slug
				  from reportfolders				   
			  order by reportfoldername asc
			</cfquery>
		<cfreturn reportfolders>
	</cffunction>
	
	<cffunction name="getreportfolder" access="public" returntype="query" output="false" hint="I get the report folder detail.">
		<cfargument name="folderslug" type="any" required="yes">
			<cfset var reportfolder = "" />
				<cfquery name="reportfolder">
					select reportfolderid, reportfoldername as reportfolder, 
						   reportfolderslug as slug
					  from reportfolders				   
					 where reportfolderslug = <cfqueryparam value="#arguments.folderslug#" cfsqltype="cf_sql_varchar" />  
				</cfquery>
		<cfreturn reportfolder>
	</cffunction>
	
	<cffunction name="getallreports" access="public" output="false" hint="I get the list of all reports.">
		<cfset var allreports = "" />
			<cfquery name="allreports">
				select reportid, reportfolderid, reportname, reportdatecreated, reporttemplatepath
				  from reports
			  order by reportfolderid, reportname, reportdatecreated asc
			</cfquery>
		<cfreturn allreports>
	</cffunction>
	
	<cffunction name="getreports" access="public" returntype="query" output="false" hint="I get the list of reports for the specified report folder">
		<cfargument name="folderid" required="yes" type="numeric" default="1">
			<cfset var reports = "" />
			<cfquery name="reports">
				select reportid, reportname, reportdatecreated, reporttemplatepath
				  from reports
				 where reportfolderid = <cfqueryparam value="#arguments.folderid#" cfsqltype="cf_sql_integer" />
			  order by reportname, reportdatecreated asc
			</cfquery>
		<cfreturn reports>
	</cffunction>
	
	<cffunction name="getreport" access="public" returntype="query" output="false" hint="I get the report detail.">
		<cfargument name="reportid" required="yes" type="numeric" default="1">
			<cfset var reporttemplate = "" />
			<cfquery name="reporttemplate">
				select reportid, reportname, reportdatecreated, reporttemplatepath
				  from reports
				 where reportid = <cfqueryparam value="#arguments.reportid#" cfsqltype="cf_sql_integer" />			 
			</cfquery>
		<cfreturn reporttemplate>
	</cffunction>


</cfcomponent>