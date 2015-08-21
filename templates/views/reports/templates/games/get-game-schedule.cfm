<cfoutput>
<h3><i class="fa fa-briefcase"></i> #reporttemplate.reportname# <span class="pull-right"><a href="#application.root##url.event#&reports=#url.reports#" class="btn btn-xs btn-default btn-outline"><i class="fa fa-arrow-circle-left"></i> Return to #trim( ucase( url.reports ))# Reports</a></span></h3>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>

{ "gameid" : _id, "conferenceid" : conferenceid, 
	"field" : 
		{ fieldid: _fieldid, 
		  fieldname: "fieldname",
		  "address" : 
			{
				"streetaddress" : streetaddress,
				"city" : city,
				"state" : state,
				"zipcode" : zipcode
			}
		  "fieldcontact" :
			{
				"primarycontact" : primarycontact,
				"primarycontacttitle" : primarycontacttitle,
				"primarycontactnumber" : primarycontactnumber
			},
			
		  
		}
	"teams" :
		{
			"hometeam" : _hometeam,
			"awayteam" : _awayteam
		}
	
	"results" :
		{
			"outcome" : _teamid,
			"score" : [array]
		}
}
</p>
</cfoutput>