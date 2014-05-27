function searchTeamsOnClick(ocd) {
    var serviceCall = "http://go/teams/" + ocd.selectionText;
    console.log(serviceCall);
    chrome.tabs.create({url: serviceCall});
}

var cmid;

chrome.extension.onMessage.addListener(function(msg, sender, sendResponse) {
    if (msg.request === 'updateContextMenu') {
	var type = msg.selection;
	if (type == '') {
	    // Remove the context menu entry
	    if (cmid != null) {
		chrome.contextMenus.remove(cmid);
		cmid = null;
		// Invalidate entry now to avoid race conditions
	    }
	    // else: No contextmenu ID, so nothing to remove
	}
	else {
	    // Add/update context menu entry
	    var options = {
		title: "Search go/team for: " + type,
		contexts: ['selection'],
		onclick: searchTeamsOnClick
	    };
	    if (cmid != null) {
		chrome.contextMenus.update(cmid, options);
	    }
	    else {
		// Create new menu, and remember the ID
		cmid = chrome.contextMenus.create(options);
	    }
	}
    }
    });

// var search = chrome.contextMenus.create({"title": "Search Teams For " + window.getSelection.toString(),
// 					 "contexts": ["selection"],
// 					 "onclick": searchTeamsOnClick});
