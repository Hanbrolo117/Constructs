import 'dart:io';
import '../lib/NMatrix.dart';

main() {
  NMatrix<int> twoByThree = new NMatrix.dimensional([2, 3], 1);

  stdout.writeln();
  stdout.writeln(
      "A Dynamic Dimensional Integer Matrix of the form ${twoByThree.dimSizes[0]}x${twoByThree.dimSizes[1]}:");
  for (int i = 0; i < twoByThree.dimSizes[0]; i++) {
    for (int j = 0; j < twoByThree.dimSizes[1]; j++) {
      stdout.write(twoByThree.getAt([i, j]).toString() + "\t");
    }
    stdout.writeln();
  }

  NMatrix<String> twoByThreeS = new NMatrix.dimensional([3, 3], "Hey!");

  stdout.writeln();
  stdout.writeln(
      "A Dynamic Dimensional String Matrix of the form ${twoByThreeS.dimSizes[0]}x${twoByThreeS.dimSizes[1]}:");
  for (int i = 0; i < twoByThreeS.dimSizes[0]; i++) {
    for (int j = 0; j < twoByThreeS.dimSizes[1]; j++) {
      stdout.write(twoByThreeS.getAt([i, j]).toString() + "\t");
    }
    stdout.writeln();
  }
  stdout.writeln();
  stdout.writeln(twoByThree.toString());
  stdout.writeln();
  stdout.writeln();
  stdout.writeln(twoByThreeS.toString());
  stdout.writeln("In the source code the only change I had to make was the generic type and dimension sizes in the constructor.\n"
      "The remaining code stayed unchanged. This makes it very easy to create very different types of matrices with little work!");
}
