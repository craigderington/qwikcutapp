


			<cfquery name="getfields">				
				select fieldid, fieldname, fieldcontactname, fieldcontacttitle, fieldcontactnumber
				  from fields				  
				  where fieldactive = 1
				  and fieldcontactname is not null
				  and fieldcontactname <> 'None'
			</cfquery>
			
			<cfloop query="getfields">
			
				<cfset fieldid = fieldid />
				<cfset contactname = fieldcontactname />
				<cfset contacttitle = fieldcontacttitle />
				<cfset contactnumber = rereplacenocase( fieldcontactnumber, "[^0-9]", "", "all" ) />
				
				<cfquery name="modifyFieldContacts">
					insert into fieldcontacts(fieldcontactname, fieldcontacttitle, fieldcontactnumber, fieldcontactemail, fieldid)
						values(
							<cfqueryparam value="#contactname#" cfsqltype="cf_sql_varchar" />,
							<cfqueryparam value="#contacttitle#" cfsqltype="cf_sql_varchar"/>,
							<cfqueryparam value="#contactnumber#" cfsqltype="cf_sql_varchar" />,
							<cfqueryparam value="none" cfsqltype="cf_sql_varchar" />,
							<cfqueryparam value="#fieldid#" cfsqltype="cf_sql_integer" />
						);
				</cfquery>		
			
			</cfloop>
			
			<cfoutput>
				#modifyFieldContacts.recordcount# field contact records created...
			</cfoutput>
			