import 'dart:io';
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
  /// This Constructor takes in 2 main values, one for the number of dimensions,
  /// and the second being a list with the size of each dimension.
  NMatrix(int matrixDimensions, List<int> dimensions, [T initValue = null]){
    this._matrixDimension = matrixDimensions;
    this._dimensionSizes = dimensions;
    this._initValue = initValue;
    this._core = this._extrude(0);
  }

  ///Extrudes Matrix to n dimensions.
  ///
  /// This function is critical to the initialization of the Nth Dimensional Matrix Construct.
  /// It Recursively Constructs all n dimensions of the Matrix setting the value at each position
  /// to the initalValue, of which unless specified otherwise as a named optional parameter, is by default null.
  List _extrude(int currentDim){
    //BaseCase:
    if((currentDim+1) == this._matrixDimension){
      ///This is the last Dimension to Extrude the Matrix by.
      List<T> lastDim = new List<T>(this._dimensionSizes[currentDim]);
      for(int k=0; k < this._dimensionSizes[currentDim]; k++){
        //Inistantiate the last Dimension with the initial value of the Nth Dimensional Matrix.
        lastDim[k] = this._initValue;
      }
      //Return the last dim to be set to the current location of the previous Dimensional point, thus extruding that point
      //by the last Dimension.
      return lastDim;
    }else{
      ///Create the nth dimensional list and set each dimension point to the fully extruded dimensional List returned by the extrude function.
      List<List> dimN = new List<List>(this._dimensionSizes[currentDim]);
      for(int k = 0; k < this._dimensionSizes[currentDim]; k++){
        int next = currentDim+1;
        dimN[k] = this._extrude(next);
      }
      return dimN;
    }
    //This point should never be reached, If it is, then there was an error, thus code calling this function should check for
    //a return value of null to handle such a case.
    return null;
  }
//--------------------------------------------------------------------------------


  
//Getter(s) & Setter(s)
//--------------------------------------------------------------------------------
  ///Gets the T type value at the dimension address provided.
  ///
  /// Since this object can have n dimensions,  value's position in the Matrix is
  /// referred to as it's dimension address. If the length of the dimension address
  /// does not match the matrix's dimensions an error is thrown. If at each point in
  /// the dimension address, the value is out of bounds of that dimensions range, an
  /// error is thrown.
  T get(List<int> dimensionAddress){
    List get = this._core;
    T returnVal = null;
    if(this._matrixDimension == dimensionAddress.length){
      for(int k = 0; k < dimensionAddress.length; k++){
        if(dimensionAddress[k] < get.length) {
          if ((k + 1) == dimensionAddress.length) {
            returnVal = get[dimensionAddress[k]];
          } else {
            get = get[dimensionAddress[k]];
          }
        }else{
          ///Calcuate how far out of bounds in Dimension k the value is.
          int outOfBounds = dimensionAddress[k]-get.length;
          //Print Error to console.
          stderr.writeln("ERROR: Dimension MisMatch at Dimension $k of the NMatrix. Out of Bounds by: $outOfBounds.");
          //Terminate Program...?
          exit(0);
          //TODO::Implement Dimension MisMatch at Dimension k Error here.
        }
      }
    }else{
      ///Gets the difference in D
      int dimDiff = dimensionAddress.length - this._matrixDimension;
      //Print Error to console.
      stderr.writeln("ERROR: Dimension MisMatch. NMatrix object does not have same number dimensions as the dimensionsAddress provided. Dimension Dif: $dimDiff.");
      //Terminate Program...?
      exit(0);
      //TODO::Implement Dimension MisMatch Error here.
    }
    return returnVal;
  }

  ///Sets the value at the Dimension address provided to the value of T type val.
  ///
  /// Since this object can have n dimensions,  value's position in the Matrix is
  /// referred to as it's dimension address. If the length of the dimension address
  /// does not match the matrix's dimensions an error is thrown. If at each point in
  /// the dimension address, the value is out of bounds of that dimensions range, an
  /// error is thrown.
  void set(List<int> dimensionAddress, T val){
    List get = this._core;
    if(this._matrixDimension == dimensionAddress.length){
      for(int k = 0; k < dimensionAddress.length; k++){
        if(dimensionAddress[k] < get.length) {
          if ((k + 1) == dimensionAddress.length) {
            get[dimensionAddress[k]] = val;
          } else {
            get = get[dimensionAddress[k]];
          }
        }else{
          ///Calcuate how far out of bounds in Dimension k the value is.
          int outOfBounds = dimensionAddress[k]-get.length;
          //Print Error to console.
          stderr.writeln("ERROR: Dimension MisMatch at Dimension $k of the NMatrix. Out of Bounds by: $outOfBounds.");
          //Terminate Program...?
          exit(0);
          //TODO::Implement Dimension MisMatch at Dimension k Error here.
        }
      }
    }else{
      ///Gets the difference in D
      int dimDiff = dimensionAddress.length - this._matrixDimension;
      //Print Error to console.
      stderr.writeln("ERROR: Dimension MisMatch. NMatrix object does not have same number dimensions as the dimensionsAddress provided. Dimension Dif: $dimDiff.");
      //Terminate Program...?
      exit(0);
      //TODO::Implement Dimension MisMatch Error here.
    }
  }
//--------------------------------------------------------------------------------

//TODO::Implement Scalable toString Algorithm
//TODO::Create Error Classes? for this Class...?
}

