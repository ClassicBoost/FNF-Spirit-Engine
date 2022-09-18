package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	public var isPlayer:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		scrollFactor.set();

		this.isPlayer = isPlayer;
		swapCharacter(char);
	}
	private var iconOffsets:Array<Float> = [0, 0];
	public function swapCharacter(char:String)
	{
		switch(char)
		{
			case 'bf' | 'bf-car' | 'bf-christmas':
				loadGraphic(Paths.image('icons/icon-bf'), true, 150, 150);
			case 'gf' | 'gf-car' | 'gf-christmas' | 'gf-pixel':
				loadGraphic(Paths.image('icons/icon-gf'), true, 150, 150);
			case 'dad': 
				loadGraphic(Paths.image('icons/icon-dad'), true, 150, 150);
			case 'spooky':
				loadGraphic(Paths.image('icons/icon-spooky'), true, 150, 150);
			case 'pico' | 'pico-player':
				loadGraphic(Paths.image('icons/icon-pico'), true, 150, 150);
			case 'mom' | 'mom-car':
				loadGraphic(Paths.image('icons/icon-mom'), true, 150, 150);
			case 'parents-christmas':
				loadGraphic(Paths.image('icons/icon-parents'), true, 150, 150);
			case 'monster' | 'monster-christmas':
				loadGraphic(Paths.image('icons/icon-monster'), true, 150, 150);
			case 'bf-pixel':
				loadGraphic(Paths.image('icons/icon-bf-pixel'), true, 150, 150);
			case 'senpai':
				loadGraphic(Paths.image('icons/icon-senpai'), true, 150, 150);
			case 'senpai-angry':
				loadGraphic(Paths.image('icons/icon-senpai-angry'), true, 150, 150);
			case 'spirit':
				loadGraphic(Paths.image('icons/icon-spirit'), true, 150, 150);
			default: 
				loadGraphic(Paths.image('icons/icon-${char}'), true, 150, 150); // I'm pretty sure if it can't find that icon it would just appear as a haxe logo right?
		}

		antialiasing = true;
		animation.add('idle', [0], 0, false, isPlayer);
		animation.add('losing', [1], 0, false, isPlayer);
		animation.add('winning', [2], 0, false, isPlayer);
			
		animation.play('idle');

		switch(char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				antialiasing = false;
		}
		
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
