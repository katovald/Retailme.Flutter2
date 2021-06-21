class Constants {
  static const String baseUrl = 'https://retailmi.azurewebsites.net/api';
  static const String analyticsUrl = 'http://108.175.10.228:81';
  static const String identity = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyBDQ6xamV2dCKKEhBGHm126mbW3QuTyPLs';

  // Local Storage
  static const String tokenKey = 'web_token';
  static const String sucursalInfo = 'branch';
  static const String sucursalId= 'branchId';
  static const String isAuthenticatedKey = 'isDeviceRegister';

  // Register Device to Branch
  static const String registerDevice = '$baseUrl/Branch/attachDevice/';

  // Branch info
  static const String getBranchById = '$baseUrl/Branch/';

  // Product info
  static const String getProductById = '$baseUrl/Products/';

  // Promotion info
  static const String getSalesPromotionById = '$baseUrl/SalesPromotion';

  // Analytics
  static const String getSessionId = '$analyticsUrl/createNewBranchId';
  static const String addLogBranch = '$analyticsUrl/addLogBranch';
}