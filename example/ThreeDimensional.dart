import 'dart:io';
import '../lib/dart_constructs.dart';

main() {
  //Here is a Cube with dimensions: 3x3x3 =>
  NMatrix<int> nm3 = new NMatrix.dimensional([3, 3, 3], initValue: 5);

  //Let's see what this matrix is made of!
  stdout.writeln();
  stdout.writeln("A simple 3x3x3 cube:");
  stdout.writeln(nm3.toString());
  stdout.writeln();

  //You know... 3 dimensions are kinda cool, but lets face it, we programmers are ALL
  //about the future so why don't we kick this up a noche...or should I say, a dimension? No... tough crowd.
  nm3.dimensionalExpansion([3, 3, 3, 3], 7);

  //You might want to throw those 3d glasses away and get a pair of 4d glasses for this one folks...
  stdout.writeln();
  stdout.writeln("The above matrix converted/expanded to 4 dimensions.");
  stdout.writeln(
      "You might want to throw those 3d glasses away and get a pair of 4d glasses for this one folks...");
  stdout.writeln(nm3.toString());
  stdout.writeln();

  //The 4th Dimension is so Sugary!
  //A 3x2x2x2 matrix; think 3 2x2x2 cubes!
  stdout.writeln("The 4 dimensional Pi matrix: 3x1x4x1:");
  NMatrix<double> nm4 = new NMatrix.dimensional([3, 1, 4, 1], initValue: 3.14);

  stdout.writeln(nm4.toString());
}
