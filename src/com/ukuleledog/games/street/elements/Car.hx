package com.ukuleledog.games.street.elements;

import com.ukuleledog.games.core.GameObject;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.Timer;
import haxe.remoting.FlashJsConnection;
import motion.Actuate;
import motion.easing.Bounce;
import openfl.Assets;

/**
 * ...
 * @author matt
 */
class Car extends GameObject
{

	private var spritesheet:BitmapData;
	private var base:Sprite;
	private var body:Sprite;
	private var step:UInt = 0;
	private var hitsDelta:UInt = 3;
	private var hitCount:UInt = 0;
		
	public function new() 
	{
		super();
	
		spritesheet = Assets.getBitmapData('img/spritesheet.png', true);
		
		base = new Sprite();
		base.graphics.beginBitmapFill( spritesheet );
		base.graphics.drawRect( 0, 0, 200, 100);
		base.graphics.endFill();
		base.cacheAsBitmap = true;
		addChild( base );
		
		var bmd:BitmapData = new BitmapData( 200, 100, true );
		bmd.copyPixels( spritesheet, new Rectangle( 0, 110, 200, 100 ), new Point(0,0) );
		
		body = new Sprite();
		body.graphics.beginBitmapFill( bmd );
		body.graphics.drawRect( 0, 0, 199, 100 );
		body.graphics.endFill();
		body.x = 3;
		body.y = -3;
		body.cacheAsBitmap = true;
		addChild( body );
		
	}
	
	public function nextStep()
	{
		if ( step >= 12 )
			return;
			
		hitCount++;
		
		if ( hitCount > hitsDelta * step )
		step++;
		
		var bmd:BitmapData = new BitmapData( 200, 100, true );
		bmd.copyPixels( spritesheet, new Rectangle( step*200, 110, 200, 100 ), new Point(0,0) );
		
		removeChild( body );
		body.graphics.clear();
		body.graphics.beginBitmapFill( bmd );
		body.graphics.drawRect( 0, 0, 199, 100 );
		body.graphics.endFill();
		addChild( body );
		
		Actuate.tween( body, 0.2, { x:7 } ).ease(Bounce.easeOut).onComplete( function() { 
			Actuate.tween( body, 0.2, {x:3} ).ease(Bounce.easeOut);
		} );
		
		if ( step == 12 )
		{
			Timer.delay( function() {
				dispatchEvent( new Event( Event.COMPLETE ) );		
			}, 1000 );
		}
	}
	
	
	
}