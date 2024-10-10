package; // put this file wherever you want, you STILL must change this

import crowplexus.iris.Iris;

using StringTools;

class IrisHandler {
    public static var path:String = "assets/scripts";
    public static var extensions:Array<String> = ["hx", "hxs", "hxc"];

    var scripts:Array<Iris> = [];

    public function new(?folders:Array<String>) {
        if (folders != null)
            loadFolder(folders);
    }

    public function loadFolder(folders:Array<String>):Void {
        final getText:String->String = #if sys sys.io.File.getContent #elseif openfl openfl.utils.Assets.getText #end; // "borrowed" this from the usage lmfao

        for (folder in folders) {
            #if sys
            if (!sys.FileSystem.exists('./$path/$folder')) return;
            var items:Array<String> = sys.FileSystem.readDirectory('./${path + (folder != "" ? "/" : "")}$folder');
            #elseif openfl
            if (!openfl.utils.Assets.exists('./$path/$folder')) return;
            var items:Array<String> = openfl.util.Assets.list('./${path + (folder != "" ? "/" : "")}$folder');
            #end
            for (item in items) {
                for (extension in extensions)
                    if (!item.endsWith('.$extension')) return;
                var scriptPath:String = (folder != "" ? folder + "/" : folder) + item;
                var script:Iris = new Iris(getText('./$path/$scriptPath'), {name: scriptPath, autoRun: true, autoPreset: true});
                add(script);
            }
        }
    }

    public function add(script:Dynamic):Void {
        if (script != null)
            scripts.push(script);
    }

    public function call(func:String, ?args:Array<Dynamic>):Void {
        for (script in scripts) {
            var scriptFunc:Dynamic = script.get(func);
            if (scriptFunc != null && Reflect.isFunction(scriptFunc))
                script.call(func, args);
        }
    }

    public function set(name:String, value:Dynamic):Void {
        for (script in scripts)
            script.set(name, value, true);
    }

    public function destroy():Void {
        for (script in scripts)
            script.destroy();
    }
}
