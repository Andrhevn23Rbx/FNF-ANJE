package options;

import flixel.FlxG;
import Discord.DiscordClient;

class OptimizationSubState extends BaseOptionsMenu
{
    var limitCount:Option;

    public static final SORT_PATTERN:Array<String> = [
        'Never',
        'After Note Spawned',
        'After Note Processed',
        'After Note Finalized',
        'Reversed',
        'Chaotic',
        'Random',
        'Shuffle'
    ];

    public function new()
    {
        #if DISCORD_ALLOWED
        DiscordClient.changePresence("Optimization Menu", null);
        #end

        title = 'Optimization Settings';
        rpcTitle = 'Optimization Settings Menu';

        // -- Basic Toggles --
        addOption(new Option('Chars & BG',
            'If unchecked, gameplay will only show the HUD.',
            'charsAndBG',
            'bool',
            true,
            null));

        addOption(new Option('Enable GC',
            "If checked, the game will garbage collect (may reduce RAM).",
            'enableGC',
            'bool',
            true,
            null));

        addOption(new Option('Light Opponent Strums',
            "If unchecked, Opponent strums won't light when notes are hit.",
            'opponentLightStrum',
            'bool',
            true,
            null));

        addOption(new Option('Light Botplay Strums',
            "If unchecked, Player strums won't light during Botplay.",
            'botLightStrum',
            'bool',
            true,
            null));

        addOption(new Option('Light Player Strums',
            "If unchecked, Player strums won't light up.",
            'playerLightStrum',
            'bool',
            true,
            null));

        addOption(new Option('Show Ratings',
            "Show rating sprites when hitting a note.",
            'ratingPopups',
            'bool',
            true,
            null));

        addOption(new Option('Show Combo Numbers',
            "Show combo numbers when hitting a note.",
            'comboPopups',
            'bool',
            true,
            null));

        addOption(new Option('Show MS Popup',
            "Show late/early hit accuracy in milliseconds.",
            'showMS',
            'bool',
            false,
            null));

        addOption(new Option('Even LESS Botplay Lag',
            "Reduce Botplay lag even further.",
            'lessBotLag',
            'bool',
            false,
            null));

        // -- Advanced Controls --
        addOption(new Option('Show Notes',
            "Unchecked = appearTime = 0. Botplay is forced.",
            'showNotes',
            'bool',
            true,
            null));

        addOption(new Option('Show Notes Again After Skip',
            "Prevent notes from appearing halfway through.",
            'showAfter',
            'bool',
            true,
            null));

        addOption(new Option('Keep Notes in Screen',
            "Show all notes top to bottom even if skippable.",
            'keepNotes',
            'bool',
            true,
            null));

        addOption(new Option('Sort Notes',
            "Sorts notes every frame. Can improve note processing.",
            'sortNotes',
            'string',
            'After Note Finalized',
            SORT_PATTERN));

        addOption(new Option('Faster Sort',
            "Sorts only visible objects for performance.",
            'fastSort',
            'bool',
            true,
            null));

        addOption(new Option('Better Recycling',
            "Use NoteGroup recycling for major performance boost.",
            'betterRecycle',
            'bool',
            true,
            null));

        // Limit Notes Option
        var limitOption = new Option('Max Notes Shown:',
            "Set to 0 for unlimited note rendering.",
            'limitNotes',
            'int',
            0,
            null);
        limitOption.scrollSpeed = 30;
        limitOption.minValue = 0;
        limitOption.maxValue = 99999;
        limitOption.changeValue = 1;
        limitOption.decimals = 0;
        limitOption.onChange = onChangeLimitCount;
        limitCount = limitOption;
        addOption(limitOption);

        // Advanced Spawning/Processing Options
        addOption(new Option('Invisible Overlapped Notes:',
            "Hides skipped overlapped notes to improve rendering.",
            'hideOverlapped',
            'float',
            0.0,
            null,
            10.0,
            0.1));

        addOption(new Option('Process Notes Before Spawning',
            "Massive perf boost. Recommended to enable.",
            'processFirst',
            'bool',
            true,
            null));

        addOption(new Option('Skip Process for Spawned Notes',
            "Skips note logic if already spawned. Improves perf.",
            'skipSpawnNote',
            'bool',
            true,
            null));

        addOption(new Option('Break on Time Limit Exceeded',
            "Stops spawn loop early if time exceeded.",
            'breakTimeLimit',
            'bool',
            true,
            null));

        addOption(new Option('Optimize Process for Spawned Note',
            "Processes note hit logic instantly after spawn.",
            'optimizeSpawnNote',
            'bool',
            true,
            null));

        // Lua/HScript Optimization Toggles
        addOption(new Option('Disable onSpawnNote Lua Calls',
            "Skips Lua calls when notes spawn.",
            'noSpawnFunc',
            'bool',
            true,
            null));

        addOption(new Option('Disable Note Hit Lua Calls',
            "Skips Lua calls for note hits.",
            'noHitFuncs',
            'bool',
            true,
            null));

        addOption(new Option('Disable Skipped Note Lua Calls',
            "Skips Lua calls for skipped notes.",
            'noSkipFuncs',
            'bool',
            true,
            null));

        addOption(new Option('noteHitPreEvent',
            "Disable noteHitPreEvent (may improve performance).",
            'noteHitPreEvent',
            'bool',
            true,
            null));

        addOption(new Option('noteHitEvent',
            "Disable noteHitEvent. Not recommended unless needed.",
            'noteHitEvent',
            'bool',
            true,
            null));

        addOption(new Option('noteHitEvent for Stages',
            "Disable stage-level noteHitEvent calls.",
            'noteHitStage',
            'bool',
            true,
            null));

        addOption(new Option('noteHitEvents for Skipped Notes',
            "Skips stage events for skipped notes.",
            'skipNoteEvent',
            'bool',
            true,
            null));

        addOption(new Option('spawnNoteEvent',
            "Disable Lua spawnNote events. Helps large charts.",
            'spawnNoteEvent',
            'bool',
            true,
            null));

        addOption(new Option('Disable Garbage Collector',
            "Disables GC during gameplay. Helps performance.",
            'disableGC',
            'bool',
            true,
            null));

        cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
        super();
    }

    function onChangeLimitCount() {
        limitCount.scrollSpeed = interpolate(30, 50000, (holdTime - 0.5) / 10, 3);
    }

    // Add this helper interpolation function
    function interpolate(start:Float, end:Float, amount:Float, pow:Float = 1):Float {
        var t = Math.min(Math.max(amount, 0), 1);
        if (pow != 1) t = Math.pow(t, pow);
        return start + (end - start) * t;
    }
}
