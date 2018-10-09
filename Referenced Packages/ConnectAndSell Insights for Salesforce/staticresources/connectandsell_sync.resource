function loadHeader(channel) {
    if (channel != "")
        connect(channel);
}

function getChannelName(channel) {
    return '/' + channel;
}



function connect(channel) {
    console.log('inside connect');
    channel = getChannelName(channel);

    client.setAutoDisconnect({
        synchronous: true,
        meta: 'autoDisconn'
    });

    client.bind({
        record: {
            key: 'username',
            value: channel
        },
        onSuccess: function () {
            if (window.debugOn == 'true') {
                console.log('Bound Username to WebSync record.');
            }
        },
        onFailure: function (e) {
            if (window.debugOn == 'true') {
                console.log('Could not bind to record (' + e.getException().message + ').');
            }
        }
    });

    client.connect({
        onSuccess: function (e) {
            if (window.debugOn == 'true') {
                console.log('Client Connected');
            }
        },
        onFailure: function (e) {
            if (window.debugOn == 'true') {
                console.log('websync failure:' + e.getException().message);
            }
        },
        onStreamFailure: function (e) {
            if (window.debugOn == 'true') {
                console.log('The client could not stream...' + e.getException().message);
            }
        }
    });
    
    client.subscribe({
        channel: channel,
        onSuccess: function (e) {
            if (window.debugOn == 'true') {
                console.log('Subscribed to channel:' + e.getChannel());
            }
            if(validateIfLeadConnected()) {
                console.log("Inside On Call Refresh load");
                $.ajax({
                    url: baseUrl + 'Campaign/NativeConnectOnCall',
                    xhrFields : {
                    withCredentials : true
                    },
                    type: "POST",
                });
                //localStorage.setItem("IsLeadConnected", "false");
            }
        },
        onFailure: function (e) {
            if (window.debugOn == 'true') {
                console.log('The client could not subscribe to ' + channel + '... ' + e.getException().message);
            }
        },
        onReceive: function (e) {
            var data = e.getData();
            var msgType = data.type;
            if (window.debugOn == 'true') {
                console.log(new Date + ' Received data: ' + fm.json.serialize(e.getData()));
            }
            switch (msgType) {
                case 'Call':
                    console.log('inside call');
                    currentLeadId = data.leadId;
                    displayCall(data);
                    var date = new Date();
                    var day = date.getUTCDate();        // yields day
                    var month = date.getUTCMonth()+1;    // yields month
                    var year = date.getUTCFullYear();  // yields year
                    var hour = date.getUTCHours();     // yields hours 
                    var minute = date.getUTCMinutes(); // yields minutes
                    var second = date.getUTCSeconds(); // yields seconds
                    var milliSec = date.getUTCMilliseconds(); //yields milliseconds
                    // After this construct a string with the above results as below
                    var time = day + "/" + month + "/" + year + " " + hour + ':' + minute + ':' + second + '.' + milliSec;
                    break;
                case 'Status':
                    if(validateIfUserLoggedIn()){
                        if(data.buttonText == 'GO'){
                            $('#networkStatus').html('Connected');
                            if(sessionLoaded){
                                ShowDialBtn();
                                $('#alertArea').html('Session Paused. Click Dial to Continue.');  
                            }
                        }
                        else if(data.buttonText == 'Pause'){
                            $('#networkStatus').html('Connected');
                            if(sessionLoaded){
                                ShowPauseBtn();
                            }
                        }
                        else
                        {
                            $('#networkStatus').html('Disconnected');
                        }
                    }
                    break;
                
                case 'CallPopDetails':
                    populateLeadInfo(data);
                    $('#alertArea').html("On Call with <strong>" + data.FirstName + "</strong>");
                    break;
                case 'NativeSFDCAlert':
                    console.log('inside NativeSFDCAlert');
                    console.log(data);
                    $('#alertAreaDiv').removeClass('alert-danger');
                    $('#alertAreaDiv').addClass('alert-success');
                    PauseBtnClick();
                    break;  
                case 'HotTransferCallStatus':
                    if ($('#hotTransferCallStatus') != null) {
                        if (data.statusCode != 1) {
                            $('#hotTransferCallStatus').removeClass("call-connected");
                            $('#hotTransferCallStatus').addClass("call-not-connected");
                            $('#completeHotTransferBtn').hide();
                            $('#conferenceHotTransferBtn').hide();
                            $('#resetHotTransferBtn').hide();
                            if ($('#alertArea').text() == onHoldTextStr) {
                                $('#alertArea').text('Connected');
                            }
                            currentHotTransferState = 1;
                            console.log("Current Hot transfer state:" + currentHotTransferState);
                        }
                        else {
                            $('#hotTransferCallStatus').addClass("call-connected");
                            $('#hotTransferCallStatus').removeClass("call-not-connected");
                            $('#completeHotTransferBtn').show();
                            $('#conferenceHotTransferBtn').show();
                            currentHotTransferState = 3;
                            console.log("Current Hot transfer state:" + currentHotTransferState);
                        }
                        $('#hotTransferCallStatus').text(data.message);
                    }
                    break;
            }
        }
    });
}


function displayCall(call){
    $('#alertAreaDiv').addClass('alert-success');   
    $('#alertAreaDiv').removeClass('alert-danger');
    $('#alertArea').html("Transferring <strong>" + call.name + ", " + call.jobTitle + " at " + call.companyName + "</strong>");
}

function populateLeadInfo(data) {
    window.onPhone = true;
	$('#SendEmailButton').prop("disabled", false);
    $('#leadname').html(data.FirstName + ' ' + data.LastName);
    $('#leadcompanyname').html(data.CompanyName);
    $('#leadphone').html(data.PrimaryNumber);
    $('#leademail').html(data.Email);
	$('#leadCrm').val(data.CrmId);
    $('#ContactId').html(data.ContactId);
    $('#CalllistId').html(data.CalllistId);
    $('#ClientName').html(data.ClientName);
    $('#numpadInput').show();
    $('#hangUp').show();
    $('#hangUp').prop("disabled", false);
    $('#redial').show();
    $('#redial').prop("disabled", true);
    $('#initiateHotTransferBtn').prop("disabled", false);
    $('#dropVoicemailButton').prop("disabled", false);

    $('.disposeCall').show();
    $("#pauseSessionBtn").hide();
    $('#pauseAndDisposeSessionBtn').show();
    $("#numpadInput").val(data.PrimaryNumber);
    $('#initiateHotTransferBtn').prop("disabled", false);
    $('#statusDropdown').val('');
    localStorage.setItem("startTalkTime", new Date());
    $('#statusDropdown').val('');
    if(validateIfLeadConnected())
    {
        ShowPauseBtn();
    }
    localStorage.setItem("IsLeadConnected", "true");
    $("#accordion").accordion({
        collapsible: true,
        header: "h3",
        active: $('#accordion h3').index($('.accordionLeadInfo')),
        heightStyle: "content"
    });
    $.each(data.DispositionList, function(objectCount) {
        $("#dispositionDropdown").append(
            $('<option></option>').val(data.DispositionList[objectCount].CompanyDispositionId).html(data.DispositionList[objectCount].DispositionText)
        );
    });
}

function HangUpBtnClk(){
    window.onPhone = false;
    localStorage.setItem("startWrapTime", new Date());
    onPhone = false;
    $.ajax({
        url: baseUrl + 'Campaign/HangUpPhone',
        xhrFields : {
          withCredentials : true
        },
        type: "POST"
    });
    $('#hangUp').prop("disabled", true);
    $('#redial').prop("disabled", false);
    $('#initiateHotTransferBtn').prop("disabled", true);
    $('#dropVoicemailButton').prop("disabled", true);
    $('#alertAreaDiv').removeClass('alert-success');   
    $('#alertAreaDiv').addClass('alert-danger');
    $('#alertArea').html("Call Ended.");
}

function RedialBtnClk(){
    $('#dropVoicemailButton').prop("disabled", false);
    $('#alertAreaDiv').addClass('alert-success');   
    $('#alertAreaDiv').removeClass('alert-danger');
    $('#initiateHotTransferBtn').prop("disabled", false);
    $('#alertArea').html("Redialling...");
    $.ajax({
        url: baseUrl + 'Campaign/RedialPhone',
        xhrFields : {
          withCredentials : true
        },
        data: {contactId: $('#ContactId').html() ,phoneNumber: $('#numpadInput').val()},
        type: "POST",
        success: function(){
            $('#alertAreaDiv').addClass('alert-success');   
            $('#alertAreaDiv').removeClass('alert-danger');
            $('#alertArea').html("Call Connected");
            $('#hangUp').prop("disabled", false);
            $('#redial').prop("disabled", true);
        }
    });
};

function DisposeBtnClk(pauseSession){
    if (window.onPhone) {
        HangUpBtnClk();
    }
    if ($("#dispositionDropdown").val() == "Select Disposition")
    {
        $('#alertAreaDiv').addClass('alert-danger');
        $('#alertAreaDiv').removeClass('alert-success');
        $('#alertArea').html('Select Disposition');
        $("#accordion").accordion({
            collapsible: true,
            header: "h3",
            active: $('#accordion h3').index($('.accordionCallInfo')),
            heightStyle: "content"
        });
        return false;
    }

    if($("#nextCallDatepicker").datepicker('getDate') != null && $('#teleprompter').val() == ''){
        $('#alertAreaDiv').removeClass('alert-success');   
        $('#alertAreaDiv').addClass('alert-danger');
        $('#alertArea').html('Teleprompter is required.');
        $("#accordion").accordion({
            collapsible: true,
            header: "h3",
            active: $('#accordion h3').index($('.accordionCallNotes')),
            heightStyle: "content"
        });

        return false;
    }
    $('#alertAreaDiv').addClass('alert-success');   
    $('#alertAreaDiv').removeClass('alert-danger');
    $('#alertArea').html('Disposing...');
    var callStartTime = Date.parse(localStorage.getItem("startTalkTime"));
    var callhungUpTime = Date.parse(localStorage.getItem("startWrapTime"));
    var callDisposeTime = new Date();
    var talktime =  (callhungUpTime - callStartTime)/1000;
    var WrapTime =  (callDisposeTime.getTime() - callStartTime)/1000;
    $.ajax({
        url: baseUrl + 'Campaign/NativeSFDCDisposeCall',
        xhrFields : {
          withCredentials : true
        },
        type: "POST",
        data: {ContactId: $('#ContactId').html() ,CalllistId: $('#CalllistId').html() ,NextCall: $('#nextCallDatepicker').val(), CallAfterTime: $('#nextCallTimepicker').val(), Phone1: $('#leadphone').html(), Disposition: $("#dispositionDropdown").val(), NewStatus: $("#statusDropdown").val(), NewNextSteps: $('#teleprompter').val(), NewNote: $('#callnotes').val(), PauseSession: pauseSession, TalkTime: talktime, WrapTime: WrapTime, Phone1: $('#numpadInput').val()},
        success: function() {
            resetCallInfo();
            $('#alertArea').html('Call Disposed');
            localStorage.setItem("IsLeadConnected", "false");
            localStorage.setItem("IsLeadLoaded", "false");
            if(pauseSession){
                ShowDialBtn();
            }
        }
    });
}

function validateIfUserLoggedIn(){
    if (localStorage.getItem("IsCASLoggedIn")=="true")
        return true;
    else
        return false;
}

function resetCallInfo(){
    $('#numpadInput').hide();
    $('#hangUp').hide();
    $('#redial').hide();
    $('.disposeCall').hide();
    $("#pauseSessionBtn").show();
    $("#pauseAndDisposeSessionBtn").hide();
    $('#leadname').html('N/A');
    $('#leadcompanyname').html('N/A');
    $('#leadphone').html('N/A');
    $('#leademail').html('N/A');
    $('#ContactId').html('');
    $('#CalllistId').html('');
    $("#numpadInput").val('');
    $("#dispositionDropdown").val("Select Disposition");
    $('#teleprompter').val('');
    $('#callnotes').val('');
    $("#nextCallDatepicker").datepicker('setDate', null);
    localStorage.removeItem("startTalkTime");
    localStorage.removeItem("startWrapTime");
}

function validateIfLeadConnected(){
    if (localStorage.getItem("IsLeadConnected")=="true")
        return true;
    else
        return false;
}

function initiateHotTransferBtnClick() {
    var number = $('#HotTransferNumber').val();
    $('#cancelHotTransferBtn').show();
    if ($('#HotTransferNumber').val() != null && $('#HotTransferNumber').val() != '') {
        $.ajax({
            url: baseUrl + 'Campaign/DoHotTransfer',
            xhrFields : {
              withCredentials : true
            },
            data: { requestType:"InitiateTransfer", phoneNumber: number, ClientName: $('#ClientName').html() },                        
            type: 'POST',
            success: function (result) {
                if (result.status === true) {
                    $('#hotTransferCallStatus').text('Dialing');
                    $("#alertArea").html(onHoldTextStr);
                    $('#hotTransferCallStatus').removeClass("call-not-connected");
                    $("#hotTransferCallStatus").addClass("call-connected");
                    $('#initiateHotTransferBtn').prop("disabled", true);
                    $('#HotTransferNumber').removeClass('input-validation-error');
                    $('#hotTransferNumberError').text('');
                    window.currentHotTransferState = 2;
                }
                else {
                    $('#HotTransferNumber').addClass('input-validation-error');
                    $('#hotTransferNumberError').text(result.message);
                }
            }
        });
    }
    else {
        $('#HotTransferNumber').addClass('input-validation-error');
        $('#hotTransferNumberError').text('Please select an available target or enter a phone number (eg:. +15125555555)');
    }
};
function completeHotTransferBtnClick() {
    window.onPhone = false;
    $('#hangUp').prop("disabled", false);
    $('#initiateHotTransferBtn').prop("disabled", false);
    $('#cancelHotTransferBtn').hide();
    $('#completeHotTransferBtn').hide();
    $('#conferenceHotTransferBtn').hide();
    $('#pauseBtn').text("Pause");
    $("#alertArea").html(hotTransferTextStr);
    window.currentHotTransferState = 5;
    $.ajax({
        url: baseUrl + 'Campaign/DoHotTransfer',
        xhrFields : {
          withCredentials : true
        },
        data: { requestType:"CompleteTransfer", phoneNumber: "", ClientName: $('#ClientName').html() },
        type: 'POST'
    });
};

function conferenceHotTransferBtnClick() {
    $('#initiateHotTransferBtn').prop("disabled", true);
    $('#completeHotTransferBtn').hide();
    $('#conferenceHotTransferBtn').hide();
    $('#alertArea').text('Connected');
    $('#resetHotTransferBtn').show();
    window.currentHotTransferState = 4;
    $.ajax({
        url: baseUrl + 'Campaign/DoHotTransfer',
        xhrFields : {
          withCredentials : true
        },
        data: { requestType:"ConferencedHandoff", phoneNumber: "", ClientName: $('#ClientName').html() },
        type: 'POST'
    });
};

function resetHotTransferBtnClick() {
    window.onPhone = false;
    $('#initiateHotTransferBtn').prop("disabled", false);
    $('#cancelHotTransferBtn').hide();
    $('#completeHotTransferBtn').hide();
    $('#resetHotTransferBtn').hide();
    $('#conferenceHotTransferBtn').hide();
    //$('#pauseBtn').text("Pause");
    $("#alertArea").html(hotTransferTextStr);
    window.currentHotTransferState = 5;
    $.ajax({
        url: baseUrl + 'Campaign/DoHotTransfer',
        xhrFields : {
          withCredentials : true
        },
        data: { requestType:"ResetConference", phoneNumber: "", ClientName: $('#ClientName').html() },
        type: 'POST'
    });
};

function cancelHotTransferBtnClick() {
if (window.onPhone && window.currentHotTransferState > 1) {
        $("#alertArea").text("Connected");
    }
    if (!window.onPhone && window.currentHotTransferState > 0) {
        $('#redial').show();
    }
    isHotTransferOngoing = false;
    $('#hangUp').prop("disabled", false);
    $('#initiateHotTransferBtn').prop("disabled", false);
    $('#cancelHotTransferBtn').hide();
    $('#completeHotTransferBtn').hide();
    $('#conferenceHotTransferBtn').hide();
    $('#resetHotTransferBtn').hide();
    $('#HotTransferNumber').removeClass('input-validation-error');
    window.currentHotTransferState = 0;
    $.ajax({
        url: baseUrl + 'Campaign/DoHotTransfer',
        xhrFields : {
          withCredentials : true
        },
        data: { requestType:"CancelRequest", phoneNumber: "", ClientName: $('#ClientName').html() },
        type: 'POST'
    });
};

function DropVoicemailClk ()
{
    $.ajax({
        url: baseUrl + 'Campaign/NativeVoicemailDrop',
        data: {id: $(".voicemailDropdown").val()},
        xhrFields : {
          withCredentials : true
        },
        type: "POST",
        success: function(data){
            HangUpBtnClk();
        }
    });
};

function ShowPauseBtn(){
    $('#alertAreaDiv').addClass('alert-danger');
    $('#alertAreaDiv').removeClass('alert-success');
    $("#pauseSessionBtn").show();
    $("#startSessionBtn").hide();
    localStorage.setItem("SessionState", "Dialing");
}

function ShowDialBtn(){
    $('#alertAreaDiv').removeClass('alert-danger');
    $('#alertAreaDiv').addClass('alert-success');
    $("#pauseSessionBtn").hide();
    $("#startSessionBtn").show();
    localStorage.setItem("SessionState", "Pause");
}

function startDialingReportClk()
{
	if(($("#networkStatus").text()=="Disconnected"))
	{
		$('#alertAreaDiv').addClass('alert-danger');
	    $('#alertAreaDiv').removeClass('alert-success');
		$('#alertArea').text('Phone Bridge Disconnected');
	}
	else
	{
		$("#sessionDropdown").prop('disabled', true);
		$('#alertArea').text('Loading Report List');
		$.ajax({
			url: baseUrl + 'Campaign/GetNativeSFDCReport',
			data: {reportId: $("#reportDropdown").val(), reportName: $('#reportDropdown option:selected').html(), sessionType: $('#sessionDropdown').val(), isLeadPoolCall: $('#leadpool').prop("checked")},

			xhrFields : {
			withCredentials : true
			},
			type: "POST",
			success: function(data){
			    if (data.isPhoneConnected) {
			        ShowPauseBtn();
			        $('#alertArea').text('Session Loaded');
			    }
			    else {
					$('#alertAreaDiv').addClass('alert-danger');
					$('#alertAreaDiv').removeClass('alert-success');					
			        $('#alertArea').text('Phone Bridge Disconnected');
			    }
			}
		});
	}
}

function SaveSettings(){
    $.ajax({
        url: baseUrl + 'Account/UpdateCallerIdForNativeSFDC',
        data: {callerId: $('#callerId').val(), localtouchEnabled: $('#localtouch').is(':checked')},
        xhrFields : {
          withCredentials : true
        },
        type: "POST",
        success: function(data){
            $("#settingsDiv").hide();
        }
    });
}
function SettingBtnClk(){
    if(!validateIfUserLoggedIn()){
        $('#settingsBtn').prop('disabled', true);
    }else{
        $('#settingsBtn').prop('disabled', false);
    }
    $("#settingsDiv").toggle();
}

function clearCacheClk(){
    localStorage.removeItem('IsLeadConnected');
    localStorage.removeItem('IsLeadLoaded');
    $("#settingsDiv").hide();
}

function localtouchClk(){
    if($('#localtouch').is(':checked')){
        $('#callerId').prop('disabled', true);
    }
    else{
        $('#callerId').prop('disabled', false);
    }
}

function leadpoolClk(){
    if ($('#leadpool').is(':checked')) {
        if (validateIfUserLoggedIn())
        {
            $('#loadListButton').show();
            $('#loadListButton').prop('disabled', false);
        }
        else
        {
            $('#loadListButton').show();
            $('#loadListButton').prop('disabled', true);
        }
        $('#startDialingButton').prop('disabled', true);
    }
    else{
        $('#loadListButton').hide();
        $('#startDialingButton').prop('disabled', false);
    }
}
function SendEmailClk() {
	var username = sforce.connection.getUserInfo().userName;
	var user = sforce.connection.getUserInfo().userFullName;
	$.ajax({
        url: baseUrl + 'Campaign/SendMailNativeSfdc',
        data: {CrmId : $('#leadCrm').val(),templateId : $('#EmailTemplateDropdown').val(),FromEmailAddress : username,SenderDisplayName : user},
		xhrFields : {
          withCredentials : true
        },
        type: "POST",
        success: function(data){
			
		}
	});
}
function loadListClk(){
    $('.overlay').show();
    startLoader();
    $.ajax({
        url: baseUrl + 'CallList/UpdateNativeSFDCLeadpoolReport',
        data: {reportId: $("#reportDropdown").val(), reportName: $('#reportDropdown option:selected').html()},
        xhrFields : {
          withCredentials : true
        },
        type: "POST",
        success: function(result){
            loaderProgress(100,100);
            $('#alertArea').text(result.data);
            $('#loadListButton').hide();
            $('#startDialingButton').prop('disabled', false);
        }
    });
}

function startLoader(){
    loaderProgress(5, 100);
    ctx = document.getElementById('loader').getContext('2d');
    al = 0;
    start = 4.72;
    cw = ctx.canvas.width;
    ch = ctx.canvas.height;
    x = ctx.canvas.width/2;
    y = ctx.canvas.height/2;
    radius = 25; //radius should be less than x and y points value
    loaderProgress(90, 3500);
}

function loaderProgress(percent, speed){
    var sim;
    sim = setInterval(function(){
        progressSim(percent,sim);
    },speed);
}

function progressSim(limit,sim){
    var diff = ((al / 100) * Math.PI*2*10).toFixed(2);
    ctx.clearRect(0, 0, cw, ch);
    ctx.lineWidth = 10;
    ctx.fillStyle = 'white';
    ctx.strokeStyle = "white";
    ctx.textAlign = 'center';
    ctx.font="12px Verdana";
    ctx.fillText(al+'%', cw*.5, ch*.5+2, cw); 
    ctx.beginPath();
    ctx.arc(x,y,radius, start, diff/10+start, false);
    ctx.stroke();
    if(al >= limit)
    {
        if(al>=100)
        {
            $('.overlay').hide();
        }
        clearTimeout(sim);  
    }  // Add scripting here that will run when progress completes
    al++; 
}

function CallMe(){
   $.ajax({
       url: baseUrl + 'Account/CallMe',
       data: {PhoneNumber: $('#callMe').val(), SaveNumber: false},
       xhrFields : {
         withCredentials : true
       },
       type: "POST",
       success: function(data){
           $("#settingsDiv").hide();
       }
   });
}

function LogOn (){
    $('#alertArea').html('Logging...');
    $.ajax({
        url: baseUrl + 'Account/NativeSFDCLogOn',
        xhrFields : {
          withCredentials : true
        },
        options: {
          crossDomain : true
        },
        data: {crmUserName : username},
        type: "POST",
        success: function(data) {
            if(data.IsLoggedIn == true){
                localStorage.setItem("IsCASLoggedIn", true);
                $('.connectAndSellLogin').hide();
                $('.connectAndSellLogout').show();
                $('#startSessionBtn').hide();
                $("#pauseSessionBtn").hide();
                $("#pauseAndDisposeSessionBtn").hide();
                $('#alertAreaDiv').removeClass('alert-danger');
                $('#alertAreaDiv').addClass('alert-success');
                $('#alertArea').html('Logged In.');
                localStorage.setItem("UserIdentifier", data.Identifier);
                loadHeader(data.Identifier);
                getNativeSfdcSettings();
                fetchVoicemailList();
                populateFolderData();
                populateStatusPickList();
                populatePhoneBridgeDetails();
                populateFolderData();
            }else{
                $('#alertAreaDiv').addClass('alert-danger');
                $('#alertAreaDiv').removeClass('alert-success');
                $('#alertArea').html('CAS Dialer is not enabled for this user');
            }
        }
    });
}

function PauseBtnClick(){
    $.ajax({
        url: baseUrl + 'Campaign/StopSessionForNativeSFDC',
        type: "POST",
        xhrFields : {
          withCredentials : true
        },
        complete: function() {
            ShowDialBtn();
            $('#alertArea').html('Session Paused. Click Dial to Continue.');
        }
    });
}

function fetchVoicemailList(){
    $.ajax({
        url: baseUrl + 'Campaign/GetNativeSFDCVoicemail',
        type: "GET",
        xhrFields : {
          withCredentials : true
        },
        dataType: "json",
        complete: function(data){
            if (data.responseText == "User session is null"){
                LogOn();
            } else {
                $("#voicemailDropdown").empty();
                $.each(data, function(key, value) {
                    $("#voicemailDropdown").append(
                        $('<option></option>').val(value.VoicemailIndex).html(value.Name)
                     );
                });
                getNativeSfdcSettings();
            } 
        }
    });
}

function getNativeSfdcSettings(){
    $.ajax({
        url: baseUrl + 'Account/GetNativeSFDCSettings',
        type: "GET",
        xhrFields : {
          withCredentials : true
        },
        dataType: "json",
        success: function(data){
            if(data.LocaltouchEnabled){
                $('#localtouch').prop('checked', true);
                $('#callerId').prop('disabled', true);
            }else{
                $('#localtouch').prop('checked', false);
                $('#callerId').prop('disabled', false);
            }
            $('#callerId').val(data.CallerId);
            if(data.IsHotTransferEnabled)
            {
                $('#accordion').accordion().children('.accordionCallTransfer').show();
            }
            else
            {
                $('#accordion').accordion().children('.accordionCallTransfer').hide();
            }
            $('#sessionDropdown').empty();
            //$('#sessionDropdown').append('<option value="" selected="selected" disabled>Session:</option>');
            $.each(data.DialingMode, function(val) {
                $('#sessionDropdown').append(
                    $('<option></option>').val(data.DialingMode[val]).html(data.DialingMode[val])
                );
            });
        }
    });
}

function populatePhoneBridgeDetails(){
    $.ajax({
        url: baseUrl + 'Account/NativeSFDCGetPhoneBridgeInfo',
        type: "GET",
        xhrFields : {
          withCredentials : true
        },
        data: { crmUserName: username },
        success: function(data, status, XMLHttpRequest){
            IsClickToDial = true;
            $('#dialingNumber').html(data.dialingNumber);
            $('#agent').html(data.agent);
            $('#password').html(data.password);
            if(data.PhoneStatus == 'true'){
                $('#networkStatus').html('Connected');
            }
            else{
                $('#networkStatus').html('Disconnected');
            }
        }
    });
}