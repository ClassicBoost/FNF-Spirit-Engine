package;

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

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;
	var versionShit:FlxText;
	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		controlsStrings = CoolUtil.coolStringFile("Offset" + "\n" + (FlxG.save.data.dfjk ? 'DFJK' : 'WASD') + "\n" + (FlxG.save.data.newInput ? "Kade input" : "Vanilla Input") + "\n" + (FlxG.save.data.ghostTapping ? "Ghost Tapping" : "No Ghost Tapping") + "\n" + (FlxG.save.data.downscroll ? 'Downscroll' : 'Upscroll') + "\nAccuracy " + (FlxG.save.data.accuracyDisplay ? "on" : "off") + "\nNotesplashes " + (FlxG.save.data.noteSplash ? "on" : "off") + "\nHitsounds " + (FlxG.save.data.hitsounds ? "on" : "off") + "\nFlasing Lights " + (FlxG.save.data.flashing ? "on" : "off") + "\nBotplay " + (FlxG.save.data.botplay ? "on" : "off") + "\nPractice Mode " + (FlxG.save.data.practiceMode ? "on" : "off") + "\nLoad replays");
		
		trace(controlsStrings);

		menuBG.color = 0xFF666BFF;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		FlxG.sound.playMusic(Paths.music('TheAmbience'));

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
				var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, controlsStrings[i], true, false);
				controlLabel.isMenuItem = true;
				controlLabel.targetY = i;
				grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}


		versionShit = new FlxText(5, FlxG.height - 100, FlxG.width, "Change your offsets\n" + FlxG.save.data.offset, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.borderSize = 1.5;
		add(versionShit);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

			if (controls.BACK) {
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
				FlxG.switchState(new MainMenuState());
			}
			if (controls.UP_P) {
				if (!FlxG.save.data.newInput && curSelected == 4)
				changeSelection(-1);
				changeSelection(-1);
			}
			if (controls.DOWN_P) {
				if (!FlxG.save.data.newInput && curSelected == 2)
				changeSelection(1);
				changeSelection(1);
			}
			
			if (curSelected == 0) {
				versionShit.text = "Change your offsets\n" + FlxG.save.data.offset;
			if (controls.RIGHT_R)
			{
				FlxG.save.data.offset++;
			}
			if (controls.LEFT_R)
			{
				FlxG.save.data.offset--;
			}
			}
			if (curSelected == 1)
				versionShit.text = 'Change your controls. (WIP)';
			if (curSelected == 2) {
				if (FlxG.save.data.newInput)
				versionShit.text = 'Kade Engine input fixes the broken input system.'
				else
				versionShit.text = 'Vanilla input is the og broken input and it forces ghost tapping off.';
			}
			if (curSelected == 3) {
				if (FlxG.save.data.ghostTapping)
				versionShit.text = 'You will only miss if you don\'t hit the note.\nThis can remove a lot of the challenge since you can mash';
				else
				versionShit.text = 'After your turn starts; Ghost tapping will disable itself\nYou will miss if you press a invaild note.';
			}
			if (curSelected == 4)
				versionShit.text = 'Choose where you want the notes to come from.';
			if (curSelected == 5)
				versionShit.text = 'With this on, your accuracy and misses will display.';
			if (curSelected == 6)
				versionShit.text = 'With this on, note splashes will appear if you hit a sick.';
			if (curSelected == 7)
				versionShit.text = 'With this on, everytime you hit a note a \"Tick\" sound will play.';
			if (curSelected == 8)
				versionShit.text = 'Turn this off if you\'re sensitive to flashing lights!';
			if (curSelected == 9)
				versionShit.text = 'Turn this on if you want the bot to play for you.';
			if (curSelected == 10)
				versionShit.text = 'Turn this on if you don\'t wanna die.';
			if (curSelected == 11)
				versionShit.text = 'Replay through the songs you\'ve played.';
	

			if (controls.ACCEPT)
			{
				if (curSelected != 11)
					grpControls.remove(grpControls.members[curSelected]);
				switch(curSelected)
				{
					case 0:
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Offset", true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected;
						grpControls.add(ctrl);
					case 1:
						FlxG.save.data.dfjk = !FlxG.save.data.dfjk;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.dfjk ? 'DFJK' : 'WASD'), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected;
						grpControls.add(ctrl);
						if (FlxG.save.data.dfjk)
							controls.setKeyboardScheme(KeyboardScheme.Solo, true);
						else
							controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);
						
					case 2:
						FlxG.save.data.newInput = !FlxG.save.data.newInput;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.newInput ? "Kade input" : "Vanilla Input"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 1;
						grpControls.add(ctrl);
						changeSelection();
					case 3:
						FlxG.save.data.ghostTapping = !FlxG.save.data.ghostTapping;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.ghostTapping ? "Ghost Tapping" : "No Ghost Tapping"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 1;
						grpControls.add(ctrl);
						changeSelection();
					case 4:
						FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, (FlxG.save.data.downscroll ? 'Downscroll' : 'Upscroll'), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 2;
						grpControls.add(ctrl);
						changeSelection();
					case 5:
						FlxG.save.data.accuracyDisplay = !FlxG.save.data.accuracyDisplay;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Accuracy " + (FlxG.save.data.accuracyDisplay ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 3;
						grpControls.add(ctrl);
						changeSelection();
					case 6:
						FlxG.save.data.noteSplash = !FlxG.save.data.noteSplash;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Notesplashes " + (FlxG.save.data.noteSplash ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 3;
						grpControls.add(ctrl);
						changeSelection();
					case 7:
						FlxG.save.data.hitsounds = !FlxG.save.data.hitsounds;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Hitsounds " + (FlxG.save.data.hitsounds ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 3;
						grpControls.add(ctrl);
						changeSelection();
					case 8:
						FlxG.save.data.flashing = !FlxG.save.data.flashing;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Flasing Lights " + (FlxG.save.data.flashing ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 3;
						grpControls.add(ctrl);
						changeSelection();
					case 9:
						FlxG.save.data.botplay = !FlxG.save.data.botplay;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Botplay " + (FlxG.save.data.botplay ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 3;
						grpControls.add(ctrl);
						changeSelection();
					case 10:
						FlxG.save.data.practiceMode = !FlxG.save.data.practiceMode;
						var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "Practice Mode " + (FlxG.save.data.practiceMode ? "on" : "off"), true, false);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 3;
						grpControls.add(ctrl);
						changeSelection();
					case 11:
						trace('switch');
						FlxG.switchState(new LoadReplayState());
				}
			}
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
