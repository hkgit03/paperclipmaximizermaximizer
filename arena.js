// Arena - run the bot, kill it, measure its fitness

(function(){

	const timeout = 5 * 1000; // in milliseconds

	console.log("Loading arena. Timeout in ms:", timeout);

	// run bot
	var interval = bot();
	setTimeout(
		function(){
			clearInterval(interval);
			var clips = document.getElementById("clips");
			var clipAmount = parseInt(clips.textContent);
			// TODO: Use clipAmount
		}, timeout);

})();
