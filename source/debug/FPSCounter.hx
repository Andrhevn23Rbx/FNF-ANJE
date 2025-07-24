package debug;

import flixel.FlxG;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.system.System;
import haxe.Timer;

class FPSCounter extends TextField
{
	public var currentFPS(default, null):Int;

	public var memoryMegas(get, never):Float;

	@:noCompletion private var times:Array<Float>;

	private var peakMem:Float = 0;
	private var peakRam:Float = 0;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 14, color);
		autoSize = LEFT;
		multiline = true;
		text = "FPS: ";

		times = [];
	}

	var deltaTimeout:Float = 0.0;

	private override function __enterFrame(deltaTime:Float):Void
	{
		if (deltaTimeout > 1000) {
			deltaTimeout = 0.0;
			return;
		}

		final now:Float = Timer.stamp() * 1000;
		times.push(now);
		while (times[0] < now - 1000) times.shift();

		currentFPS = times.length < FlxG.drawFramerate ? times.length : FlxG.drawFramerate;
		updateText();
		deltaTimeout += deltaTime;
	}

	public dynamic function updateText():Void {
		// We use System.totalMemory as a proxy for both mem/ram here
		var ram:Float = System.totalMemory / 1024 / 1024;
		var mem:Float = ram; // Just mirroring since we can't access GC memory

		if (mem > peakMem) peakMem = mem;
		if (ram > peakRam) peakRam = ram;

		var memStr = StringTools.lpad(Std.string(Math.round(mem)), "0", 3);
		var ramStr = StringTools.lpad(Std.string(Math.round(ram)), "0", 3);
		var memPeak = StringTools.lpad(Std.string(Math.round(peakMem)), "0", 3);
		var ramPeak = StringTools.lpad(Std.string(Math.round(peakRam)), "0", 3);

		text = 'FPS: ${currentFPS}'
			+ '\nMemory: ${memStr}mb'
			+ '\nRam: ${ramStr}mb'
			+ '\nMEM-P: ${memPeak}mb'
			+ '\nRAM-P: ${ramPeak}mb'
			+ '\nANJE 0.0.1';

		textColor = 0xFFFFFFFF;
		if (currentFPS < FlxG.drawFramerate * 0.5)
			textColor = 0xFFFF0000;
	}

	inline function get_memoryMegas():Float
		return cast(System.totalMemory, UInt);
}
