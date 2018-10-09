function loadHeader(channel) {
    if (channel != "")
        connect(channel);
}

function getChannelName(channel) {
    return '/' + channel;
}



function connect(channel) {
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
                
                case 'CallPopDetails':
                    populateLeadInfo(data);
                    break;                    
            }
        }
    });
}

function populateLeadInfo(data) {
    if(!validateIsLeadLoaded()) {
        localStorage.setItem("IsLeadLoaded", "true");
        loadObject(data.CrmId, data.CrmObject);
    }
    localStorage.setItem("IsLeadConnected", "true");
}

function validateIsLeadLoaded(){
    if(localStorage.getItem("IsLeadLoaded")=="true")
        return true;
    else
        return false;
}

function loadObject(CrmId, objectType) {
    var url = location.origin + '/apex/';
    if (objectType == 'Lead') {
        url += 'leads'; 
    }else{
        url += 'contacts'; 
    }
    url += '?&id=' + CrmId;
    location.href = url;
}

