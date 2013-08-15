

import "dart:math" as Math;

void main() {
  print(roll(1, 2));
  print(roll(1, 4, 2));
  
  print(diceParse("1d4-3"));
  print(diceParse("d6+2"));
  print(diceParse("6d6"));
  print(diceParse("d8"));
  print(diceParse("duckshits"));
  print(diceParse("1d10"));
  print(diceParse("1d12+10"));
}
 int rollDie(int sides) {
   //the .nextInt function generates a random int between 0 and (max - 1)
   return new Math.Random().nextInt(sides) + 1;
 }
 
 String roll(int diceQty, int sides, [int mod = 0]) {
   
   int total = 0; //the absolute total, everything added together
   int rollsTotal = 0; //the total of x number of dice, before any mods.
   List<int> rolls = new List<int>(diceQty); //the list of every roll
   
   for (int i = 0; i < diceQty; i++) {
     rolls[i] = rollDie(sides);
     rollsTotal += rolls[i];
   
   }
   
   total = rollsTotal + mod; // this can be a +, because adding negative is the same as subtraction.
      
   String modString = (mod == 0)? "" : " " + (mod > 0 ? "+" : "-") + " " + mod.abs().toString();
   
   return "${diceQty}d$sides $rolls$modString = $total"; // 3d4 [3, 2, 4] + 8
 }

/*    we're partly doing this function to help us learn regular expressions.
 *    These Regular Expressions can validate input from the user, (emails, SSNs, etc) 
 *    take commands like in a text-based rpg, 
*/
 String diceParse(String text) {
   int qty = 1; //defaults
   int sides;
   int mod = 0;
   
  //strips out all the spaces and converts to lowercase
  text = text.replaceAll(' ', '').toLowerCase();
  
  //r means "raw"! (and is only a dart thing!) Like a raw string,
  // Meaning we won't need to use a backslash '\' to escape in order to use the "\d+".  
  String re1 = r'(\d+)*';        //multi-digit integer. The asterix means optional!
  String re2 = r'(d)';           //"d" (required)
  String re3 = r'(\d+)';         // multi-digit integer (require)
  String re4 = r'([-+]\d+)*';     // +/- and multi-digit integer (optional)
  
  RegExp exp = new RegExp(r"(\d+)*(d)(\d+)([-+]\d+)*", multiLine: false, caseSensitive: false);
  Match matches = exp.firstMatch(text); 
  //.firstMatch means we'll only look for/find this pattern (xdx+x) ONCE, meaning, if some butthole types 
  //"I roll a 1d6+9! blah blah", we're only going to care about the "1d6+9". 

  // DEBUG == just to show how this works, and if it's working.
  if (matches != null) {
    print("\n==============="
          "\nGroup Count: ${matches.groupCount}\n");
    for (int i = 0; i <= matches.groupCount; i++) {
      print("$i: ${matches[i]}");
    }
    print("===============");
  }
  else {
    print("\n========="
            "\nNO MATCH!"
           "\n=========");
  }
  
  if (matches == null) {
    return "Error 1";
  }
  
  // process qty
  if (matches[1] != null)  { //we don't have to do a try-catch, because if matches has a value in [1], 
                            //we know the RegExp caught it, and we KNOW it's a digit.
    int qtyInt = int.parse(matches[1]);
    qty = (qtyInt > 1) ? qtyInt : 1;
  }
  
  //process die sides
  sides = int.parse(matches[3]);
  if (sides == 0) 
    return "Error on \"matches[3]\"";
  
  // process modifier 
  if (matches[4] != null) {
    String match = matches[4]; //this "match" String only exists inside this if statement. Dart has lexical scoping.
  
    if (match.length > 1) {
      String sign = match[0]; //you can use this indexed operator on a String in dart, to access specific characters
                              //in a word. -Because String function is overloaded!
      int modInt = int.parse(match.substring(1, match.length));  
      //normally you'd have to use this .substring to do what what we've done with match up above.
    
      if (sign == "-") {
        modInt *= -1;
      }
      
      mod = modInt;
    }
  }
  return roll(qty, sides, mod);
}
 
 
// if (event.keycode == keycode.enter) {
//    roll();
// }
 
 
 
 
 
 
 
 
 
 
 