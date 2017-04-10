using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TreeDemo.Models
{
	public class TreeDataResult
	{
		public string StateName { get; set; }
		public List<TreeNodeResult> NodeList { get; set; }
	}

	public class TreeNodeResult
	{
		public string id { get; set; }

		public string parent { get; set; }

		public string type { get; set; }

		public string text { get; set; }

		public string icon { get; set; }

		public State state {get; set;}

	}


	public class State
	{
		public string loaded { get; set; }
		public string opened { get; set; }
		public string selected { get; set; }
		public string disabled { get; set; }

	}
}


/*
 
 {
	"id": "1",
	"text": "Dogs",
	"icon": "glyphicon glyphicon-flash",
	"state": {
		"loaded": true,
		"opened": true,
		"selected": false,
		"disabled": false
	},
	"data": {
		
	},
	"parent": "#",
	"type": "1"
}
  
 * 
 */