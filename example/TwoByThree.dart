import 'dart:io';
import '../lib/NMatrix.dart';

main(){
  NMatrix<int> twoByThree = new NMatrix<int>(2,[2,3],1);

  stdout.writeln();
  stdout.writeln("A Dynamic Dimensional Integer Matrix of the form ${twoByThree.getDimensionSizes()[0]}x${twoByThree.getDimensionSizes()[1]}:");
  for(int i=0; i < twoByThree.getDimensionSizes()[0]; i++){
    for(int j = 0; j < twoByThree.getDimensionSizes()[1]; j++){
        stdout.write(twoByThree.getAt([i,j]).toString()+"\t");
    }
    stdout.writeln();
  }



}