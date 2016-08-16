import 'dart:io';
import '../lib/NMatrix.dart';

main(){
  NMatrix<int> nm = new NMatrix<int>(3,[3,3,3],5);
  stdout.writeln(nm.toString());


}