package com.ukuleledog.games.street.state;

import com.ukuleledog.games.core.State;
import com.ukuleledog.games.street.elements.Car;
import flash.events.Event;

/**
 * ...
 * @author matt
 */
class GameState extends State
{

	public function new() 
	{
		super();
		addEventListener( Event.ADDED_TO_STAGE, init );
	}
	
	private function init( e:Event )
	{
		removeEventListener( Event.ADDED_TO_STAGE, init );
		
		addChild( new Car() );
	}
	
}