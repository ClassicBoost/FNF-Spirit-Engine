package options;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class AppOptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;
	public static var onPlaystate:Bool = false;
	var versionShit:FlxText;
	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/bg'));
		controlsStrings = CoolUtil.coolStringFile(
		"\nAccuracy " + (FlxG.save.data.accuracyDisplay ? "on" : "off")
		+ "\nFramerate"
		+ "\nScore Bop " + (FlxG.save.data.scoreBop ? "on" : "off"));
		
		trace(controlsStrings);

		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
				var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
				controlLabel.itemType = "Vertical";
				controlLabel.targetY = i;
				grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		versionShit = new FlxText(5, FlxG.height - 50, 0, '', 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 18, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		versionShit.screenCenter(X);

		if (curSelected == 1) {
			versionShit.visible = true;

			if (controls.RIGHT_R && FlxG.save.data.framerateCap < 360)
				FlxG.save.data.framerateCap += 10;
			if (controls.LEFT_R && FlxG.save.data.framerateCap > 60)
				FlxG.save.data.framerateCap -= 10;

			versionShit.text = FlxG.save.data.framerateCap + "\nRestart game to update\n";
		} else {
			versionShit.visible = false;
		}

			if (controls.BACK) {
				FlxG.switchState(new OptionsMenu());
			}
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);	

			if (controls.ACCEPT)
			{
				if (curSelected != 1)
					grpControls.remove(grpControls.members[curSelected]);
				switch(curSelected)
				{
					case 0:
						FlxG.save.data.accuracyDisplay = !FlxG.save.data.accuracyDisplay;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Accuracy " + (FlxG.save.data.accuracyDisplay ? "on" : "off"), true, false);
						ctrl.itemType = "Vertical";
						ctrl.targetY = curSelected;
						grpControls.add(ctrl);
					case 1:

					case 2:
						FlxG.save.data.scoreBop = !FlxG.save.data.scoreBop;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Score Bop " + (FlxG.save.data.scoreBop ? "on" : "off"), true, false);
						ctrl.itemType = "Vertical";
						ctrl.targetY = curSelected - 2;
						grpControls.add(ctrl);
				}
			}

		if (FlxG.save.data.framerateCap < 60 || FlxG.save.data.framerateCap > 360)
			FlxG.save.data.framerateCap = 120;
		if (FlxG.save.data.framerateCap == null)
			FlxG.save.data.framerateCap = 120;
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end
		
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
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
