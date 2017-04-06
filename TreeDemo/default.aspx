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


            $('#jstree').jstree({
                "core": {
                    "check_callback": true,
                    "data": [{
                        "text": "Branch 1",
                        "type": "branch1",
                        "children": [{
                            "text": "leaf 1.1",
                            "type": "br1"
                        }, {
                            "text": "leaf 1.2",
                            "type": "br1"
                        }, {
                            "text": "leaf 1.3",
                            "type": "br1"
                        }],
                        "data": {"some_crap": "yes"}
                    }, {
                        "text": "Branch 2",
                        "type": "branch2",
                        "children": [{
                            "text": "leaf 2.1",
                            "type": "br2"
                        }, {
                            "text": "leaf 2.2",
                            "type": "br2"
                        }, {
                            "text": "leaf 2.3",
                            "type": "br2"
                        }]
                    }]
                },
                "types": {
                    "#": {
                        "valid_children": ["branch"]
                    },
                    "branch1": {
                        "valid_children": ["br1"]
                    },
                    "branch2": {
                        "valid_children": ["br2"]
                    },
                    "br1": {
                        "valid_children": ["br1"]
                    },
                    "br2": {
                        "valid_children": ["br2"]
                    }
                },
                "plugins": ["types", "dnd", "checkbox"]
            });

            $('#jstree').jstree("hide_dots");
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
