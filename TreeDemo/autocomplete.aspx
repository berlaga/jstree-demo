<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="autocomplete.aspx.cs" Inherits="TreeDemo.autocomplete" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Autocomplete example</title>

    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/themes/base/jquery-ui.css" rel="stylesheet" />

    <script src="Scripts/jquery-1.12.4.js"></script>
    <script src="Scripts/jquery-ui-1.12.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>

    <style>
        .ui-autocomplete {
            max-height: 200px;
            overflow-y: auto;
            /* prevent horizontal scrollbar */
            overflow-x: hidden;
        }
 
    </style>


    <script type="text/javascript">

        $(function () {
            var availableTags = [
                 "ActionScript",
                 "AppleScript",
                 "Asp",
                 "BASIC",
                 "C",
                 "C++",
                 "Clojure",
                 "COBOL",
                 "ColdFusion",
                 "Erlang",
                 "Fortran",
                 "Groovy",
                 "Haskell",
                 "Java",
                 "JavaScript",
                 "Lisp",
                 "Perl",
                 "PHP",
                 "Python",
                 "Ruby",
                 "Scala",
                 "Scheme"
            ];

            $("#autocomplete").autocomplete({
                autoFocus: true,
                delay: 200,
                minLength: 2,
                source: availableTags,
                select: SelectionMade
            });

            $("#categories").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "api/autocomplete/get/" + encodeURI(request.term),
                        type: 'GET',
                        cache: false,
                        data: request,
                        dataType: 'json',
                        success: function (data) {
                            response($.map(data, function (item) {
                                return { value: item.value, label: item.label }
                            }))
                        },
                        //success: function (data) {
                        //    //return response(data);

                        //},
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            //alert('error - ' + textStatus);
                            console.log('error', textStatus, errorThrown);
                        }
                    });
                },
                minLength: 2,
                autoFocus: true,
                delay: 200,
                select: function (event, ui) {
                    event.preventDefault();
                    $(this).val(ui.item.label);

                    log("Selected: " + ui.item.value + " | " + ui.item.label);
                }
            });


        });


        function SelectionMade(event, ui) {
            console.log(ui);
            $("#selected_value").html("Label: <b>" + ui.item["label"] + "</b>&nbsp;Value: <b>" + ui.item["value"] + "</b>");
        }


 
        function log(message) {
            $("<div>").text(message).prependTo("#log");
            $("#log").scrollTop(0);
        }

    </script>


</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row" style="margin-top: 50px;">
                <div class="col-md-5 ui-widget">
                    <label for="autocomplete">Programming language</label>
                    <input id="autocomplete" class="form-control" placeholder="minimum 2 characters required" />
                </div>
                <div class="col-md-3 ui-widget" style="display: block; margin-top: 27px;">
                    <span id="selected_value"></span>
                </div>

            </div>


          <div class="row" style="margin-top: 50px;">

               <div class="col-md-5 ui-widget">
                    <label for="categories">Categories: </label>
                    <input id="categories" class="form-control" placeholder="minimum 2 characters required" />
                </div>

                <div class=" col-md-5 ui-widget" style="margin-top: 2em; font-family: Arial">
                    Result:
                    <div id="log" style="height: 200px; width: 300px; overflow: auto;" class="ui-widget-content">

                    </div>
                </div>
            </div>
            
        </div>

    </form>
</body>
</html>
