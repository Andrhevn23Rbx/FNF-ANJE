import options.CustomPopupOption; // Import the new class at the top

// Inside your constructor `new()`:

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
