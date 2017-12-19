package;

import js.Browser;
import js.Browser.document;
import js.Browser.console;

import js.jquery.JQuery;


class MainClient {

	var localStorage : js.html.Storage;

	public function new () {
		trace('MainClient :: client.js');

		localStorage = js.Browser.getLocalStorage();
		new JQuery(document).ready ( function () {
			trace ("client.js document ready!");
			init();
		});
	}

	function init(){
		initDrag();
		initSockets();
	}

	function initDrag(){
		trace('init drag');

		var holder = document.getElementById('drag-file');

		if(holder == null) return;

		holder.ondragover = function () {
			return false;
		};

		holder.ondragleave = function () {
			return false;
		};

		holder.ondragend = function () {
			return false;
		};

		holder.ondrop = function (e:js.html.DragEvent) {
			e.preventDefault();

			trace(e);
			trace(e.dataTransfer);
			var tot =  e.dataTransfer.files;

			trace(tot);
			for (i in e.dataTransfer.files){
				var file : js.html.File = i;
				trace(file.name);
				var path = Reflect.getProperty(file,'path');
				if(path != null) trace(path );

			}
			// for (let f of e.dataTransfer.files) {
			// 	console.log('File(s) you dragged here: ', f.path)
			// }

			return false;
		};


	}
/*
// browser
lastModified: 1460405251000
lastModifiedDate: Date 2016-04-11T20:07:31.000Z
name: "icon.png"
size: 3174
type: "image/png"
*/

/*
// node/electron
lastModified:1460405251000
lastModifiedDate:Mon Apr 11 2016 22:07:31 GMT+0200 (CEST)
name:"icon.png"
path:"/Users/matthijs/Documents/workingdir/haxe/hxgenerate/icon.png"
size:3174
type:"image/png"
*/


	function initSockets(){
		trace('init sockets');

		// init sockets
		var _socket = js.browser.SocketIo.connect('http://localhost:3000');
		// var _socket = js.browser.SocketIo.connect('http://localhost:${MainServer.PORT}');
		_socket.on('message', function (data) {
			console.info('message:' + haxe.Json.stringify(data) );
			// toggleThrobber(true);
		} ) ;
		_socket.on('loading', function (data) {
			// console.info('loading:' + haxe.Json.stringify(data) );
			// toggleThrobber(true);
		} ) ;
	}

	static public function main () {
		new MainClient ();
	}
}