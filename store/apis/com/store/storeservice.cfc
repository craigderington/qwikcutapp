<cfcomponent displayname="storeservice">

	<cffunction name="init" access="public" returntype="storeservice" output="false" hint="I initialize the store object service.">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getmycart" access="public" returntype="query" output="false" hint="I get the cart details.">		
		<cfargument name="cartid" type="numeric" required="true">		
		<cfset var mycart = "" />		
		<cfquery name="mycart">
			select cart_id, cart_session, cart_date, cart_cfid, cart_active, cart_jsess
			  from carts
			 where cart_id = <cfqueryparam value="#arguments.cartid#" cfsqltype="cf_sql_integer" />	
		</cfquery>
		<cfreturn mycart />
	</cffunction>
	
	<cffunction name="getcartcount" access="public" returntype="query" output="false" hint="I get the cart details.">
		<cfargument name="cartid" type="numeric" required="true">				
		<cfset var cartcount = "" />		
		<cfquery name="cartcount">
			select count(cart_item_id) as totalitems
			  from cart_items
			 where cart_id = <cfqueryparam value="#arguments.cartid#" cfsqltype="cf_sql_integer" />			   
		</cfquery>
		<cfreturn cartcount />
	</cffunction>
	
	
	<cffunction name="getcart" access="public" returntype="query" output="false" hint="I get the cart details.">
		<cfargument name="cart_id" type="numeric" required="true" default="#session.cart_id#">				
		<cfset var cartItemList = "" />		
		<cfquery name="cartItemList">
			select cart_item_id, cart_id, cart_item, cart_item_descr, 
			       cart_item_qty, cart_item_price, cart_item_total
			  from cart_items
			 where cart_id = <cfqueryparam value="#arguments.cart_id#" cfsqltype="cf_sql_varchar" maxlength="32" />
			order by cart_item_id asc
		</cfquery>
		<cfreturn cartItemList>
	</cffunction>
	
	<cffunction name="getcustomerorder" access="public" returntype="query" output="false" hint="I get the cart details.">
		<cfargument name="orderid" type="numeric" required="true" default="#session.thisorder#">				
		<cfset var customerorder = "" />		
		<cfquery name="customerorder">
			select c.customer_id, c.customer_date, c.first_name, c.last_name, c.street_address, c.city, c.state, c.zip_code, 
			       c.phone_number, c.customer_active, c.customer_email, c.conference, c.division, c.hudl_id,
				   o.order_date, o.cart_id, o.order_status, cr.cart_session
			  from orders o, customers c, carts cr
			 where o.customer_id = c.customer_id
			   and o.cart_id = cr.cart_id
			   and o.order_id = <cfqueryparam value="#arguments.orderid#" cfsqltype="cf_sql_integer" />		  		
		</cfquery>
		<cfreturn customerorder>
	</cffunction>
	
	<cffunction name="getorderdetail" access="public" returntype="query" output="false" hint="I get the cart details.">
		<cfargument name="orderid" type="numeric" required="true" default="#session.thisorder#">				
		<cfset var orderdetail = "" />		
		<cfquery name="orderdetail">
			select oi.order_item_id, oi.order_id, oi.order_item, oi.order_item_qty, oi.order_item_price,
			       oi.order_item_total, oi.order_item_descr
			  from orders o, order_items oi
			 where o.order_id = oi.order_id			   
			   and o.order_id = <cfqueryparam value="#arguments.orderid#" cfsqltype="cf_sql_integer" />		  		
		</cfquery>
		<cfreturn orderdetail>
	</cffunction>

</cfcomponent>