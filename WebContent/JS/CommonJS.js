 function checkUsernameAndPassword()
    {
    	var username = document.getElementById("username").value.trim();
    	var password = document.getElementById("password").value.trim();
    	
    	if(username == null || username == "")
    		{
    			alert("Enter valid Username");
    			return false;
    		}
    	else if(password == null || password == "")
    		{
    			alert("Enter valid Password");
    			return false;
    		}
    	else
    		{
    			if(checkInputFields())
    				{
    					return true;
    				}
    			else
    				{
    					return false;
    				}
    		}
    }
 
function checkInput(input)
 	{	
		if(input.trim() == null || input.trim() == "")
		{
			alert("Enter valid input");
			return false;
		}
 	}

function makeReadOnly()
	{
		var selected = document.getElementById("Database").value;
		if(selected == "Access")
			{
				document.getElementById("DatabaseName").readOnly = "readonly";	
				document.getElementById("ServerURL").readOnly = "readonly";
				document.getElementById("Port").readOnly = "readonly";
				document.getElementById("DatabaseName").style.backgroundColor = "#C0C0C0";		
				document.getElementById("ServerURL").style.backgroundColor = "#C0C0C0";		
				document.getElementById("Port").style.backgroundColor = "#C0C0C0";	
				document.getElementById("DBUsername").style.backgroundColor = "#C0C0C0";	
				document.getElementById("DBPassword").style.backgroundColor = "#C0C0C0";	
				document.getElementById("DatabaseName").required = false;
				document.getElementById("ServerURL").required = false;
				document.getElementById("Port").required = false;
				document.getElementById("DBUsername").required = false;
				document.getElementById("DBPassword").required = false;
			}
		else if(selected=="MySQL")
			{
				document.getElementById("DatabaseName").readOnly = "";	
				document.getElementById("ServerURL").readOnly = "";
				document.getElementById("Port").readOnly = "";
				document.getElementById("DBUsername").readOnly = "";
				document.getElementById("DBPassword").readOnly = "";	
				document.getElementById("DatabaseName").style.backgroundColor = "#ffffff";		
				document.getElementById("ServerURL").style.backgroundColor = "#ffffff";		
				document.getElementById("Port").style.backgroundColor = "#ffffff";
				document.getElementById("DBUsername").style.backgroundColor = "#ffffff";
				document.getElementById("DBPassword").style.backgroundColor = "#ffffff";
				document.getElementById("DatabaseName").required = true;
				document.getElementById("ServerURL").required = true;
				document.getElementById("Port").required = true;
				document.getElementById("DBUsername").required = true;
				document.getElementById("DBPassword").required = true;
			}
	}

function loadAdminActiveScreen(href)
	{	
		$.ajax({
			  type: "GET",
			  url: "/Choice/JSP/DatabaseJSP/setAdminPreURL.jsp",
			  data: {value: href },
			}).done(function(result) {
			});
	
		
		if(href != null && href != '' && href.trim() != '' && href != '#')
			{ 
				$('#adminActiveScreen').load(href);
			}
		
		return false;
	}

function loadAdminActiveScreenBack()
{	
	$.ajax({
		  type: "GET",
		  url: "/Choice/JSP/DatabaseJSP/getAdminPreURL.jsp",
		  dataType: "text",
		}).done(function(href) {
			if(href.trim() != '')
			{
				$('#adminActiveScreen').load(href);
			}
		});
	
	return false;
}

function loadAdminActiveScreenForward()
{	
	$.ajax({
		  type: "GET",
		  url: "/Choice/JSP/DatabaseJSP/getAdminForwardURL.jsp",
		  dataType: "text",
		}).done(function(href) {
			if(href.trim() != '')
				{
					$('#adminActiveScreen').load(href);
				}
		});
	
	return false;
}

function loadAdminActiveScreenObject(href)
{
	if(href != null && href != '' && href.trim() != '' && href != '#')
		{ 
			$('.adminActiveScreen').html($('<object>').attr({'data':href,'type':'text/html'}));
		}
	return false;
}


function loadClientActiveScreen(href)
{	
	$.ajax({
		  type: "GET",
		  url: "/Choice/JSP/DatabaseJSP/setClientPreURL.jsp",
		  data: {value: href },
		}).done(function(result) {
		});
	
	if(href != null && href != '' && href.trim() != '' && href != '#')
		{
			$('#clientActiveScreen').load(href);
		}
	
	return false;
}

function loadClientActiveScreenBack()
{	
	$.ajax({
		  type: "GET",
		  url: "/Choice/JSP/DatabaseJSP/getClientPreURL.jsp",
		  dataType: "text",
		}).done(function(href) {
			if(href.trim() != '')
			{
				$('#clientActiveScreen').load(href);
			}
		});
	
	return false;
}

function loadClientActiveScreenForward()
{	
	$.ajax({
		  type: "GET",
		  url: "/Choice/JSP/DatabaseJSP/getClientForwardURL.jsp",
		  dataType: "text",
		}).done(function(href) {
			if(href.trim() != '')
				{
					$('#clientActiveScreen').load(href);
				}
		});
	
	return false;
}
function confirmAndforward(href)
	{
		var check = confirm('Do you want to continue?');	
		if(check)
			{
				$('#adminActiveScreen').load(href);
			}
	}

function checkForNumber(inputValue)
{
	if(isNaN(inputValue))
		{
			alert("Please enter only numbers!");
			return false;
		}
	else
		{
			return true;
		}
}


function showProgress()
{
    $('#progressBar').show();
}

function checkInputFields()
{
	var check = "true";
	var eachValue;
	var values = {};
	$("form :input").each(function() {
			eachValue = $(this).val();
			if(eachValue.indexOf("alert(") > -1)
				{
					check = "false";
				}
			else if(eachValue.indexOf("<") > -1)
				{
					check = "false";
				}
			else if(eachValue.indexOf("/>") > -1)
				{
					check = "false";
				}
	    });
	if(check == "false")
		{
			alert("Please check input fields!!");
			return false;
		}
	
	return true;
}