<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manage.aspx.cs" Inherits="TreeDemo.manage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Demo - Manage documents</title>
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

		var edit_delete_buttons = "<a class='edit-node jstree-anchor' href='#'><i class='glyphicon glyphicon-pencil'></i></a>&nbsp;<a class='delete-node jstree-anchor' href='#'><i class='glyphicon glyphicon-trash'></i></a>";
		var undelete_buttons = "<a class='undelete-node jstree-anchor' href='#'><i class='glyphicon glyphicon-ban-circle'></i></a>";


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
						else if (obj.classList.contains("undelete-node")) {

							custom_undelete_node(node);

							return;

						}
						else
							parent.select_node.call(this, obj, e);
					}
				};

			};
		})(jQuery);


		function custom_undelete_node(node) {

			var ref = $('#jstree').jstree(true);

			var n = ref.get_node(node.id);

			n.li_attr.class = "node-child";
			n.data["Archived"] = false;


			$("#" + node.id).children().remove("a.undelete-node");

			node.classList.remove("node-added");

			ref.redraw();
		}

		function custom_delete_node(node) {

		    var ref = $('#jstree').jstree(true);

		    var n = ref.get_node(node.id);

		    n.li_attr.class = "node-child node-added";

		    n.data ["Archived"] = true;

		    $("#" + node.id).children().remove("a.delete-node").remove("a.edit-node");

		    node.classList.add("node-added");

		    ref.redraw();

		    //var ref = $('#jstree').jstree(true);

			//ref.delete_node(node);

			//ref.redraw();

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
				$(".node-child").not(".node-added").append(edit_delete_buttons);
				$(".node-added").append(undelete_buttons);
			});


			
			$('#jstree').on('rename_node.jstree', function (e, data) {

				$("#" + data.node.id).append(edit_delete_buttons);

			});

			$('#jstree').on('redraw.jstree', function (e, data) {

				//append delete and edit buttons
				$(".node-child").not(".node-added").each(function () {
					
					if ($(this).children("a.edit-node").length == 0 && $(this).children("a.delete-node").length == 0)
					{
						$(this).append(edit_delete_buttons);

					}

				});

				$(".node-added").each(function () {

					if ($(this).children("a.undelete-node").length == 0) {

						$(this).append(undelete_buttons);

					}

				});

			});

			$('#jstree').on('after_open.jstree', function (e, data) {

				//append delete and edit buttons
				$(".node-child").not(".node-added").each(function () {

					if ($(this).children("a.edit-node").length == 0 && $(this).children("a.delete-node").length == 0) {

						$(this).append(edit_delete_buttons);

					}

				});

				$(".node-added").each(function () {

					if ($(this).children("a.undelete-node").length == 0) {

						$(this).append(undelete_buttons);

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
				//'contextmenu': {
				//	'items': customMenu
				//},
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
				"plugins": ["types", "dnd", "conditionalselect"]
			});

			$('#jstree').jstree("hide_dots");



			$("#export_data").on("click", function(){

				var data = $("#jstree").jstree(true).get_json('#', { 'flat': true, 'no_li_attr': true, 'no_a_attr': true });

				var result = new TreeDataResult(data, "test");

				$("#result").html(JSON.stringify(result, null, '\t'));

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


		});


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