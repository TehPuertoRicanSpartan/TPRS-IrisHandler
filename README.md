# TPRS-IrisHandler
a simple script handler using [hscript-iris](https://lib.haxe.org/p/hscript-iris)

this is meant for implementing hscript support for games easily!

this is a little untested, so feel free to pull request on whether i'm doing wrong!

inspired by [FNF-LÖVE's scriptshandler.lua](https://github.com/Stilic/FNF-LOVE/blob/main/funkin/backend/scripting/scriptshandler.lua)

## Functions
### loadFolder(folders:Array\<String>)
this will load every script in each directory. sub-directories won't work.
### add(script:Iris)
adds a custom script to the handler's list
### call(function:String, ?args:Array\<Dynamic>)
calls every script in the list to execute a function
### set(name:String, value:Dynamic)
sets a variable for every script
### destroy()
destroys every script in the list

## Other
### path:String = "assets/scripts" (variable)
you may change this if you want scripts on another folder other than `assets/scripts`
### extensions:Array\<String> = ["hx", "hxs", "hxc"]
put any extension you want to here! it HAS to be without the dot
