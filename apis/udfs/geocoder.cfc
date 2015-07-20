<cfcomponent displayname="geocoder">
	<cffunction name="findLatLong"  output="false" returntype="struct">
		<cfargument name="street" type="string" required="true" >
        <cfargument name="city" type="string" required="true">
        <cfargument name="state" type="string" required="true">
        <cfargument name="zip" type="string" required="true">
		<!--- Replacing all the spaces with '+' and removing ',' --->
        <cfset VARIABLES.loc_street = trim(replacenocase(replacenocase(ARGUMENTS.street," ","+","all"),",","","all"))>
        <cfset VARIABLES.loc_city = trim(replacenocase(replacenocase(ARGUMENTS.city," ","+","all"),",","","all"))>
        <cfset VARIABLES.loc_state = trim(replacenocase(replacenocase(ARGUMENTS.state," ","+","all"),",","","all"))>
        <cfset VARIABLES.loc_zip = trim(replacenocase(replacenocase(ARGUMENTS.zip," ","+","all"),",","","all"))>
        
		<!---Creating an address string in proper format for google maps(Streetname,City,State,Zipcode) --->
        <cfset VARIABLES.urladdress="#loc_street#,#loc_city#,#loc_state#,#loc_zip#">
        <cftry>
            <cfhttp result="geocode" url="http://maps.googleapis.com/maps/api/geocode/xml?address=#urladdress#&sensor=false" method="get">
                <cfhttpparam type="header" name="Content-Type" value="text/xml">
            </cfhttp>
            <cfset VARIABLES.gcode = "#xmlparse(geocode.filecontent)#">
            <cfif VARIABLES.gcode.geocoderesponse.status.xmltext EQ "OK">
                <cfset VARIABLES.newlat = "#VARIABLES.gcode.geocoderesponse.result.geometry.location.lat.xmltext#">
                <cfset VARIABLES.newlon = "#VARIABLES.gcode.geocoderesponse.result.geometry.location.lng.xmltext#">
                <cfset VARIABLES.gcodefail = 0>
            <cfelse>
                <cfset VARIABLES.newlat = "0">
                <cfset VARIABLES.newlon = "0">
                <cfset VARIABLES.gcodefail = 1>
            </cfif>
 
            <cfcatch>
                <cfdump var="#cfcatch#">
                <cfset VARIABLES.newlat = "0">
                <cfset VARIABLES.newlon = "0">
                <cfset VARIABLES.gcodefail = 1>
            </cfcatch>
        </cftry>
        <cfset VARIABLES.locationstruct=structNew()>
        <cfset VARIABLES.locationstruct.latitude=newlat>
        <cfset VARIABLES.locationstruct.longitude=newlon>
        <cfset VARIABLES.locationstruct.gcodefail=gcodefail>
        <cfreturn VARIABLES.locationstruct>
    </cffunction>
</cfcomponent>