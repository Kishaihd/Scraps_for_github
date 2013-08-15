//creating a program that checks the number of bolts, nuts, and washers that someone is buying. 


void main() {
  print(orderChecker());
  print(orderChecker(numBolts: 12, numNuts: 12, numWash: 12));

}



String orderChecker({numBolts: 12, numNuts: 8, numWash: 24}) {
  //my constants for the function
  const int BOLT_P = 5; //price per bolt  
  const int NUT_P = 3; //price per nut
  const int WASH_P = 1; //price per washer

  //calculates the total price IN CENTS
  int totalP = numBolts * BOLT_P + numNuts * NUT_P + numWash * WASH_P;
  
  //construct output
  StringBuffer sb = new StringBuffer();
  sb.writeln("=================   WELCOME!   ===================");
  sb.writeln("Number of bolts: $numBolts");
  sb.writeln("Number of nuts: $numNuts");
  sb.writeln("Number of washers: $numWash");
  
  if (numBolts != numNuts) {
    sb.writeln();
    sb.writeln("Check the Order.");
    sb.writeln();
  }
  else {
    sb.writeln();
  }
  
  sb.writeln("Total cost: \$${(totalP / 100).toStringAsFixed(2)}");
  sb.writeln("------------------   Goodbye!   -------------------");
 
  
  
  return sb.toString();
}