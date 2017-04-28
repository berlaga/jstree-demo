<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manage.aspx.cs" Inherits="TreeDemo.manage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Demo - Manage documents</title>

	<link href="Content/bootstrap.css" rel="stylesheet" />
	<link href="Content/jsTree/themes/default/style.css" rel="stylesheet" />
	<link href="Content/themes/base/jquery-ui.css" rel="stylesheet" />

	<style type="text/css">
		.node-added {
			color: red;
		}

			.node-added a {
				text-decoration: line-through !important;
			}
	</style>

	<script src="Scripts/jquery-1.12.4.js"></script>
	<script src="Scripts/jquery-ui-1.12.1.js"></script>
	<script src="Scripts/bootstrap.js"></script>
	<script src="Scripts/jstree.js"></script>


	<script type="text/javascript">

		var edit_delete_buttons = "<a class='edit-node jstree-anchor' href='#'><i class='glyphicon glyphicon-pencil'></i></a>&nbsp;<a class='delete-node jstree-anchor' href='#'><i class='glyphicon glyphicon-trash'></i></a>&nbsp;<a class='change-node jstree-anchor' href='#'><i class='glyphicon glyphicon-random'></i></a>";
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


						if (obj.classList.contains("delete-node")) {
							custom_delete_node(node);

							return;
						}
						else if (obj.classList.contains("change-node")) {
							custom_change_node(node);

							return;
						}
						else if (obj.classList.contains("edit-node")) {
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


		function custom_change_node(node) {

			var ref = $('#jstree').jstree(true);
			var n = ref.get_node(node.id);
			var parent = ref.get_node(n.parent);

			$("#dialogSelectCategory").data('type', parent.type);

			$("#dialogSelectCategory").dialog("open");

		}

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

			n.data["Archived"] = true;

			$("#" + node.id).children().remove("a.delete-node").remove("a.edit-node").remove("a.change-node");

			node.classList.add("node-added");

			ref.redraw();

		}

		function custom_edit_node(node) {
			var ref = $('#jstree').jstree(true);
			ref.edit(node);
		}




		$(function () {

			var bootstrapButton = $.fn.button.noConflict() // return $.fn.button to previously assigned value
			$.fn.bootstrapBtn = bootstrapButton            // give $().bootstrapBtn the Bootstrap functionality

			/*dialog date picker begins*/
			$("#dialogSelectCategory").dialog({
				title: "Select type",
				autoOpen: false,
				modal: true,
				resizable: false,
				appendTo: '.container',
				close: onDialogClose,
				open: onDialogOpen,
				position: { my: "center", at: "center", of: "#jstree" }
			});


			function onDialogClose() {

			}

			function onDialogOpen() {

			    var type = $(this).data('type');

			    $(this).find("select#types").val(type);
			}




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
						"valid_children": ["5"],
						"icon": "glyphicon glyphicon-picture"
					},
					"5": {
						"valid_children": [],
						"icon": "glyphicon glyphicon-globe"
					},
					"3": {
						"valid_children": ["4"],
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



			$("#change_group").on("click", function () {

				var instance = $('#jstree').jstree(true);

				var node = instance.get_node("13");
				var node_parent = instance.get_node("2");

				if (node) {
					node.type = "5";
					//var id = $("#jstree").jstree('move_node', node.id, node_parent.id);
					var id = instance.move_node(node, node_parent, 'last', null, true, false)

				}

				instance.redraw();
			});



			$("#export_data").on("click", function () {

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


		function TreeDataResult(data, name) {
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
					<a class="navbar-brand" href="#">jsTree demo</a>
					<div class="navbar-header">
					</div>
				</div>
			</nav>
			<div class="row">

				<div class="col-lg-5 col-lg-offset-1">
					<div id="jstree"></div>
				</div>
			</div>

			<div class="row" style="margin-top: 40px;">

				<div class="col-lg-3 col-lg-offset-1">
					<button id="export_data" type="button"><i class="glyphicon glyphicon-cog"></i>Export tree data</button>
				</div>
				<div class="col-lg-3 col-lg-offset-1">
					<button id="change_group" type="button"><i class="glyphicon glyphicon-cog"></i>Change group</button>
				</div>

			</div>

			<div class="row" style="margin-top: 30px;">
				<div class="col-lg-11 col-lg-offset-1">
					<pre id="result"></pre>
				</div>
			</div>

		</div>
	</form>


	<!-- dialog -->
	<div id="dialogSelectCategory" style="display: none; width: 430px;">
		<div>
			<div class="col-lg-2">
				<select id="types">
				   <option value="2">Large</option>
				   <option value="3">Small</option>
				   <option value="100">Work breeds</option>
				   <option value="200">Guard dogs</option>
				</select>
			</div>
		</div>
	</div>
	<!-- dialog -->

</body>
</html>
