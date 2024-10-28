import '../models/user.dart';  // Ensure the path is correct
import '../methods/auth_methods.dart';
import 'package:logger/logger.dart';

class UserProvider {
  final AuthMethods _authMethods = AuthMethods();
  Users? _user; // Use the correct class name 'Users'

  // Logger instance for logging errors
  final Logger _logger = Logger();

  // Method to retrieve user details
  Future<void> fetchUserDetails(String userId) async {
    try {
      _user = await _authMethods.getUserDetails(userId);
      // You can handle state management here (e.g., using Provider or Bloc)
    } catch (e) {
      // Log the error instead of printing it
      _logger.e("Error fetching user details: $e");
    }
  }

  // Getter for user details
  Users? get user => _user; // Ensure to use the correct class name 'Users'
}