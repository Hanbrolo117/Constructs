import 'dart:io';
import '../lib/dart_constructs.dart';

void main() {


  NMatrix<int> intMatrix = new NMatrix.dimensional([2,2,2],1);
  NMatrix<String> stringMatrix = new NMatrix.dimensional([1,1,1], "I am a 1x1x1 Cube!");
  NMatrix<double> doubleMatrix = new NMatrix.dimensional([3,2,2],3.14);


  //Testing toString Function
  //--------------------------------------------------------
  String intExpected = "{{{1,1},{1,1}},{{1,1},{1,1}}}";
  String stringExpected = "{{{I am a 1x1x1 Cube!}}}";
  String doubleExpected = "{{{3.14,3.14},{3.14,3.14}},{{3.14,3.14},{3.14,3.14}},{{3.14,3.14},{3.14,3.14}}}";

  stdout.writeln();
  stdout.writeln("Testing toString on 3 dimensional matrices:");
  stdout.writeln();

  //Testing integer Matrix:
  stdout.writeln("Integer Matrix:");
  stdout.writeln(intMatrix.toString());
  if(intMatrix.toString() == intExpected){
    stdout.writeln("Passed.");
  }else{
    stdout.writeln("Failed.");
  }
  stdout.writeln();


  //Testing String Matrix:
  stdout.writeln("String Matrix:");
  stdout.writeln(stringMatrix.toString());
  if(stringMatrix.toString() == stringExpected){
    stdout.writeln("Passed.");
  }else{
    stdout.writeln("Failed.");
  }
  stdout.writeln();


  //Testing double Matrix:
  stdout.writeln("Double Matrix:");
  stdout.writeln(doubleMatrix.toString());
  if(doubleMatrix.toString() == doubleExpected){
    stdout.writeln("Passed.");
  }else{
    stdout.writeln("Failed.");
  }
  stdout.writeln();
  //--------------------------------------------------------






  //Testing Getters & Setters
  //--------------------------------------------------------
  stdout.writeln("String Matrix:");
  String getterTestString = stringMatrix.getAt([0,0,0]);
  stdout.writeln("getterTestString: $getterTestString");
  if(getterTestString == "I am a 1x1x1 Cube!"){
    stdout.writeln("Passed");
  }else{
    stdout.writeln("Failed.");
  }
  stdout.writeln();

  stdout.writeln("Integer Matrix:");
  intMatrix.set([1,0,1],5);
  int getterTestInteger = intMatrix.getAt([1,0,1]);
  stdout.writeln("getterTestInteger: $getterTestInteger");
  if(getterTestInteger == 5){
    stdout.writeln("Passed");
  }else{
    stdout.writeln("Failed.");
  }
  stdout.writeln();

  stdout.writeln("Integer Matrix:");
  doubleMatrix.set([2,1,1],100.1);
  double getterTestDouble = doubleMatrix.getAt([2,1,1]);
  stdout.writeln("getterTestDouble: $getterTestDouble");
  if(getterTestDouble == 100.1){
    stdout.writeln("Passed");
  }else{
    stdout.writeln("Failed.");
  }
  stdout.writeln();
//--------------------------------------------------------

}