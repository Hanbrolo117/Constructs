import 'dart:io';
import '../lib/dart_constructs.dart';

void main() {
  NMatrix<int> oneDim = new NMatrix.dimensional([5]);
  oneDim.set([2], 5);
  String expectedToString = "{null,null,5,null,null}";
  String getTest = oneDim.toString();
  stdout.writeln();
  stdout.writeln(oneDim.toString());
  if (getTest == expectedToString) {
    stdout.writeln("Passed.");
  } else {
    stdout.writeln("Failed.");
  }

  try {
    //Expansion test:
    String expectedToString2 = "{{null,1},{null,1},{5,1},{null,1},{null,1}}";
    oneDim.dimensionalExpansion([5, 2], 1);
    stdout.writeln(oneDim.toString());
    String getTest2 = oneDim.toString();
    if (getTest2 == expectedToString2) {
      stdout.writeln("Passed.");
    } else {
      stdout.writeln("Failed.");
    }
  } catch (exception) {
    stdout.writeln("Out of range of Matrix Dimensions.");
    stdout.writeln("Exception: ${exception.toString()}");
  }

  //An Empty Matrix:
  oneDim = new NMatrix.dimensional([]);
  stdout.writeln(oneDim.toString());
}
