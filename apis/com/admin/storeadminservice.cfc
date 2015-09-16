<cfcomponent displayname="storeadminservice">
	<cffunction name="init" access="public" returntype="storeadminservice" output="false" hint="I initialize the store admin service object.">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getstoredashboard" access="public" returntype="query" output="false" hint="I get the store admin dashboard order count.">
		<cfset var storedashboard = "" />
		<cfquery name="storedashboard">
			select count(*) as totalorders
			  from dbo.orders
		</cfquery>
		<cfreturn storedashboard>
	</cffunction>
	
	<cffunction name="getorders" access="public" returntype="query" output="false" hint="I get the list of orders.">		
		<cfset var orders = "" />
		<cfquery name="orders">
			   select o.order_id, o.order_date, o.order_status, o.order_completed, o.customer_id,
					  c.customer_date, c.first_name, c.last_name, c.street_address, c.city, c.state,
				      c.phone_number, c.customer_email, c.zip_code, sum(oi.order_item_total) as total_sale
				 from orders o, order_items oi, customers c
				where o.customer_id = c.customer_id
				  and o.order_id = oi.order_id
				   <cfif structkeyexists( form, "filter_results" )>
					<cfif structkeyexists( form, "order_date" )>
						and o.order_date = <cfqueryparam value="#form.order_date#" cfsqltype="cf_sql_date" />
					</cfif>
					<cfif structkeyexists( form, "order_id" )>
						and o.order_id = <cfqueryparam value="#form.order_id#" cfsqltype="cf_sql_date" />
					</cfif>
					<cfif structkeyexists( form, "customer_name" )>
						and c.first_name + ' ' + c.last_name LIKE <cfqueryparam value="%#form.customer_name#%" cfsqltype="cf_sql_date" />
					</cfif>				   
				   </cfif>
				group by o.order_id, o.order_date, o.order_status, o.order_completed, o.customer_id,
						 c.customer_date, c.first_name, c.last_name, c.street_address, c.city, c.state,
					     c.phone_number, c.customer_email, c.zip_code
			    order by o.order_date desc
		</cfquery>
		<cfreturn orders>
	</cffunction>

</cfcomponent>