
package;

import js.npm.castv2client.Client;
import js.npm.castv2client.DefaultMediaReceiver;
import js.npm.castv2client.Mdns;


import js.Browser.*;
import js.Browser.console;
import js.html.Window.*;
// import js.html.Window.setTimeout;

class MainChrome {

	// var Client                = new Client();
	// var DefaultMediaReceiver  = new DefaultMediaReceiver();
	// var mdns                  = new Mdns();

	var mdns:Mdns;
	var browser : Browser;

	public function new() {

		var mdns = untyped require('mdns');
		browser = untyped mdns.createBrowser(mdns.tcp('googlecast'));

		browser.on('serviceUp', function(service) {
			trace(service);
			trace('found device "${service.name}" at ${service.addresses[0]}:${ service.port}'); // "Chromecast-10c9202216273171bda7522fc5d8cf52" at 192.168.2.1:8009
			// trace('found device "%s" at %s:%d', service.name, service.addresses[0], service.port);
			ondeviceup(service.addresses[0]);
			browser.stop();
		});

		browser.start();
	}

	function ondeviceup(host) {

		// trace(host);

		// untyped __js__ ("var DefaultMediaReceiver  = require('castv2-client').DefaultMediaReceiver;");
		var DefaultMediaReceiver  = js.Lib.require('castv2-client').DefaultMediaReceiver;
		// var defaultMediaReceiver  = new DefaultMediaReceiver();

		var client = new Client();

		client.connect(host, function() {
			trace('connected, launching app ...');

			client.launch(DefaultMediaReceiver, function(err, player) {
				var media = {

					// Here you can plug an URL to any mp4, webm, mp3 or jpg file with the proper contentType.
					contentId: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/big_buck_bunny_1080p.mp4',
					contentType: 'video/mp4',
					streamType: 'BUFFERED', // or LIVE

					// Title and cover displayed while buffering
					metadata: {
						type: 0,
						metadataType: 0,
						title: "Big Buck Bunny",
						images: [
							{ url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg' }
						]
					}
				};

				player.on('status', function(status) {
					trace('status broadcast playerState=${status.playerState}');
				});

				trace('app "${player.session.displayName}" launched, loading media ${media.contentId} ...');

				player.load(media, { autoplay: true }, function(err, status) {
					trace('media loaded playerState=${status.playerState}');

					// Seek to 2 minutes after 15 seconds playing.
					untyped setTimeout(function() {
						player.seek(2*60, function(err, status) {
							//
						});
					}, 15000);

				});

			});

		});

		client.on('error', function(err) {
			trace('Error: ${err.message}');
			client.close();
		});

	}

	static public function main() {
		var app = new MainChrome();
	}
}