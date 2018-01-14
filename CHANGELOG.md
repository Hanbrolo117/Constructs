<h1>dart_construct ChangeLog</h1>
<h3>Version 1.1.3 Released</h3>
<hr>
<ul>
<li>Removed unnecessary dependency on the dart:io library</li>
</ul>
<h3>Version 1.1.2 Released</h3>
<hr>
<ul>
<li>Fixed some spelling and grammatical errors</li>
<li>Updated some tests.</li>
<li>Added a benchmark test. In object vs primitives, Java primitives beat NMatrix. However, everything is an object in Dart, therefore there is an object vs object test. Java Arraylists get stackOverflow, where NMatrix continues to perform. See GitHub for test code.</li>
</ul>
<h3>Version 1.1.1 Released</h3>
<hr>
<p>Fixed Changelog Style Error.</p>
<h3>Version 1.1.0 Released</h3>
<hr>
<p>
<b>Not enough tests for dimensionalExpansion have been made to confirm stability.</b>
This version is patch to an incorrect implementation of the dimensionalExpansion algorithm from
version 1.0.0. In the previous version, the matrix was linearized and then sequentially placed into
each position of the new matrix. This was quickly realized to be both a poor and incorrect implementation as
the old values where not truly placed into their new relative positions. This has now been fixed with an updated
matrixPorting algorithm. If future tests reveal any minor errors, updates to 1.1 will be made. 
</p>
<h3>Version 1.0.0 Released</h3>
<hr>
<p>
This is the initial release of dart_construct. The initial release contains the initial implementation of the NMatrix class. 
Future changes may occur, for any errors or non-negligible performance enhancements. Also Future classes may be implemented alongside NMatrix.
<b>Not all functions have been fully tested</b>
</p>


