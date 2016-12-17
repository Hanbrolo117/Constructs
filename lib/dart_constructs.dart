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

//Constructors & Initializers
//--------------------------------------------------------------------------------

  ///The "no-args" constructor of an nth dimensional matrix construct.
  ///
  /// This constructor creates a 10x10 matrix with an initial value of null.
  /// Don't worry you can always expand the size of a matrix construct.
  NMatrix({T initValue: null}) {
    this._matrixDimension = 2;
    this._dimensionSizes = [10, 10];
    this._initValue = initValue;
    this._dataPointCount = 0;
    this._core = this._extrude(0, this._matrixDimension, this._dimensionSizes);
  }

  ///Constructor for an nth Dimensional Matrix Construct.
  ///
  /// This Constructor takes in one parameter, that is the [dimensions] which is a list
  /// of integer representations of the sizes for each of the new dimensions. The length of
  /// [dimensions] represents the NUMBER of dimensions the matrix construct has. The last
  /// parameter is a named optional parameter [initValue] which is the initial value to set
  /// each value in the matrix construct to.///Constructor for an nth Dimensional Matrix Construct.
  ///
  /// This Constructor takes in one parameter, that is the [dimensions] which is a list
  /// of integer representations of the sizes for each of the new dimensions. The length of
  /// [dimensions] represents the NUMBER of dimensions the matrix construct has. The last
  /// parameter is a named optional parameter [initValue] which is the initial value to set
  /// each value in the matrix construct to.
  NMatrix.dimensional(List<int> dimensions, {T initValue: null}) {
    this._matrixDimension = dimensions.length;
    this._dimensionSizes = dimensions;
    this._initValue = initValue;
    this._dataPointCount = 0;
    this._core = this._extrude(0, this._matrixDimension, this._dimensionSizes);
  }

  ///Extrudes Matrix to n dimensions.
  ///
  /// This function is critical to the initialization of the nth Dimensional Matrix Construct.
  /// It Recursively Constructs all [matrixDim] dimensions of the Matrix setting the value at each position to this initialValue
  /// of which, unless specified otherwise as a named optional parameter, is by default null.
  /// [currentDim] is the current depth of the recursive tree and each dimension k has a size equal to the value at
  /// the kth index of [dimSizes]. Returns the newly created matrix construct.
  List _extrude(int currentDim, int matrixDim, List<int> dimSizes) {
    //BaseCase 1:
    if (dimSizes.isEmpty) {
      return new List();
    }
    //BaseCase 2:
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
  /// Furthermore, for each dimension in current matrix construct, each dimension's new Size can only be >= each of the current matrix dimension's current sizes. This
  /// ensures there is no "shrinking" effect which would cause a loss in data of the current matrix.
  /// For instance, {2,2,2} => {2,3,2} | {2,2,2,3} | {2,2,2,1} is valid, but {2,2,2} => {1} | {2,2,1,2} is invalid.
  bool dimensionalExpansion(List<int> dimensionSizes, [T initVal = null]) {
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
        NMatrix<T> newNM =
            new NMatrix.dimensional(dimensionSizes, initValue: this._initValue);

        ///Used to fetch elements at this address in the matrixPort algorithm.
        List dimensionalAdress = new List(this._dimensionSizes.length);
        for (int i = 0; i < this._dimensionSizes.length; i++) {
          for (int j = 0; j < this._dimensionSizes[i]; j++) {
            dimensionalAdress[i] = 0;
          }
        }

        //Port the old dataPoints in the current core to the new core.
        this._matrixPort(0, newNM.matrix, newNM, dimensionalAdress);

        //Set the new list of dimensionSizes:
        this._dimensionSizes = dimensionSizes;
        //Set to new number of dimensions:
        this._matrixDimension = dimensionSizes.length;

        //Finally, swap the cores:
        this._core = newNM.matrix;

        //Notify flag:
        isExpanded = true;
      }
    }
    return isExpanded;
  }

  ///This Algorithm ports the old matrix values to the new matrix.
  ///
  /// It ports each data point in the old matrix construct to the same relative position using the [currentAddress]
  /// into the [newNM] matrix at it's current [newList]. The current [newList], or dimension is determined by the [currentDim],
  /// which also indicates what level of the recursive tree the algorithm is in.
  void _matrixPort(
      int currentDim, List newList, NMatrix newNM, List currentAddress) {
    //Base Case
    if ((currentDim + 1) == this._matrixDimension) {
      ///Create the equivalent address for the new matrix construct:
      List newAddr = new List(newNM.matrixDimensions);

      for (int k = 0; k < this._dimensionSizes[currentDim]; k++) {
        //updateAddress:
        currentAddress[currentDim] = k;
        //Port value in old matrix to the same relative position in the new matrix:
        if (currentDim >= currentAddress.length) {
          return;
        }
        //Convert old address to new address:
        for (int i = 0; i < newAddr.length; i++) {
          if (i < currentAddress.length) {
            newAddr[i] = currentAddress[i];
          } else {
            newAddr[i] = 0;
          }
        }
        //Port value:
        newNM.set(newAddr, this.getAt(currentAddress));
      }
    } else {
      ///the nth dimensional list and set each dimension point to the fully extruded dimensional List returned by the extrude function.
      for (int k = 0; k < newList.length; k++) {
        int next = currentDim + 1;
        //Update Current address:
        currentAddress[currentDim] = k;
        this._matrixPort(next, newList[k], newNM, currentAddress);
        if (currentDim >= currentAddress.length) {
          return;
        }
      }
    } //End else
  } //End matrixPort Algorithm.
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
  ///
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
          throw new DimensionalMisMatchException(
              "ERROR: Dimension MisMatch at Dimension $k of the NMatrix. Out of Bounds by: $outOfBounds.");
        }
      }
    } else {
      ///Gets the difference in D
      int dimDiff = dimensionAddress.length - this._matrixDimension;
      throw new DimensionalMisMatchException(
          "ERROR: Dimension MisMatch. NMatrix object does not have same number dimensions as the dimensionsAddress provided. Dimension Dif: $dimDiff.");
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
          throw new DimensionalMisMatchException(
              "ERROR: Dimension MisMatch at Dimension $k of the NMatrix. Out of Bounds by: $outOfBounds.");
        }
      }
    } else {
      ///Gets the difference in D
      int dimDiff = dimensionAddress.length - this._matrixDimension;
      throw new DimensionalMisMatchException(
          "ERROR: Dimension MisMatch. NMatrix object does not have same number dimensions as the dimensionsAddress provided. Dimension Dif: $dimDiff.");
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
}

///DimensionalMisMatchError Class
class DimensionalMisMatchException implements Exception {
  ///The [cause] for throwing this exception.
  String cause;

  ///A Dimensional Mismatch Exception.
  ///
  /// This constructor conveys the [cause] of a new matrix's dimensions being less than the current matrix's dimensions,
  /// or the size of a given dimension being less than the others dimension.
  DimensionalMisMatchException(this.cause);
}
