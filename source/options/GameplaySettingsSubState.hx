package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
#if android
import android.Hardware;
#end

using StringTools;

class GameplaySettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Configurações de Gameplay';
		rpcTitle = 'Gameplay Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Modo Controle',
			'Marque isso se voce quiser jogar\ncom o gamepad',
			'controllerMode',
			'bool',
			#if android true #else false #end);
		addOption(option);

		//I'd suggest using "Downscroll" as an example for making your own option since it is the simplest here
		var option:Option = new Option('Downscroll', //Name
			'Se marcada, as notas vão para baixo em vez de para cima,\n simples o suficiente.', //Description
			'downScroll', //Save data variable name
			'bool', //Variable type
			false); //Default value
		addOption(option);

		var option:Option = new Option('Middlescroll',
			'Se marcado as notas ficarao no meio da tela.',
			'middleScroll',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Toque Fantasma',
			"Se marcado, você não errará ao pressionar as teclas\nenquanto não houver notas que possam ser tocadas.",
			'ghostTapping',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Desativar a Tecla de Reset',
			"Se marcado, pressionar Reset não fará nada.",
			'noReset',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Hitsound Volume',
			'Volume do som de batidas"',
			'hitsoundVolume',
			'percent',
			0);
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;

		var option:Option = new Option('Compensação de classificação',
			'Muda o quão tarde/ou cedo você tem que acertar para um"Sick!"\nValores mais altos significam que você \ntem que acertar mais tarde.',
			'ratingOffset',
			'int',
			0);
		option.displayFormat = '%vms';
		option.scrollSpeed = 20;
		option.minValue = -30;
		option.maxValue = 30;
		addOption(option);

		var option:Option = new Option('Janela de Hit de Sick!',
			'Altera a quantidade de tempo que você tem\npara acertar um "Sick!" em milissegundos.',
			'sickWindow',
			'int',
			45);
		option.displayFormat = '%vms';
		option.scrollSpeed = 15;
		option.minValue = 15;
		option.maxValue = 45;
		addOption(option);

		var option:Option = new Option('Janela de Hit de Good',
			'Altera a quantidade de tempo que você tem\npara acertar um "Good" em milissegundos.',
			'goodWindow',
			'int',
			90);
		option.displayFormat = '%vms';
		option.scrollSpeed = 30;
		option.minValue = 15;
		option.maxValue = 90;
		addOption(option);

		var option:Option = new Option('Janela de Hit de Bad',
			'Altera a quantidade de tempo que você tem\npara acertar um "Bad" em milissegundos.',
			'badWindow',
			'int',
			135);
		option.displayFormat = '%vms';
		option.scrollSpeed = 60;
		option.minValue = 15;
		option.maxValue = 135;
		addOption(option);

		var option:Option = new Option('Frames Seguros',
			'Altera quantos quadros você tem para\nacionar uma nota mais cedo ou mais tarde.',
			'safeFrames',
			'float',
			10);
		option.scrollSpeed = 5;
		option.minValue = 2;
		option.maxValue = 10;
		option.changeValue = 0.1;
		addOption(option);

		#if android
		var option:Option = new Option('Vibração de GameOver',
			'Se desmarcado, fará o jogo vibrar quando você morrer.',
			'vibration',
			'bool',
			false);
		addOption(option);
		option.onChange = onChangeGameOverVibration;
		#end

		super();
	}

	#if android
	function onChangeGameOverVibration()
	{
		if(ClientPrefs.vibration)
		{
			Hardware.vibrate(500);
		}
	}
	#end
}
