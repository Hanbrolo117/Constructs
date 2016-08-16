import 'dart:io';
import 'dart:core';
import '../lib/NMatrix.dart';
void main(){
  Stopwatch watch = new Stopwatch();
  watch.start();
  NMatrix<int> nm3d = new NMatrix<int>([1000,1000,1000], 50);
  watch.stop();
  stdout.writeln();
  stdout.writeln("Time Elapsed in seconds: ${watch.elapsedMilliseconds/1000}");
  //stdout.writeln("To build: \n ${nm3d.toString()}");



}