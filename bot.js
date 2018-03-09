// This is the simplest example bot. For testing the arena.
// It just keeps pressing "Make paperclip"

function bot(){
	var increase = 1

	function botRound(){
		var button = document.getElementById("btnMakePaperclip");
		for(i=0;i<increase;i++){
			button.click()
		}
		increase++;
	}

	return setInterval(botRound, 1000);
}
