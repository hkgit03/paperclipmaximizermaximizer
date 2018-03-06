// This is the simplest example bot. For testing the arena.
// It just keeps pressing "Make paperclip"

console.log("loading bot")

var foo = 1

function bot(){
	setInterval(botRound, 1000);
}

function botRound(){
	var button = document.getElementById("btnMakePaperclip");
	for(i=0;i<foo;i++){
		button.click()
	}
	foo++;
}
