import 'dart:io';
import '../lib/dart_constructs.dart';

main() {
  //Create a 2x3 matrix:
  //------------------------------------------------------------
  NMatrix<int> twoByThree = new NMatrix.dimensional([2, 3], initValue: 1);
  //------------------------------------------------------------

  //Print Some stuff
  //------------------------------------------------------------
  stdout.writeln();
  stdout.writeln(
      "A Dynamic Dimensional Integer Matrix of the form ${twoByThree.dimSizes[0]}x${twoByThree.dimSizes[1]}:");
  //------------------------------------------------------------

  //One way we can Display the 2x3 matrix:
  //------------------------------------------------------------
  for (int i = 0; i < twoByThree.dimSizes[0]; i++) {
    for (int j = 0; j < twoByThree.dimSizes[1]; j++) {
      stdout.write(twoByThree.getAt([i, j]).toString() + "\t");
    }
    stdout.writeln();
  }
  //------------------------------------------------------------

  //Let's create another one with a different type!!
  //------------------------------------------------------------
  NMatrix<String> twoByThreeS = new NMatrix.dimensional([3, 3], initValue: "Hey!");
  //------------------------------------------------------------

  //Print Some stuff
  //------------------------------------------------------------
  stdout.writeln();
  stdout.writeln(
      "A Dynamic Dimensional String Matrix of the form ${twoByThreeS.dimSizes[0]}x${twoByThreeS.dimSizes[1]}:");
  //------------------------------------------------------------

  //And as before we can display this using some for's over the respective dimension Sizes:
  //------------------------------------------------------------
  for (int i = 0; i < twoByThreeS.dimSizes[0]; i++) {
    for (int j = 0; j < twoByThreeS.dimSizes[1]; j++) {
      stdout.write(twoByThreeS.getAt([i, j]).toString() + "\t");
    }
    stdout.writeln();
  }
  //------------------------------------------------------------

  //Why don't we see what the toString method does for us!?
  //------------------------------------------------------------
  stdout.writeln();
  stdout.writeln("The Integer Matrix:");
  stdout.writeln(twoByThree.toString());
  stdout.writeln();
  stdout.writeln("The String Matrix:");
  stdout.writeln(twoByThreeS.toString());
  stdout.writeln();
  //------------------------------------------------------------

  //Let's Notify the user of the program how nice and concise this object makes making dimensional matrices in Dart is:
  //------------------------------------------------------------
  stdout.writeln(
      "In the source code the only change I had to make was the generic type and dimension sizes in the constructor.\n"
      "The remaining code stayed unchanged. This makes it very easy to create very different types of matrices with little work!");
  //------------------------------------------------------------
}
