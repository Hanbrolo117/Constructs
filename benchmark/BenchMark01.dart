import 'dart:io';
import 'dart:async';
import 'dart:core';
import '../lib/dart_constructs.dart';


Future main()async {
  Stopwatch benchmark = new Stopwatch();

  stdout.writeln("\nBuild Log:");
  stdout.writeln("-------------------------");
  stdout.writeln("\nExecuting Java Code for primitive datatype build...");
  benchmark.start();
  ProcessResult t1 = await javaOneTest();
  stdout.writeln("Java build complete.");
  stdout.writeln("Executing Java Code for object datatype build...");
  ProcessResult t2 = await javaTwoTest();
  stdout.writeln("Java build complete.");
  stdout.writeln("Dart is running first object datatype build...");
  Stopwatch fwatch1 = await dartOneTest();
  stdout.writeln("Dart build complete.");
  stdout.writeln("Dart is running second object datatype build...");
  Stopwatch fwatch2 = await dartOneTest();
  benchmark.stop();
  stdout.writeln("Dart build complete.");
  stdout.writeln("-------------------------");

  stdout.writeln("\nBenchMark Results:");
  stdout.writeln("-------------------------\n");

  stdout.writeln("Dart_NMatrix build result: ${fwatch1.elapsedMilliseconds/1000} seconds to build 400000000 dataPoints.");
  stdout.writeln("- VS -");
  stdout.writeln("Java build-Primitive result: ${t1.stdout}\n");

  stdout.writeln("Note: This is an object data type matrix versus a primitive datatype matrix.\n"
      "The second test is an object datatype vs object data type.\n");


  stdout.writeln("Dart_NMatrix build result: ${fwatch2.elapsedMilliseconds/1000} seconds to build 400000000 dataPoints.");
  stdout.writeln("- VS -");
  stdout.writeln("Java build-Object result: ${t2.stdout}");
  stdout.writeln("\n-------------------------\n");

  stdout.writeln("\nBenchmark Test took: ${benchmark.elapsedMilliseconds/1000} seconds");


}

Stopwatch createMatrixTest(){
  Stopwatch watch = new Stopwatch();
  watch.start();
  NMatrix<int> nm3d = new NMatrix.dimensional([20000,20000], 50);
  watch.stop();
  return watch;
}

Future<Stopwatch> dartOneTest() async{
  Future<Stopwatch> f = new Future(() => createMatrixTest());
  return f;
}

Future<ProcessResult> javaOneTest() async{
  return Process.run('java',['-cp','benchmark/java','javaTest01','one']);
}

Future<ProcessResult> javaTwoTest() async{
  return Process.run('java',['-cp','benchmark/java','javaTest01','two']);
}