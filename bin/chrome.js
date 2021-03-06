// Generated by Haxe 3.4.4
(function () { "use strict";
var MainChrome = function() {
	var _gthis = this;
	var mdns = require("mdns");
	var tmp = mdns.tcp("googlecast");
	this.browser = mdns.createBrowser(tmp);
	this.browser.on("serviceUp",function(service) {
		console.log(service);
		console.log("found device \"" + service.name + "\" at " + service.addresses[0] + ":" + service.port);
		_gthis.ondeviceup(service.addresses[0]);
		_gthis.browser.stop();
	});
	this.browser.start();
};
MainChrome.main = function() {
	var app = new MainChrome();
};
MainChrome.prototype = {
	ondeviceup: function(host) {
		console.log(host);
		var DefaultMediaReceiver = require("castv2-client").DefaultMediaReceiver;
		var client = new js_npm_castv2client_Client();
		client.connect(host,function() {
			console.log("connected, launching app ...");
			client.launch(DefaultMediaReceiver,function(err,player) {
				var media = { contentId : "http://commondatastorage.googleapis.com/gtv-videos-bucket/big_buck_bunny_1080p.mp4", contentType : "video/mp4", streamType : "BUFFERED", metadata : { type : 0, metadataType : 0, title : "Big Buck Bunny", images : [{ url : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg"}]}};
				player.on("status",function(status) {
					console.log("status broadcast playerState=" + status.playerState);
				});
				console.log("app \"" + player.session.displayName + "\" launched, loading media " + media.contentId + " ...");
				player.load(media,{ autoplay : true},function(err1,status1) {
					console.log("media loaded playerState=" + status1.playerState);
					setTimeout(function() {
						player.seek(120,function(err2,status2) {
						});
					},15000);
				});
			});
		});
		client.on("error",function(err3) {
			console.log("Error: " + err3.message);
			client.close();
		});
	}
};
var js_npm_castv2client_Client = require("castv2-client").Client;
MainChrome.main();
})();

//# sourceMappingURL=chrome.js.map