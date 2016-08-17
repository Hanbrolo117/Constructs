import 'dart:io';

/// NMatrix class.
class NMatrix<T> {
  ///List of the Sizes for each dimension on the Nth Dimensional Matrix.
  List<int> _dimensionSizes;

  ///The integer value representing the number of dimensions that this object has.
  int _matrixDimension;

  ///The first Dimension that is extruded to n dimensions where n = matrixDimensions.
  List _core;

  ///This is the Generic Type value of which the matrix will initially be set to.
  T _initValue;

  ///This keeps track of the number of data points which make up the matrix construct.
  int _dataPointCount;

  ///This is a variable that helps in the linearization of the current matrix construct for porting
  ///to the new matrix construct in the dimensionalExpansion Algorithm.
  int _linearCount;

//Constructors & Initializers
//--------------------------------------------------------------------------------

  ///The no-args constructor of an nth dimensional matrix construct.
  ///
  /// This constructor creates a 10x10 matrix with an initial value of null.
  /// Don't worry you can always expand the size of a matrix construct.
  NMatrix(){
    this._matrixDimension = 2;
    this._dimensionSizes = [10,10];
    this._initValue = null;
    this._dataPointCount = 0;
    this._core = this._extrude(0, this._matrixDimension, this._dimensionSizes);
    this._linearCount = 0;
  }

  ///Constructor for an nth Dimensional Matrix Construct.
  ///
  /// This Constructor takes in one parameter, that is the [dimensions] which is a list
  /// of integer representations of the sizes for each of the new dimensions. The length if
  /// [dimensions] represents the NUMBER of dimensions the matrix construct has. The last
  /// parameter is a named optional parameter [initValue] which is the initial value to set
  /// each value in the matrix construct to.
  NMatrix.dimensional(List<int> dimensions, [T initValue = null]) {
    this._matrixDimension = dimensions.length;
    this._dimensionSizes = dimensions;
    this._initValue = initValue;
    this._dataPointCount = 0;
    this._core = this._extrude(0, this._matrixDimension, this._dimensionSizes);
    this._linearCount = 0;
  }

  ///Extrudes Matrix to n dimensions.
  ///
  /// This function is critical to the initialization of the nth Dimensional Matrix Construct.
  /// It Recursively Constructs all [matrixDim] dimensions of the Matrix setting the value at each position to this initialValue,
  /// of which unless specified otherwise as a named optional parameter, is by default null., where
  /// [currentDim] is the current depth of the recursive tree and each dimension k has a size equal to the value at
  /// the kth index of [dimSizes]. Returns the newly created matrix construct.
  List _extrude(int currentDim, int matrixDim, List<int> dimSizes) {
    //BaseCase:
    if ((currentDim + 1) == matrixDim) {
      ///This is the last Dimension to Extrude the Matrix by.
      List<T> lastDim = new List<T>(dimSizes[currentDim]);
      for (int k = 0; k < dimSizes[currentDim]; k++) {
        //Increment the number of dataPoints in the matrix by one:
        this._dataPointCount += 1;
        //Inistantiate the last Dimension with the initial value of the Nth Dimensional Matrix.
        lastDim[k] = this._initValue;
      }
      //Return the last dim to be set to the current location of the previous Dimensional point, thus extruding that point
      //by the last Dimension.
      return lastDim;
    } else {
      ///Create the nth dimensional list and set each dimension point to the fully extruded dimensional List returned by the extrude function.
      List<List> dimN = new List<List>(dimSizes[currentDim]);
      for (int k = 0; k < dimSizes[currentDim]; k++) {
        int next = currentDim + 1;
        dimN[k] = this._extrude(next, matrixDim, dimSizes);
      }
      return dimN;
    }
    //This point should never be reached, If it is, then there was an error, thus code calling this function should check for
    //a return value of null to handle such a case.
    return null;
  }

  ///Dimensional Expander algorithm.
  ///
  /// This algorithm essentially creates a new matrix construct with a number of dimensions equal to the length of [dimensionSizes] with each dimension k having a size
  /// equal to the value at the kth index in [dimensionSizes]. It also ports all values of the data points of the old matrix construct to their same
  /// "dimensional address" in the new matrix construct. All remaining values in the new matrix construct are set to [initVal].
  /// This algorithm then replaces the core of this object with the new matrix construct. Returns true if expansion was successful,
  /// and false otherwise. Note, to expand a matrix construct, a new matrix's dimensions can only be >= the current number of dimensions.
  /// Also, for each new dimension to the number of dimensions of the current matrix construct, each dimensions Size can only be >= each of the
  /// current matrix dimension's sizes. This ensures there is no "shrinking" effect which would cause a loss in data of the current matrix.
  /// For instance, {2,2,2} => {2,3,2} | {2,2,2,3} | {2,2,2,1} is valid, but {2,2,2} => {1} | {2,2,1,2} is invalid.
  bool dimensionalExpansion(List<int> dimensionSizes,[T initVal = null]) {
    bool isExpanded = false;
    if (dimensionSizes.length >= this._matrixDimension) {
      bool validFlag = true;
      int k = 0;
      while ((k < this._dimensionSizes.length) && (validFlag)) {
        if (dimensionSizes[k] < this._dimensionSizes[k]) {
          validFlag = false;
        }
        k++;
      }
      if (validFlag) {
        //If Expanded Dimensions are Valid, Port existing values to new expanded Matrix Construct:
        //Set the initValue to the new initial value, if one is provided. Otherwise set it to null.
        //already is.
        this._initValue = initVal;

        //Reset dataPointCount before running extrude for the new matrix construct.
        this._dataPointCount = 0;

        //Extrude the new matrix to the defined number of dimensions.
        List _newCore = this._extrude(0, dimensionSizes.length, dimensionSizes);

        //Linearize current Matrix core for porting it's data to the new matrix core:
        List linearMatrix = this._linearize(0,this._core);

        //Set the new list of dimensionSizes:
        this._dimensionSizes = dimensionSizes;
        //Set to new number of dimensions:
        this._matrixDimension = dimensionSizes.length;

        //Port the old dataPoints in the current core to the new core.
        this._matrixPort(0, _newCore, linearMatrix);

        //Reset LinearCount for next expansion use.
        this._linearCount = 0;

        //Finally, swap the cores:
        this._core = _newCore;

        //Notify flag:
        isExpanded = true;
      }
    }
    return isExpanded;
  }

  List _linearize(int currentDim, List currentList){
    //Base Case
    if ((currentDim + 1) == this._matrixDimension) {
      List<T> lst = new List();
      for (int k = 0; k < currentList.length; k++) {
        //Port value in old matrix to the same relative position in the new matrix:
        lst.add(currentList[k]);
      }
      return lst;
    }
    else {
      List linearMatrix = new List();
      ///the nth dimensional list and set each dimension point to the fully extruded dimensional List returned by the extrude function.
      for (int k = 0; k < currentList.length; k++) {
        int next = currentDim + 1;
        linearMatrix.addAll(this._linearize(next, currentList[k]));
      }
      return linearMatrix;
    }//End else
  }//End matrixPort Algorithm.

  void _matrixPort(int currentDim, List newList,List linearMatrix){
    //Base Case
    if(this._linearCount >= linearMatrix.length){
      return;
    }
    else if ((currentDim + 1) == this._matrixDimension) {
      for (int k = 0; k < newList.length; k++) {
        //Port value in old matrix to the same relative position in the new matrix:
        newList[k] = linearMatrix[this._linearCount];
        this._linearCount += 1;
      }
    }
    else {
      ///the nth dimensional list and set each dimension point to the fully extruded dimensional List returned by the extrude function.
      for (int k = 0; k < newList.length; k++) {
        int next = currentDim + 1;
        this._matrixPort(next, newList[k],linearMatrix);
        if(this._linearCount >= linearMatrix.length){
          return;
        }
      }
    }//End else
  }//End matrixPort Algorithm.
//--------------------------------------------------------------------------------

//Getter(s) & Setter(s)
//--------------------------------------------------------------------------------

  ///Getter for the initialValue.
  ///
  /// This function returns [_initValue] which is the value that each data point in
  /// this matrix construct was instantiated to.
  T get initialValue => this._initValue;


  ///Getter for the number of dimensions.
  ///
  /// This function returns [_matrixDimension] which is the number of dimensions
  /// this matrix has. For instance, a matrix with 3 dimensions would be a cube.
  int get matrixDimensions => this._matrixDimension;


  ///Getter for the number of data points.
  ///
  /// This functions returns [_dataPointCount] which is the total number of data points
  /// that make up this matrix construct. For instance, a 3x3x3 matrix construct would have
  /// 27 data points, as 3*3*3 = 27.
  int get dataPointCount => this._dataPointCount;


  ///Getter for the sizes of each dimension in the matrix construct.
  ///
  /// Returns a list of sizes for each dimension in the matrix construct.
  List get dimSizes => this._dimensionSizes;



  ///Gets the "core" of the dimensional matrix construct.
  ///returns the core of the dimensional matrix construct.
  List get matrix => this._core;


  ///Gets the T type value at the dimension address provided.
  ///
  /// Since this object can have n dimensions,  value's position in the Matrix is
  /// referred to as it's [dimensionAddress]. If the length of the [dimensionAddress]
  /// does not match the matrix's dimensions an error is thrown. If at each point in
  /// the dimension address, the value is out of bounds of that dimensions range, an
  /// error is thrown. Returns The value at the given dimensional address.
  T getAt(List<int> dimensionAddress) {
    List get = this._core;
    T returnVal = null;
    if (this._matrixDimension == dimensionAddress.length) {
      for (int k = 0; k < dimensionAddress.length; k++) {
        if (dimensionAddress[k] < get.length) {
          if ((k + 1) == dimensionAddress.length) {
            returnVal = get[dimensionAddress[k]];
          } else {
            get = get[dimensionAddress[k]];
          }
        } else {
          ///Calcuate how far out of bounds in Dimension k the value is.
          int outOfBounds = dimensionAddress[k] - get.length;
          //Print Error to console.
          stderr.writeln(
              "ERROR: Dimension MisMatch at Dimension $k of the NMatrix. Out of Bounds by: $outOfBounds.");
          //Terminate Program...?
          exit(0);
          //TODO::Implement Dimension MisMatch at Dimension k Error here.
        }
      }
    } else {
      ///Gets the difference in D
      int dimDiff = dimensionAddress.length - this._matrixDimension;
      //Print Error to console.
      stderr.writeln(
          "ERROR: Dimension MisMatch. NMatrix object does not have same number dimensions as the dimensionsAddress provided. Dimension Dif: $dimDiff.");
      //Terminate Program...?
      exit(0);
      //TODO::Implement Dimension MisMatch Error here.
    }
    return returnVal;
  }



  ///Sets the value at the Dimension address provided to the value of T type val.
  ///
  /// Since this object can have n dimensions, a [val]'s position in the Matrix is
  /// referred to as it's [dimensionAddress]. If the length of the [dimensionAddress]
  /// does not match the matrix's dimensions an error is thrown. If at each point in
  /// the dimension address, the value is out of bounds of that dimensions range, an
  /// error is thrown.
  void set(List<int> dimensionAddress, T val) {
    List get = this._core;
    if (this._matrixDimension == dimensionAddress.length) {
      for (int k = 0; k < dimensionAddress.length; k++) {
        if (dimensionAddress[k] < get.length) {
          if ((k + 1) == dimensionAddress.length) {
            get[dimensionAddress[k]] = val;
          } else {
            get = get[dimensionAddress[k]];
          }
        } else {
          ///Calcuate how far out of bounds in Dimension k the value is.
          int outOfBounds = dimensionAddress[k] - get.length;
          //Print Error to console.
          stderr.writeln(
              "ERROR: Dimension MisMatch at Dimension $k of the NMatrix. Out of Bounds by: $outOfBounds.");
          //Terminate Program...?
          exit(0);
          //TODO::Implement Dimension MisMatch at Dimension k Error here.
        }
      }
    } else {
      ///Gets the difference in D
      int dimDiff = dimensionAddress.length - this._matrixDimension;
      //Print Error to console.
      stderr.writeln(
          "ERROR: Dimension MisMatch. NMatrix object does not have same number dimensions as the dimensionsAddress provided. Dimension Dif: $dimDiff.");
      //Terminate Program...?
      exit(0);
      //TODO::Implement Dimension MisMatch Error here.
    }
  }



//--------------------------------------------------------------------------------

  ///This function returns a String representation of the matrix construct.
  ///
  /// It overrides Dart's Object toString function.
  @override
  String toString() {
    return "{${this._recurseToString(0,this._core)}}";
  }

  ///This algorithm recursively traverses the matrix construct and builds a string representation of it.
  ///
  /// the [currentDim] specifies the height of the recursive tree and the [currentList] is the current list
  /// at the current dimension [currentDim] to traverse.
  String _recurseToString(int currentDim, List currentList) {
    //Base Case
    if ((currentDim + 1) == this._matrixDimension) {
      String list = "";
      for (int k = 0; k < currentList.length; k++) {
        list += "${currentList[k]}";
        if ((k + 1) < currentList.length) {
          list += ",";
        }
      }
      return list;
    } else {
      String matrixState = "";
      ///the nth dimensional list and set each dimension point to the fully extruded dimensional List returned by the extrude function.
      for (int k = 0; k < currentList.length; k++) {
        int next = currentDim + 1;
        if ((currentDim + 1) == this._matrixDimension) {
          matrixState += "${this._recurseToString(next, currentList[k])}";
        } else {
          matrixState += "{${this._recurseToString(next, currentList[k])}}";
        }
        if ((k + 1) < currentList.length) {
          matrixState += ",";
        }
      }
      return matrixState;
    }
  }
//TODO::Create Error Classes? for this Class...?
}
