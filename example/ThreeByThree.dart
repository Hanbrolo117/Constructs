import 'dart:io';
import '../lib/NMatrix.dart';

main(){
  NMatrix<int> nm3 = new NMatrix<int>([3,3,3],5);
  NMatrix<int> nm4 = new NMatrix<int>([2,2,2,2],2);
  stdout.writeln(nm3.toString());
  stdout.writeln();
  stdout.writeln(nm4.toString());


}