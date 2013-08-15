/*
 * A number guessing game were the player picks the number and the computer guesses it. 
 * The computer guesses a number between 1 and 100 that the user is thinking of.
 * Provide a menu for user feedback with questions for high, low, or correct guesses.
 * the optimal binary algorith yields a 7-guess maximum.
 */

import "dart:io";
import "dart:async";

const int MAX_GUESS = 100;

int floor = 0;  //needs to start at 0, or rounding will never result in a guess of 1.
int ceiling = MAX_GUESS;
int guesses = 0;
int lastGuess;

//bool menuState = false; //Using this boolean for our two "States" -because we only have 2.
//The above state would be included if we wanted the user to have to hit enter
//after every reply (print funtion) before the menu would be showed again.

Stream stream;
StreamSubscription streamSub;

void main() {
  print("\nRachel hates black babies so we're gonna play a number guessing game!"
        "\nThink of a whole number between 1 and $MAX_GUESS and I'll try to guess it!");
  print("\nPress <Enter> once you've got your number.");
  
  //create a reference to the stdin stream with 2 transforms
  stream = stdin.transform(new StringDecoder()).transform(new LineTransformer());
  
  //listens for events on the stdin stream
  streamSub = stream.listen(processInput);

}

void printMenu() {
  print("\n** MENU **"
        "\nGuess is too (h)igh"
        "\nGuess is too (l)ow"
        "\nGuess is (c)orrect"
      );
  
  //menuState = true;  //When using our two states!
}

void processInput(String line) {
  if (lastGuess == null) {
    guess();
    return;
  }
    
  /*if (!menuState) {
    printMenu();
    return;
  }*/
  
  //input is not case sensitive
  line = line.toLowerCase();
  
  //handle menu selections
  switch (line) {
    case 'h': ceiling = lastGuess; guess(); break;
    case 'l': floor = lastGuess; guess(); break;
    case 'c': win(); break;
    default:
      print("\nWhat was that, dumb dumb? Try again."
            "\nPress <enber> to continue"
          );
      printMenu();      
      break;
  }
}

void guess() {
  //calculate a new guess
  lastGuess = ((floor + ceiling) / 2).round(); //we could also use ~/ truncated division.
  
  //count each guess made
  guesses++;
  
  print("\nI guess... ummm... $lastGuess!");
    
  printMenu();
  /*print("\nPress <ENTER> to continue...");
   *menuState = false;
   */
}

void win() {
  //handle plurality
  //below says: if the String guess = guesses equals 1, use "guess" else use "guesses"
  String guess = guesses == 1 ? "guess" : "guesses"; //? is basically a shorthand "if else"
  
  print("\nBAM! $lastGuess! I guessed that shit in $guesses guesses!"
        "\nAMERICA!"  
      );
  streamSub.cancel();
}














