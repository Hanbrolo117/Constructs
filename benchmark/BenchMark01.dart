import 'dart:io';
import 'dart:core';
import '../lib/NMatrix.dart';
void main(){
  Stopwatch watch = new Stopwatch();
  watch.start();
  NMatrix<int> nm3d = new NMatrix.dimensional([20000,20000], 50);
  watch.stop();
  stdout.writeln();
  stdout.writeln("Time Elapsed in seconds to build ${nm3d.dimSizes[0]*nm3d.dimSizes[1]} datapoints: ${watch.elapsedMilliseconds/1000}");
  //stdout.writeln("To build: \n ${nm3d.toString()}");



}