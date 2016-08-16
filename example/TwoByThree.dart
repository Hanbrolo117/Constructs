import 'dart:io';
import '../lib/NMatrix.dart';

main() {
  NMatrix<int> twoByThree = new NMatrix<int>(2, [2, 3], 1);

  stdout.writeln();
  stdout.writeln(
      "A Dynamic Dimensional Integer Matrix of the form ${twoByThree.getDimensionSizes()[0]}x${twoByThree.getDimensionSizes()[1]}:");
  for (int i = 0; i < twoByThree.getDimensionSizes()[0]; i++) {
    for (int j = 0; j < twoByThree.getDimensionSizes()[1]; j++) {
      stdout.write(twoByThree.getAt([i, j]).toString() + "\t");
    }
    stdout.writeln();
  }

  NMatrix<String> twoByThreeS = new NMatrix<String>(2, [3, 3], "Hey!");

  stdout.writeln();
  stdout.writeln(
      "A Dynamic Dimensional String Matrix of the form ${twoByThreeS.getDimensionSizes()[0]}x${twoByThreeS.getDimensionSizes()[1]}:");
  for (int i = 0; i < twoByThreeS.getDimensionSizes()[0]; i++) {
    for (int j = 0; j < twoByThreeS.getDimensionSizes()[1]; j++) {
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
