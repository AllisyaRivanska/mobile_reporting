class ApiEndpoints {
  static const String baseUrl = "https://api.example.com";

  
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";
  static const String fetchUserProfile = "$baseUrl/user/profile";
  static const String updateUserProfile = "$baseUrl/user/update";
  static const String fetchItems = "$baseUrl/items";
  static const String fetchItemDetails = "$baseUrl/items/details";
}