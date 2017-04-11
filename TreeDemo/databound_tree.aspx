<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="databound_tree.aspx.cs" Inherits="TreeDemo.databound_tree" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Demo - databound</title>
	<link href="Content/bootstrap.css" rel="stylesheet" />
	<link href="Content/jsTree/themes/default/style.css" rel="stylesheet" />

	<style type="text/css">
		.node-added{
			color:red;
		}

		.node-added a{
			text-decoration:line-through !important;
		}

	</style>
	
	<script src="Scripts/jquery-1.9.1.js"></script>
	<script src="Scripts/bootstrap.js"></script>
	<script src="Scripts/jstree.js"></script>


	<script type="text/javascript">

		// conditional select
		(function ($, undefined) {
			"use strict";
			$.jstree.defaults.conditionalselect = function () { return true; };
			$.jstree.plugins.conditionalselect = function (options, parent) {

				//this.activate_node = function (obj, e) {
				//    if (this.settings.conditionalselect.call(this, this.get_node(obj))) {
				//        parent.activate_node.call(this, obj, e);
				//    }
				//};

				this.select_node = function (obj, e) {
					if (this.settings.conditionalselect.call(this, this.get_node(obj))) {

						var node = obj.parentNode;


						if (obj.classList.contains("delete-node"))
						{
							custom_delete_node(node);

							return;
						}
						else if(obj.classList.contains("edit-node"))
						{
						    custom_edit_node(node);

						    return;

						}
						else
							parent.select_node.call(this, obj, e);
					}
				};

			};
		})(jQuery);


		function custom_delete_node(node) {
			var ref = $('#jstree').jstree(true);
			ref.delete_node(node);
			ref.redraw();
		}

		function custom_edit_node(node) {
		    var ref = $('#jstree').jstree(true);
		    ref.edit(node);
		}


		/*

						function demo_create() {
							var ref = $('#jstree_demo').jstree(true),
								sel = ref.get_selected();
							if(!sel.length) { return false; }
							sel = sel[0];
							sel = ref.create_node(sel, {"type":"file"});
							if(sel) {
								ref.edit(sel);
							}
						};
						function demo_rename() {
							var ref = $('#jstree_demo').jstree(true),
								sel = ref.get_selected();
							if(!sel.length) { return false; }
							sel = sel[0];
							ref.edit(sel);
						};
						function demo_delete() {
							var ref = $('#jstree_demo').jstree(true),
								sel = ref.get_selected();
							if(!sel.length) { return false; }
							ref.delete_node(sel);
						};

		*/


		//$('#jstree_div')
		//      .on('changed.jstree', treeChanged)
		//      .on('loaded.jstree', treeLoaded)
		//      .jstree({
		//          'plugins': ["checkbox"],
		//          'core': {
		//              'data': {
		//                  'url': '/xmldata/getcategories'
		//              }
		//          }
		//      });

		//function treeLoaded(event, data) {
		//    data.instance.select_node(['2', '5']); //node ids that you want to check
		//}


		$(function () {
			//$.jstree.defaults.core.themes.variant = "large";

			$.jstree.defaults.contextmenu.select_node = false;
   
	
			$('#jstree').on('ready.jstree', function (e, data) {
				data.instance.open_node('1', null, true);
				data.instance.open_node('2', null, true);
				data.instance.open_node('3', null, true);

				//append delete and edit buttons
				$(".node-child").append("<a class='edit-node jstree-anchor' href='#'><i class='glyphicon glyphicon-pencil'></i></a>&nbsp;<a class='delete-node jstree-anchor' href='#'><i class='glyphicon glyphicon-trash'></i></a>");
			});


			
			$('#jstree').on('rename_node.jstree', function (e, data) {

			    $("#" + data.node.id).append("<a class='edit-node jstree-anchor' href='#'><i class='glyphicon glyphicon-pencil'></i></a>&nbsp;<a class='delete-node jstree-anchor' href='#'><i class='glyphicon glyphicon-trash'></i></a>");
			    //console.log("");
			});

			$('#jstree').on('redraw.jstree', function (e, data) {

				//append delete and edit buttons
				$(".node-child").each(function(){
					
					if ($(this).children("a.edit-node").length == 0 && $(this).children("a.delete-node").length == 0)
					{
						$(this).append("<a class='edit-node jstree-anchor' href='#'><i class='glyphicon glyphicon-pencil'></i></a>&nbsp;<a class='delete-node jstree-anchor' href='#'><i class='glyphicon glyphicon-trash'></i></a>");

					}

				});

			});
			

			//$('#jstree').on('create_node.jstree', function (e, data) {
			//	console.log(node);
			//});

			//$('#jstree').on("select_node.jstree", function (e, data) {
			//    alert("node_id: " + data.node.id);
			//});

			//$('#jstree').on("changed.jstree", function (e, data) {
			//    alert("node_id: " + data.node.id);
			//});

			



			$('#jstree').jstree({
				//"conditionalselect": function (node) {
				//    return node.text === "Dogs" ? false : true;
				//},
				'contextmenu': {
					'items': customMenu
				},
				"core": {
					"check_callback": true,
					"data": {
							  'url': '/api/tree/get'
							}

				},
				"types": {
					"#": {
						"valid_children": [],
					},

					"1": {
						"valid_children": [],
						"icon": "glyphicon glyphicon-flash"
					},
					"2": {
						"valid_children": ["large-dogs-child"],
						"icon": "glyphicon glyphicon-picture"
					},
					"5": {
						"valid_children": [],
						"icon": "glyphicon glyphicon-globe"
					},
					"3": {
						"valid_children": ["small-dogs-child"],
						"icon": "glyphicon glyphicon-plane"
					},
					"4": {
						"valid_children": [],
						"icon": "glyphicon glyphicon-tower"
					}



				},
				"plugins": ["types", "dnd", "checkbox", "contextmenu", "conditionalselect"]
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

			$("#export_data").on("click", function(){

				var data = $("#jstree").jstree(true).get_json('#', { 'flat': true, 'no_li_attr': true, 'no_a_attr': true });

				var result = new TreeDataResult(data, "test");

				$("#result").html(JSON.stringify(result));

				$.ajax({
					type: "POST",
					headers: {
						'Accept': 'application/json',
						'Content-Type': 'application/json'
					},
					url: "api/tree/post",
					data: JSON.stringify(result)
				});

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


		function TreeDataResult(data, name)
		{
			var self = this;

			self.nodeList = data;
			self.stateName = name;
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
	<%--			<div class="col-lg-3 col-lg-offset-1">
					<button id="delete_node" type="button">Delete selected node(s)</button>
				</div>
				<div class="col-lg-3">
					<button id="rename_node" type="button">Rename selected node</button>
				</div>--%>

				<div class="col-lg-3 col-lg-offset-1">
					<button id="export_data" type="button"><i class="glyphicon glyphicon-cog"></i>Export tree data</button>
				</div>
			</div>

			<div class="row" style="margin-top:30px;">
				<div class="col-lg-11 col-lg-offset-1">
					<pre id="result"></pre>
				</div>
			</div>

		</div>
	</form>



</body>
</html>