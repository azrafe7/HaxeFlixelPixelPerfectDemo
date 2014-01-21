package; 

import flash.system.System;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flash.display.BitmapData;
import flixel.util.FlxBitmapDataPool;
import flixel.util.FlxCollision;

using StringTools;

class PlayState extends FlxState
{	
	var nPlayers:Int = 3;
	var players:Array<FlxSprite> = new Array<FlxSprite>();
	var player:FlxSprite;
	
	var bmd:BitmapData = new BitmapData(30, 10);
	
	var infoText:flixel.text.FlxText;
	var INFO:String = "collisions: |hits|\n\n" + 
					  "[W/S]           num players: |players|\n" +
					  "[A/D]           alpha tolerance: |alpha|\n" +
					  "[ARROWS]    move\n" +
					  "[R]               random\n" +
					  "[SPACE]       toggle rotation";
					  
	var nCollisions:Int = 0;
	
	var alphaTolerance:Int = 128;
	var rotate:Bool = true;
	
	
	public function new() {
		FlxG.log.redirectTraces = false;
		FlxG.game.debugger.log.visible = false;
		FlxG.game.debugger.stats.visible = true;
		
		super();
	}
	
	public function addPlayer():FlxSprite 
	{
		var p = new FlxSprite(Math.random() * FlxG.width, Math.random() * FlxG.height);
		
		p.loadGraphic(bmd);
		p.angle = Math.random() * 360;
		if (players.length > 1) p.alpha = .3 + Math.random() * .7;
		
		players.push(p);
		add(p);
		
		return p;
	}
	
	override public function create():Void
	{	
		for (i in 0...nPlayers) addPlayer();
		player = players[0];
		player.x = 100;
		player.y = 100;
		
		FlxG.debugger.visible = true;
	
		infoText = new FlxText(5, 0, 400, INFO);
		infoText.y = FlxG.height - infoText.height;
		add(infoText);
		
		updateInfo();
	}
	
	override public function update():Void
	{			
		if (FlxG.keyboard.pressed("LEFT")) player.x -= 2;
		if (FlxG.keyboard.pressed("RIGHT")) player.x += 2;
		if (FlxG.keyboard.pressed("UP")) player.y -= 2;
		if (FlxG.keyboard.pressed("DOWN")) player.y += 2;
	
		if (FlxG.keyboard.pressed("ESCAPE")) {
		#if (flash || js)
			System.exit(0);
		#else
			Sys.exit(0);
		#end
		}
		
		if (FlxG.keyboard.justPressed("SPACE")) rotate = !rotate;
		if (FlxG.keyboard.justPressed("R")) {
			for (p in players) {
				if (p == player) continue;
				p.x = Math.random() * FlxG.width;
				p.y = Math.random() * FlxG.height;
				p.alpha = .3 + Math.random() * .7;
			}
		}
	
		if (FlxG.keyboard.justPressed("W", "Z")) nPlayers++;
		if (FlxG.keyboard.justPressed("S")) nPlayers = Std.int(Math.max(nPlayers - 1, 2));
		
		if (FlxG.keyboard.pressed("D")) alphaTolerance = Std.int(Math.min(alphaTolerance + 1, 255));
		if (FlxG.keyboard.pressed("A", "Q")) alphaTolerance = Std.int(Math.max(alphaTolerance - 1, 1));
		
		// add/remove players
		if (nPlayers != players.length) {
			var len = players.length;
			if (nPlayers > len) addPlayer();
			else remove(players.pop());
		}
		
		// update rotation
		if (rotate) {
			for (i in 0...players.length) {
				var p1 = players[i];
				p1.angle += (i == 0) ? 1 : 2;
			}
		}
		
		// pixel perfect check between all
		nCollisions = 0;
		for (i in 0...players.length) {
			var p1 = players[i];
			var collides = false;
			for (j in 0...players.length) {
				if (i == j) continue;
				
				var p2 = players[j];
				if (FlxCollision.pixelPerfectCheck(p1, p2, alphaTolerance)) {
					collides = true;
					nCollisions++;
					break;
				}
			}
			p1.color = collides ? 0x00FF00 : 0xFFFFFF;
		}
		
		updateInfo();
	}	
	
	public function updateInfo():Void 
	{
		infoText.text = INFO.replace("|players|", Std.string(nPlayers))
			.replace("|alpha|", Std.string(alphaTolerance))
			.replace("|hits|", Std.string(nCollisions));
	}
	
}
