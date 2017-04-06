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

            $.jstree.defaults.contextmenu.select_node = false;
   

            $('#jstree').on('ready.jstree', function (e, data) {
                data.instance.open_node('100', null, true);
                data.instance.open_node('200', null, true);
                data.instance.open_node('300', null, true);
            });


            $('#jstree').jstree({
                'contextmenu': {
                    'items': customMenu
                },
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
                "plugins": ["types", "dnd", "checkbox", "contextmenu"]
            });

            $('#jstree').jstree("hide_dots");



            $("#delete_node").click(function () {
                var instance = $('#jstree').jstree(true);
                if (instance.get_selected().length == 0) {
                    alert("nothing is selected");
                    return;
                }

                instance.delete_node(instance.get_selected());
            });

            $("#rename_node").click(function () {
                var instance = $('#jstree').jstree(true);

                if (instance.get_selected().length > 1) {
                    alert("only one is allowed");
                    return;
                }

                if (instance.get_selected().length == 0) {
                    alert("nothing is selected");
                    return;
                }


                var res = prompt("Rename value?");

                if (res) {
                    instance.rename_node(instance.get_selected()[0], res);
                } else {
                    alert("privide value");

                }

            });

        });



        function customMenu(node) {
            var items = {
                'item1': {
                    'label': 'Delete',
                    'action': function () {  }
                },
                'item2': {
                    'label': 'Rename',
                    'action': function () { /* action */ }
                }
            }

            if ((node.id == '100') || (node.id == '200') || (node.id == '300')) {
                delete items.item1;
                delete items.item2;
            } 

            return items;
        }

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

            <div class="row" style="margin-top:40px;">
                <div class="col-lg-3 col-lg-offset-1">
                    <button id="delete_node" type="button">Delete selected node(s)</button>
                </div>
                <div class="col-lg-3">
                    <button id="rename_node" type="button">Rename selected node</button>
                </div>

            </div>
        </div>
    </form>



</body>
</html>
