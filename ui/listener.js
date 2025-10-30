// ===================================================
// Byt FastMenu
// ===================================================

const closeKeys = ["Escape", "Backspace"];
let activeListeners = [];

// Initial setup (hide UI completely)
$(document).ready(() => {
    $("body").hide();
    $("#wrap").hide();

    // Listen for NUI messages
    window.addEventListener("message", (event) => {
        const { action, data } = event.data;
        if (action === "show") showMenu(data);
    });

    // Close when ESC or Backspace pressed
    $(document).on("keyup", (e) => {
        if (closeKeys.includes(e.key)) closeMenu();
    });

    // Hover sound setup
    const hoverTargets = [
        "#no-premium", "#premium", "#daily-tasks", "#shop",
        "#shop", "#invite-friends", "#weekly-offers", "#achievements",
        "#job-center", "#case-system", "#my-bills", "#my-family",
        "#inventory", "#open-case", "#change-time", "#clothe-system",
        "#usefull-buttons", "#commands"
    ];
    hoverTargets.forEach(sel => $(document).on("mouseenter", sel, () => playSound("select")));
});

// -------------------
// Helper functions
// -------------------
function playSound(type, error) {
    $.post(`https://Byt-FastMenu/playSound`, JSON.stringify({ action: type, error }));
}

function hideUI() {
    $("#wrap").fadeOut(200);
    $("body").fadeOut(200);
}

function closeMenu() {
    hideUI();
    removeListeners();
    $.post(`https://Byt-FastMenu/closeNUI`, JSON.stringify({}));
}

// -------------------
// SHOW MENU EVENT
// -------------------
function showMenu(data) {
    // Ensure everything visible but hidden before animation
    $("body").css("display", "block").css("opacity", 0);
    $("#wrap").css("display", "block").css("opacity", 0);

    // Small delay for smoothness & font preload
    setTimeout(() => {
        $("body").animate({ opacity: 1 }, 250);
        $("#wrap").animate({ opacity: 1 }, 300);
    }, 100);

    updateUI(data);
}

// -------------------
// UPDATE DATA IN MENU
// -------------------
function updateUI(data) {
    const buttons = data.buttons || {};
	$("#invite-friends-desc").text(data.announce || "");
    // Dynamic button mapping from config.lua
	
    Object.keys(buttons).forEach(key => {
        const btn = buttons[key];
        const selector = mapSelector(key); // convert name to element id
        if (selector && btn.trigger) {
            registerButton(selector, () => run(btn.type, btn.trigger));
        }
    });
	if (data.serverIcon && data.serverIcon !== "") {
    $("#server-icon").attr("src", data.serverIcon).show();
	} else {
		$("#server-icon").hide();
	}

}

// Helper to map key to actual selector IDs
function mapSelector(key) {
    const map = {
        announce: "#shop",
        achievements: "#achievements",
        jobcenter: "#job-center",
        myfamily: "#my-family",
        mybills: "#my-bills",
        inventory: "#inventory",
        cancelquest: "#achievements-random-button",
        casesystem: "#case-system",
        commands: "#commands"
    };
    return map[key];
}


// -------------------
// UTILITY FUNCTIONS
// -------------------
function createAchievements(data) {
    let completed = 0, total = 0;
    $.each(data, (_, list) => {
        list.forEach(item => {
            if (item.completed) completed++;
            total++;
        });
    });
    $("#achievements-count").text(completed);
    $("#achievements-total").text(`/ ${total}`);
}

function createannounce() {
    $("#shop").html(`
        <div id="levelbar"></div>
        <br/><br/><span id="announce-name">VIP Shop</span><br/>
    `);
}

function registerButton(selector, action) {
    if (!activeListeners.includes(selector)) {
        activeListeners.push(selector);
        $(document).on("click", selector, (e) => {
            e.stopPropagation();
            e.preventDefault();
            playSound("click");
            hideUI();
            action(e);
        });
    }
}


function removeListeners() {
    activeListeners.forEach(sel => $(document).off("click", sel));
    activeListeners = [];
}

function run(actionType, action) {
    $.post(`https://Byt-FastMenu/execute`, JSON.stringify({ actionType, action }));
    removeListeners();
}
