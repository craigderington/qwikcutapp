<!--- // define vars --->
<cfparam name="postURL" default="">
<cfparam name="apiKey" default="">
<cfparam name="myResponseObj" default="">
<cfparam name="thisLat" default="">
<cfparam name="thisLong" default="">

<cfset apikey = "AIzaSyBy6kNfIxQ6yP_Q0wbyqdH-v93-gfh0miU" />
<cfset postURL = "https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=" & apiKey />		

			
			
			
			<!--- call the server --->
			<cfhttp 
				url = "#postURL#"				
				method = "get"				
				result = "result"
				>	
			</cfhttp>	
			
				
			
			<!--- // if the connection to the server responds 200 OK - process the login --->
			<cfif result.statuscode neq "200 OK">
													
				<cfoutput>
					<p>HTTP Error: #result.statusCode#</p>
					<p>Content: #htmldecode( result.filecontent )#</p>
					<p>Response Header: #result.responseHeader#</p>
					<p>Text: #result.text#</p>
				</cfoutput>

			<cfelse>
			
				<cfif !IsJSON( result.filecontent )>
				
					<h4>The result data was not in the expected format.  The data could not be parsed.</h4>


				<cfelse>
			
					<cfset myResponseObj = deserializejson( result.filecontent ) />
					
					<cfset thisLat = #myResponseObj.results[1].geometry.location.lat# />
					<cfset thisLong = #myResponseObj.results[1].geometry.location.lng# />
					
					<!---
					<cfoutput>
						<h2>#thisLat#</h2>
						
						<h2>#thisLong#</h2>
					</cfoutput>			
					
					<cfdump var="#myResponseObj#">
					--->
			
				</cfif>
				
				
				
				
			
			</cfif>





			
								





