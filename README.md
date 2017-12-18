# Example Node.js Gitlab Electron

This is a [Haxe](http://www.haxe.org) project, read more about it in the [README_HAXE.MD](README_HAXE.MD)!

![](icon.png)


- project target 	: node
- project license 	: MIT
- project author 	: Matthijs Kamstra aka [mck]
- project website 	:


# install?

I have written about this process before, just follow the links

- [Haxe](http://matthijskamstra.github.io/haxejs/haxe/quick-install.html) (and get haxelib also in the process)
- [Node.js](http://matthijskamstra.github.io/haxejs/haxe/quick-install.html#step-5-extra-install-npm-node-js) (and get npm also in the process)
- [Editor](http://matthijskamstra.github.io/haxejs/haxe/quick-install.html#step-2-install-editor)?

The big stuff is done now, so install libraries:

##### haxe dependencies with haxelib

ahhhh (not everything goes smooth)

```bash
# normally this would do the trick, but js-kit is not on haxelib, only on git
# haxelib install build_debug.hxml
```

so we use this instead

```bash
haxelib git js-kit https://github.com/clemos/haxe-js-kit.git haxelib
haxelib hxnodejs
haxelib msignal
haxelib electron
```

##### node/js dependencies with NPM

```
# install stuff auto-compile for haxe
cd 'path/to/folder/ten_k'
npm install
# install stuff for electron (normal js stuff)
cd 'bin'
npm install
```

# Wie, Wat en Waar?

This folder structure might look strange from a JS point of view, but is essential the same:

```
+ bin (export folder for Haxe, start folder for application AND folder used for Electron build)
+ src (code folder Haxe)
```

There are two `package.json`

- in the `bin` folder
- in the root folder

you need to install both if you want to use Haxe as well, otherwise only the `bin` folder

```bash
cd bin
npm install
```

We use `/package.json` for automatic transpiling (Haxe) and some extra `npm run xxx` scripts.

The `/bin/package.json` is for Electron, these are the (js)files need to get everything working in Electron wrapper.


## Haxe

Start with [README_HAXE.MD](README_HAXE.MD) about installing Haxe and a IDE that works with Haxe (VSCode)

The `src` folder is where you find the starting points from the different parts of the app

```bash
/src/Main.hx (Electron starting point)
/src/MainServer.hx (start server and socket.io and REST API)
```

- `Main.hx` is the start of Electron (desktop)
- `MainClient.hx` is the js file for the browser part (browser)
- `MainServer.hx` is the start of <http://localhost:3000> and shows the `bin/public/index.html` and is the start of the REST API (node.js)


Look in `build_debug.hxml` where the Haxe files will be transpiled to:

```
/src/Main.hx 			-> 		/bin/main.js
/src/MainClient.hx 		-> 		/bin/public/js/client.js
/src/MainServer.hx 		-> 		/bin/server.js
```

I use `npm` to autocompile (in the root folder):

```bash
cd /correct/folder
npm install
npm run watch
```

Which auto-transpiles Haxe code to JS on changes, restarts the server.js and send an update via livereload.

App will start running on <http://localhost:3000>



## Electron

##### Test

When using Haxe, you need to transpile the Haxe code first.
Then you can *test* the electron app via

```bash
npm run electron
# or
electron bin
```

*Make sure the browser that `npm run watch` is not running in the background!*


##### Build

When using Haxe, you need to transpile the Haxe code first.
Then you can *build* the electron app via

```bash
npm run package
```

And in the folder `/download` you will have a mac only build (guess that more OS is unnessary)
