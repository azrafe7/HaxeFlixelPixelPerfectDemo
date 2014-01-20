package;

import flash.Lib;
import flixel.*;
import flixel.FlxG;
import flixel.FlxGame;
import gameStates.*;
import openfl.display.FPS;

class GameClass extends FlxGame
{	
	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		var ratio:Float = 1;
		
		var fps:Int = 60;
		
		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), PlayState, ratio, fps, fps);
		FlxG.autoPause = false;
		
		FlxG.mouse.useSystemCursor = true;
		FlxG.mouse.show();
		
		Lib.current.stage.addChild(new FPS(5, 20, 0xFFFFFF));
	}
}