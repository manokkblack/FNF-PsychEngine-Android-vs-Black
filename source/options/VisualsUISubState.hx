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

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Visuais e UI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Note Splashes',
			"Se desmarcado, e acertar um \"Sick!\" as notas não mostrarão partículas.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Esconder HUD',
			'Se marcado, oculta a maioria dos elementos do HUD.',
			'hideHud',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Barra de Tempo:',
			"Quando a barra de tempo deve aparecer?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'Disabled']);
		addOption(option);

		var option:Option = new Option('Flashes de Luz',
			"Desmarque isso se você for sensível a luzes piscando!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zooms de Camera',
			"Se desmarcada, a câmera não ampliará nos hits de batida.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zooms de texto de pontuacao',
			"Se desmarcada, desativa o zoom do texto da Pontuação\nsempre que você toca uma nota.",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Opacidade da Barra de Vida',
			'Quão transparente deve ser a barra de vida e os ícones.',
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		var option:Option = new Option('Contador de FPS',
			'Se desmarcado, oculta o Contador de FPS',
			'showFPS',
			'bool',
			#if android false #else true #end);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		
		var option:Option = new Option('Pause da música na tela:',
			"Qual música você prefere para a tela de pausa?",
			'pauseMusic',
			'string',
			'Tea Time',
			['None', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;

		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}

	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
}
