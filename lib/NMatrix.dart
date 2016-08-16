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

//Constructors & Initializers
//--------------------------------------------------------------------------------
  ///Constructor for an Nth Dimensional Matrix Construct.
  ///
  /// This Constructor takes in 2 main values, one for the number of [matrixDimensions] which is a list
  /// of integer representations of the sizes for each of the new dimensions. And the second being [dimensions]
  /// which is a list with the size of each dimension. The last parameter is a named optional parameter [initValue]
  /// which is the initial value to set each value in the matrix construct to.
  NMatrix(int matrixDimensions, List<int> dimensions, [T initValue = null]) {
    this._matrixDimension = matrixDimensions;
    this._dimensionSizes = dimensions;
    this._initValue = initValue;
    this._core = this._extrude(0, this._matrixDimension, this._dimensionSizes);
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
  /// This algorithm essentially creates a new matrix construct with [newDimension] dimensions with each dimension k having a size
  /// equal to the value at the kth index in [dimensionSizes] and sets the old values in the current matrix construct at their same
  /// "dimensional address" in the new matrix construct. All remaining values in the new matrix construct are set to [initVal].
  /// This algorithm then replaces the core of this object with the new matrix construct.
  void dimensionalExpansion(int newDimension, List<int> dimensionSizes,
      [T initVal = null]) {
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
        //TODO:: implement Matrix Construct Porting Here.
        this._initValue = initVal;
        List _newCore = this._extrude(0, newDimension, dimensionSizes);
      }
    }
  }
//--------------------------------------------------------------------------------

//Getter(s) & Setter(s)
//--------------------------------------------------------------------------------
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

  ///Getter for the sizes of each dimension in the matrix construct.
  ///
  /// Returns a list of sizes for each dimension in the matrix construct.
  List getDimensionSizes() {
    return this._dimensionSizes;
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

  ///Gets the "core" of the dimensional matrix construct.
  ///returns the core of the dimensional matrix construct.
  List getNMatrix() {
    return this._core;
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
