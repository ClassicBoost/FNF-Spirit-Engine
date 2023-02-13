package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{

	var selector:FlxText;
	var curSelected:Int = 0;
	var curDifficulty:Int = 0;
	var versionShit:FlxText;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	var optionsShit:Array<String> = ['Classic1926','KadeDev','Shadow Mario','ninjamuffin99','Kawai Sprite','PhantomArcade','evilsk8r'];

	override function create()
	{

		/* 
			if (FlxG.sound.music != null)
			{
				if (!FlxG.sound.music.playing)
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
			}
		 */

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...optionsShit.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, optionsShit[i], false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpOptions.add(songText);
		}

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, '${diffText.text}', 32);
		// scoreText.autoSize = false;
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);
		// scoreText.alignment = RIGHT;

		var scoreBG:FlxSprite = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 40, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
	//	add(diffText);

		add(scoreText);

		versionShit = new FlxText(5, FlxG.height - 100, FlxG.width, "Change your offsets\n" + FlxG.save.data.offset, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.borderSize = 1.5;
		add(versionShit);

		changeSelection();
		changeDiff();

		// FlxG.sound.playMusic(Paths.music('title'), 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		scoreText.text = '${diffText.text}';

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.LEFT_P)
			changeDiff(-1);
		if (controls.RIGHT_P)
			changeDiff(1);

		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

		switch (optionsShit[curSelected]) {
			case 'Classic1926':
				versionShit.text = 'Created this modification';
			case 'KadeDev':
				versionShit.text = 'Created Kade Engine';
			case 'Shadow Mario':
				versionShit.text = 'Inspirations (such as health bar colors)';
			case 'ninjamuffin99':
				versionShit.text = 'Created Friday Night Funkin\'';
			case 'Kawai Sprite':
				versionShit.text = 'Composer of Friday Night Funkin\'';
			case 'PhantomArcade':
				versionShit.text = 'Artist of Friday Night Funkin\'';
			case 'evilsk8r':
				versionShit.text = 'Artist of Friday Night Funkin\'';
		}

		if (accepted)
		{
			switch (optionsShit[curSelected]) {
				case 'Classic1926':
					switch (curDifficulty) {
						case 0:
							FlxG.openURL('https://www.youtube.com/channel/UCKcqlPIGcsoiGl9qsasAJhw');
						case 1:
							FlxG.openURL('https://twitter.com/classic1926');
						case 2:
					}
				case 'KadeDev':
					switch (curDifficulty) {
						case 0:
							FlxG.openURL('https://www.youtube.com/@KadeDev');
						case 1:
							FlxG.openURL('https://twitter.com/KadeDeveloper');
						case 2:
							FlxG.openURL('https://www.twitch.tv/kadedeveloper');
					}
				case 'Shadow Mario':
					switch (curDifficulty) {
						case 0:
							FlxG.openURL('https://www.youtube.com/@ShadowMarioModder');
						case 1:
							FlxG.openURL('https://twitter.com/Shadow_Mario_');
						case 2:
					}
				case 'ninjamuffin99':
					switch (curDifficulty) {
						case 0:
							FlxG.openURL('https://www.youtube.com/@camerontaylor5970');
						case 1:
							FlxG.openURL('https://twitter.com/ninja_muffin99');
						case 2:
							FlxG.openURL('https://www.twitch.tv/ninja_muffin99');
					}
				case 'Kawai Sprite':
					switch (curDifficulty) {
						case 0:
							FlxG.openURL('https://www.youtube.com/@KawaiSprite');
						case 1:
							FlxG.openURL('https://twitter.com/kawaisprite');
						case 2:
					}
				case 'PhantomArcade':
					switch (curDifficulty) {
						case 0:
							FlxG.openURL('https://www.youtube.com/@PhantomArcade');
						case 1:
							FlxG.openURL('https://twitter.com/PhantomArcade3K');
						case 2:
							FlxG.openURL('https://www.twitch.tv/phantom_arcade');
					}
				case 'evilsk8r':
					switch (curDifficulty) {
						case 0:
							FlxG.openURL('https://www.youtube.com/@evilotto9014');
						case 1:
							FlxG.openURL('https://twitter.com/evilsk8r');
						case 2:
					}
			}
		}
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		switch (curDifficulty)
		{
			case 0:
				diffText.text = "YOUTUBE";
			case 1:
				diffText.text = 'TWITTER';
			case 2:
				diffText.text = "TWITCH";
		}
	}

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end

		// NGio.logEvent('Fresh');
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = optionsShit.length - 1;
		if (curSelected >= optionsShit.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
