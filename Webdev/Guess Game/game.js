var number = 35;

var guess = Number(prompt("Guess a number"));

if(guess < number) {
	alert("Your guess was too low");
}
else if(guess > number) {
	alert("Your guess was too high");
}
else {
	alert("You guessed the number!");
}