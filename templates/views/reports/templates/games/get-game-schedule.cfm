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