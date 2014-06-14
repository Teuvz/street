package com.ukuleledog.games.street.state;

import com.ukuleledog.games.core.State;
import com.ukuleledog.games.street.elements.Car;
import com.ukuleledog.games.street.elements.Chunli;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.TimerEvent;
import haxe.Timer;
import openfl.Assets;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.ui.Keyboard;
import flash.geom.Rectangle;
import flash.geom.Point;

/**
 * ...
 * @author matt
 */
class GameState extends State
{

	private var face:Bitmap;
	private var life:Sprite;
	
	private var background:Bitmap;
	private var car:Car;
	private var chunli:Chunli;
	private var action:Bool = false;
	private var superState:Bool = false;
	private var superTimer:flash.utils.Timer;
	private var perfectText:Bitmap;
	
	public function new() 
	{
		super();
		addEventListener( Event.ADDED_TO_STAGE, init );
	}
	
	private function init( e:Event )
	{
		removeEventListener( Event.ADDED_TO_STAGE, init );
		
		var backgroundBmd:BitmapData = new BitmapData( 600, 480, false );
		backgroundBmd.copyPixels( Assets.getBitmapData( 'img/spritesheet.png' ), new Rectangle( 0, 220, 600, 480 ), new Point(0, 0) );
		background = new Bitmap( backgroundBmd );
		addChild( background );
		
		var perfectBmd:BitmapData = new BitmapData( 283, 50, true );
		perfectBmd.copyPixels( Assets.getBitmapData( 'img/spritesheet.png' ), new Rectangle( 700, 220, 283, 50 ), new Point(0, 0) );
		perfectText = new Bitmap( perfectBmd );
		perfectText.x = (stage.stageWidth / 2) - (perfectText.width / 2);
		perfectText.y = (stage.stageHeight / 2) - (perfectText.height / 2);
		perfectText.cacheAsBitmap = true;
		
		car = new Car();
		car.addEventListener( Event.COMPLETE, endingHandle );
		car.x = (stage.stageWidth / 2) - (car.width / 2) + 50;
		car.y = 310;
		addChild( car );
		
		chunli = new Chunli();
		chunli.x = car.x - 50;
		chunli.y = car.y - 20;
		addChild( chunli );
			
		stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandle );
		stage.addEventListener( KeyboardEvent.KEY_UP, keyUpHandle );
		
		Assets.getSound( 'snd/fight.wav' ).play();
		
		superTimer = new flash.utils.Timer(250);
		superTimer.addEventListener( TimerEvent.TIMER, superHandle );
	}
	
	private function endingHandle( e:Event )
	{
		chunli.setAnimation( 'idle' );
		superTimer.removeEventListener( TimerEvent.TIMER, superHandle );
		car.removeEventListener( Event.COMPLETE, endingHandle );
		stage.removeEventListener( KeyboardEvent.KEY_DOWN, keyDownHandle );
		stage.removeEventListener( KeyboardEvent.KEY_UP, keyUpHandle );
		Timer.delay( function() {
			addChild( perfectText );
			Assets.getSound( 'snd/perfect.wav' ).play();
			chunli.setAnimation('victory');
		}, 2000);
	}
	
	private function keyDownHandle( e:KeyboardEvent )
	{
		
		if ( action == true )
			return;
		
		switch ( e.keyCode )
		{
			case Keyboard.UP:
				action = true;
				chunli.setAnimation('jump');
				Timer.delay( function() { 
					if ( chunli.currentAnimation == 'jump' )
					{
						chunli.setAnimation('idle'); 
						action = false;
					}
				}, 400 );
			case Keyboard.DOWN:
				action = true;
				chunli.setAnimation('crouch');
			case Keyboard.A:
				action = true;
				Assets.getSound( 'snd/punch.wav' ).play();
				chunli.setAnimation('punch');
				car.nextStep();
				Timer.delay( function() { 
					if ( chunli.currentAnimation == 'punch' )
					{
						chunli.setAnimation('idle');
						action = false;
					}
				}, 400 );
			case Keyboard.Z:
				action = true;
				Assets.getSound( 'snd/kick.wav' ).play();
				chunli.setAnimation('kick');
				car.nextStep();
				Timer.delay( function() { 
					if ( chunli.currentAnimation == 'kick' )
					{
						chunli.setAnimation('idle');
						action = false;
					}
				}, 400 );
			case Keyboard.K:
				action = true;
				chunli.setAnimation('super');
				superState = true;
				superTimer.start();
		}
				
	}
	
	private function keyUpHandle( e:KeyboardEvent )
	{
		if ( e.keyCode == Keyboard.K )
		{
			superState = false;
			action = false;
			chunli.setAnimation('idle');
			superTimer.stop();
		}
		else if ( chunli.currentAnimation != 'jump' && chunli.currentAnimation != 'punch' && chunli.currentAnimation != 'kick')
		{
			chunli.setAnimation('idle');
			action = false;
		}
	}
	
	private function superHandle( e:TimerEvent )
	{
		Assets.getSound( 'snd/kick.wav' ).play();
		car.nextStep();
	}
	
}