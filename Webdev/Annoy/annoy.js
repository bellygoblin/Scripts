var count = 1;
var areWeThereYet = prompt("Are we there yet?");

while(count === 1) {
	if(areWeThereYet === "yes" || areWeThereYet === "yeah") {
		alert("Yay we made it");
		count++;
	}
	else {
		var areWeThereYet = prompt("Are we there yet?");
	}
}