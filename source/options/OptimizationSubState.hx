package options;

import flixel.FlxG;
import flixel.text.FlxText;
import options.OptionCategory;
import options.CustomPopupOption; // Don't forget to import this

class OptimizationSubState extends BaseOptionsMenu
{
    public function new()
    {
        super();
        title = 'Optimization';
        rpcTitle = 'Optimization Menu'; // For Discord RPC if used

        // Add your popup toggle options
        addOption(new CustomPopupOption('Show Combo Popup',
            "Show combo numbers when hitting a note.",
            'comboPopups',
            true));

        addOption(new CustomPopupOption('Show Rating Popup',
            "Show rating sprites when hitting a note.",
            'ratingPopups',
            true));

        addOption(new CustomPopupOption('Show Number Popup',
            "Show number popups on hit.",
            'numberPopups',
            true));
    }
}
