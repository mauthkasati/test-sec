class UsedAPIs {

  static const String _ownerLoginAPI ='https://hqtesting.restoplatform.com/RestoOwner/Login?';
  static const String _getAllEmployees = 'https://hqtesting.restoplatform.com/POSEmployeeHR/GetAllEmployees';
  static const String _getRestaurantKey = 'https://hqtesting.restoplatform.com/RestoOwner/GetRestaurantKey?id';
  static const String _searchRestaurants = 'https://hqtesting.restoplatform.com/RestoOwner/Searchrestaurants';
  // static const String _updateEmployeeFace = 'https://hqtesting.restoplatform.com/POSEmployeeHR/UpdateEmployeeFace';
  static const String _addEmployeeOperation  = 'https://hqtesting.restoplatform.com/POSEmployeeHR/AddEmployeeOperation';

  static const String _verify = 'https://finger-print-face-recognition.herokuapp.com/verify';
  static const String _upload = 'https://finger-print-face-recognition.herokuapp.com/upload';
  static const String _recognition = 'https://finger-print-face-recognition.herokuapp.com/recognition';


  static getRecognitionAPIURL(){
    return _recognition;
  }
  static getUploadFaceAPI(){
    return _upload;
  }
  static getVerifyAPIURL(){
    return _verify;
  }

  static getAddEmployeeOperationAPIURL(){
    return _addEmployeeOperation;
  }

  // static getUpdateEmployeeFaceAPIURL(){
  //   return _updateEmployeeFace;
  // }

  static getOwnerLoginAPIURL(String username, String password){
    return "${_ownerLoginAPI}username=$username&password=$password";
  }

  static getGetAllEmployeesAPIURL(){
    return _getAllEmployees;
  }

  static getGetRestaurantKeyAPIURL(){
    return _getRestaurantKey;
  }

  static getSearchRestaurantsAPIURL(){
    return _searchRestaurants;
  }
}