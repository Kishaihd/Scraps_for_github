/*Code that takes input from a user and spits it back out. 
 * Like a boss.
 */

import "dart:io";      //io library brings Stream into play.
import "dart:async";   //async library brings in StreamSubscription.

const String JUDGEMENT_YOUNG = "Stop wasting your childhood! Go make friends!";
const String JUDGEMENT_GOOD = "Word, bro.";
const String JUDGEMENT_OLD = "Ah, a veteran to the ways of life, I see.";
const String JUDGEMENT_ANCIENT = "Sweet greasy pork chops you're old as fuck!";

Stream stream;                  //the gateway to the stdin stream
StreamSubscription streamSub;   //we need to subscribe to input events from the stream



List<Map<String, String>> dataKeys = [
/*List<String> dataKeys = [
  *"name",
  *"gender",
  *"age"
*];
*/
  {"propName": "verb1", "prompt": "verb"},
  {"propName": "verb2", "prompt": "verb"},  
  {"propName": "noun1", "prompt": "noun"}, 
  {"propName": "noun2", "prompt": "noun"},
  {"propName": "adv1", "prompt": "adverb"},
  {"propName": "adv2", "prompt": "adverb"},
  {"propName": "adj1", "prompt": "adjective"},
  {"propName": "adj2", "prompt": "adjective"},
  {"propName": "candy1", "prompt": "type of candy"},
  {"propName": "candy2", "prompt": "type of candy"}
];

Iterator dataKeyIterator = dataKeys.iterator;

Map<String, String> dataValues = {};

void main() {
  // create a reference to the stdin stream with 2 transformers
  stream = stdin.transform(new StringDecoder()).transform(new LineTransformer());
  
  // listen for events on the stdin stream
  streamSub = stream.listen(processInput);
  
  getInput();

}

/*I'm putting getInput here, because it will be called long before the processInput will be.
* this is just user/programmer preference.
*/
void getInput() {
  //if there's a new key to work with, prompt the user for that data -- otherwise, end program
  if (dataKeyIterator.moveNext()) {
    print("\nPlease enter a ${dataKeyIterator.current['prompt']}:");
  }           //we added the ['prompt'] into/after the .current to call the string
              //from our List<Map<String, String>> thing.
  else {
    end();
  }
  
}


void processInput(String line) {
  //save the data entered by the user
  dataValues[dataKeyIterator.current["propName"]]= line;
  
  //get the next user input value (if any)
  getInput();
}


/*at this point in the code, name and age have both been entered and stored. So this 
* where you would play with/add more code. Such as an if age > x say stuff statements.
*/

void end() {
  //echo the input data back to the user
  print("\nHey ${dataValues["name"]},");
 
  //int age = int.parse(dataValues["age"]); //putting this in the try loop.
  int age;
  
  try {
    //converts String age into int age
    age = int.parse(dataValues["age"]);
    
    if (age < 16) {
      print("\nI see you're a ${dataValues["age"]} year-old ${dataValues["gender"]}. $JUDGEMENT_YOUNG");
      
    }
    else if (age < 28) {
      print("\nI see you're a ${dataValues["age"]} year-old ${dataValues["gender"]}. $JUDGEMENT_GOOD");    
    }
    else if (age < 60) {
      print("\nI see you're a ${dataValues["age"]} year-old ${dataValues["gender"]}. $JUDGEMENT_OLD");
    }
    else if (age < 1000) {
      print("\nI see you're a ${dataValues["age"]} year-old ${dataValues["gender"]}. $JUDGEMENT_ANCIENT");
    }

  }
  catch (e) {
    print("\nHey wait a minute...Fuck you! That's not an age!");
  }
    //cancel the subscription to the stdin stream events
  streamSub.cancel();
}






