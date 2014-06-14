package com.ukuleledog.games.street.elements;

import com.ukuleledog.games.core.AnimatedObject;
import openfl.Assets;

/**
 * ...
 * @author ...
 */
class Chunli extends AnimatedObject
{

	public function new() 
	{
		super();
		
		this.bmd = Assets.getBitmapData('img/spritesheet-chun.png');
		
		createAnimation( 'idle', 0, 0, 4, 100, 50, 0.2 );
		createAnimation( 'jump', 0, 100, 4, 100, 50, 0.1, false );
		createAnimation( 'crouch', 200, 100, 2, 100, 50, 0.1, false );
		createAnimation( 'punch', 0, 200, 3, 100, 100, 0.1 );
		createAnimation( 'kick', 0, 300, 5, 100, 100, 0.09 );
		createAnimation( 'victory', 0, 400, 3, 100, 50, 0.2, false );
		createAnimation( 'super', 0, 500, 7, 100, 100, 0.1 );
		animate('idle');
		
		this.scaleX = 1.2;
		this.scaleY = this.scaleX;
	}
	
}