# remote-sendkeys
Send keystroke macros to your windows PC using node.js and Angular.

## Introduction for users
remote-sendkeys consist of two parts, a server application run on your PC and a client application on another device.  The  **host server** must be running on the PC you wish to send keystrokes to.  A remote machine (laptop, tablet, smartphone, etc) accessing  the **client web application** in a browser can then send keystrokes to the **host server**.  The client application must be on the same local network as the host (or otherwise have access to the ip address of the host).

![alt tag](https://raw.githubusercontent.com/Hypercubed/remote-sendkeys/master/remote-sendkeys-example.gif)
(example, note in this example the host and client are the same machine, not very usefull)

## Introduction for developers

**The host server**  The host server is a node.js/Express server that provides an API for emitting keystrokes to the PC.  The keystokes themselves are emitted to the active window using the [WinSendKeys](https://www.dcmembers.com/ath/download/winsendkeys/) application.  The host server also hosts a copy of the client application although it is not necessary that you use this instance.

**A client web application**  The client web application allow you to send keystroke macros to the host PC, or save keystrokes for later using a simple and intuitive user interface built using AngularJS.

## Features
* **Host install only.**  The client is your browser.
* **Open source.** Do you know what other server apps are doing on your PC?
* **Easy to customize.** Easily switch between design and edit.
* **Easy to access.** Design a layout on your PC, send it to your laptop/tablet/smartphone (using [push bullet](https://www.pushbullet.com/) for example) or bookmark for later.

## Requirements

### On the host
* Windows (required by WinSendKeys)
* node.js (with npm)
* bower (currently needed for installation)

### On the client
* a browser
* access to the host IP and port

## Installation
### (later installed using only npm or packaged application)

```bash
git clone https://github.com/Hypercubed/remote-sendkeys.git
cd remote-sendkeys
npm install
bower install
```

## Getting started

Run `grunt serve` to launch the host server.  This will also launch the client web app in your default browser on the host machine.  You can now begin designing your keystrokes immediately using the [autoit3 `send` keys format](https://www.autoitscript.com/autoit3/docs/functions/Send.htm).  Type keystrokes in the input box and press the paper plane button to send the keystrokes immediately or the paper clip to save the keystrokes for later.  Note that at this point the client and host are the same machine so keystrokes will be sent to your browser (the currently active application on the host).

Type `^f` (<kbd>ctrl+f</kbd>) and hit send.  You should see your browser's "find" dialog appear.  Type `^f` in the input box again but this time click on the paperclip button.  You will see a new button appear below the input box.  Clicking on this new button will again send the <kbd>ctrl+f</kbd> keystrokes to the active window (your browser).  Right click (long press on a mobile browser) on this button to add a title or edit the keystroke.  Click the check-mark to return to active mode.  Add a few more keystrokes.

Now that you have designed a layout you probably want to use this layout to another machine.  Easy, with remote-sendkeys the url is your layout!  Simply send this URL to your remote device.  There are many ways to do this for example email or (my favirite)  [push bullet](https://www.pushbullet.com/).  Alternatively you can open the host IP address directly on your second device and begin adding keystrokes there.  Note that the keystroke macros you define are never stored on the server.  They are stored only on your client machine's browser and encoded in the URL.  Bookmark the URL to save for later.

You can now continue to add keystrokes on the new client, however, now keystrokes are executed to the foreground application on the host machine.

## History (or Why!?)
I wanted to do something very simple, send a series of predefined keystrokes from my tablet or smartphone to my PC while running other applications.  I tried over two dozen remote control apps on the Google play store and found that they all had multiple issues, including:

1. **Closed.**  Closed source server application, kind of scary if you ask me.
2. **Expensive.**  Some apps charge per layout!
3. **Missing keystrokes**.   Some apps could only assign one key per button.  I didn't find a single app that supported the right control key (I needed RCTRL+F1).
4. **Difficult to customize**. Setting up new keypads was not fluid.  Often requiring me to back out of the "using mode" to enter a special "edit mode" then return to test, rinse, and repeat.
5. **Android/iPhone only.** Requires both a PC based host and Android/iPhone client.  Can't run the client on my windows based tablet.

## Status
At this point this project can be considered a proof of concept.  It is not secure at all and should only be used on your local network behind a firewall.  I'd love to see support for Mac or Linux, perhaps using xdotools or similar.  Eventually the host server should be packaged for easy install and run headless.  I'm open to comments, issues, and pull request.

## License
Copyright (c) 2014 Jayson Harshbarger
[MIT License](http://en.wikipedia.org/wiki/MIT_License)
