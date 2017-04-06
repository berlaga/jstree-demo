<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="TreeDemo._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Demo</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/jsTree/themes/default/style.css" rel="stylesheet" />
    
    <script src="Scripts/jquery-1.9.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <script src="Scripts/jstree.js"></script>

    <script type="text/javascript">


        $(function () {
            //$.jstree.defaults.core.themes.variant = "large";
   

            $('#jstree').on('ready.jstree', function (e, data) {
                data.instance.open_node('100', null, true);
                data.instance.open_node('200', null, true);
                data.instance.open_node('300', null, true);

            });


            $('#jstree').jstree({
                "core": {
                    "check_callback": true,
                    "data": [
					{
					    "id":     "100",
					    "parent": "#",
					    "text":   "Dogs",
					    "state": "opened",
                        "type" : "root"
					},
					{
					    "id":     "200",
					    "parent": "100",
					    "text":   "Large Dogs",
					    "state": "opened",
                        "type": "large-dogs"
					},
					{
					    "id":     "300",
					    "parent": "100",
					    "text":   "Small Dogs",
					    "state": "opened",
                        "type": "small-dogs"
					},
                    {
						"id":     "201",
						"parent": "200",
						"text":   "Great Dane",
                        "type":   "large-dogs-child"
                    },
                    {
                        "id": "202",
                        "parent": "200",
                        "text": "Giant Schnauzer",
                        "icon": "glyphicon glyphicon-leaf",
                        "type": "large-dogs-child"
                    },
                    {
                        "id": "301",
                        "parent": "300",
                        "text": "Chiwawa",
                        "type": "small-dogs-child"
                    },
                    {
                        "id": "302",
                        "parent": "300",
                        "text": "Miniture Poodle",
                        "type": "small-dogs-child"
                    },
                    {
                        "id": "303",
                        "parent": "300",
                        "text": "Pomeranian",
                        "type": "small-dogs-child"
                    }


					
                    ]

                },
                "types": {
                    "#": {
                        "valid_children": [],
                        "state": "opened"
                    },

                    "root": {
                        "valid_children": [],
                        "icon": "glyphicon glyphicon-flash"
                    },
                    "large-dogs": {
                        "valid_children": ["large-dogs-child"],
                        "icon": "glyphicon glyphicon-picture"
                    },
                    "large-dogs-child": {
                        "valid_children": [],
                        "icon": "glyphicon glyphicon-globe"
                    },
                    "small-dogs": {
                        "valid_children": ["small-dogs-child"],
                        "icon": "glyphicon glyphicon-plane"
                    },
                    "small-dogs-child": {
                        "valid_children": [],
                        "icon": "glyphicon glyphicon-tower"
                    }



                },
                "plugins": ["types", "dnd", "checkbox"]
            });

            $('#jstree').jstree("hide_dots");

            $("#jstree").jstree("open_all", "200");

        });

    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div class="container">

       <nav class="navbar navbar-inverse">
            <div class="container">
                <a class="navbar-brand" href="#" >jsTree demo</a>
                <div class="navbar-header">
                </div>
            </div>
        </nav>
            <div class="row">

                <div class="col-lg-5 col-lg-offset-1">
                    <div id="jstree"></div>
                </div>

            </div>
        </div>
    </form>



</body>
</html>
