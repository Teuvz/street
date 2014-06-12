package com.ukuleledog.games.street.elements;

import com.ukuleledog.games.core.GameObject;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;
import openfl.Assets;

/**
 * ...
 * @author matt
 */
class Car extends GameObject
{

	private var spritesheet:BitmapData;
	private var base:Bitmap;
	private var destructable:Bitmap; 
	private var step:UInt = 1;
	
	private var carWidth:UInt = 205;
	
	
	public function new() 
	{
		super();
	
		this.spritesheet = Assets.getBitmapData('img/car.png', true);
		
		var bmd:BitmapData = new BitmapData(carWidth, 100, true, 0xF800F8);
		bmd.copyPixels( this.spritesheet, new Rectangle(0, 0, carWidth, 100), new Point(0, 0) );
		base = new Bitmap( bmd );
		base.x = 200;
		base.y = 200;
		addChild( base );
		
		var bmd2:BitmapData = new BitmapData(carWidth, 100, true, 0xF800F8);
		bmd2.copyPixels( this.spritesheet, new Rectangle(carWidth, 0, carWidth, 100), new Point(0, 0) );
		destructable = new Bitmap( bmd2 );
		destructable.x = 205;
		destructable.y = 187;
		addChild( destructable );
		
		var timer:Timer = new Timer( 500 );
		timer.addEventListener( TimerEvent.TIMER, changeStep );
		timer.start();
		
	}
	
	private function changeStep( e:Event = null )
	{
		step++;
		
		if ( step == 4 )
			step = 1;
		
		removeChild( destructable );
		var bmd2:BitmapData = new BitmapData(carWidth, 100, true, 0xF800F8);
		bmd2.copyPixels( this.spritesheet, new Rectangle(carWidth*step, 0, 200, 100), new Point(0, 0) );
		destructable = new Bitmap( bmd2 );
		destructable.x = 205;
		destructable.y = 187;
		addChild( destructable );
	}
	
}