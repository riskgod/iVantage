// Web Socket Message Pattern

// 	{
// 		origin: --> defines which screen sent the message
// 		method: --> defines the function to be invoked at the destination (if any)
// 		data: --> data payload for message
// 	}

//DEFINE WEBSOCKET & HANDLERS
var setupWebSocket = function() {
	ws.onopen = function(){
		console.log('Connection open!');
	}

	ws.onclose = function(){
		console.log('Connection closed!');
	}

	ws.onerror = function(error){
		console.log('Error detected: ');
		console.log(error);
	}

	ws.onmessage = function(e){
		console.log('Message received: ' + e.data);
		var msg = JSON.parse(e.data);
		if (typeof methods[msg.method] != 'function') {
			console.log('Message Handler: NO MATCHING FUNCTION FOUND');
		}
		else {
			console.log('Message Handler: FUNCTION FOUND - PROCESSING REQUEST');
			methods[msg.method](msg.data);
		}
	}
};

var sendWSMessage = function(method, data) {
	var msg = {};
	msg["origin"] = amplify.store.sessionStorage('screenID').toString();
	msg["method"] = (method != null ? method.toString() : "");
	msg["data"] = (data != null ? data.toString() : "");

	console.log('sending: ' + JSON.stringify(msg));
	ws.send(JSON.stringify(msg));
};

var statusMessage = function(msg) {
	console.log(msg);
};
