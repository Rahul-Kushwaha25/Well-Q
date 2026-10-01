import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:realm/realm.dart';
import 'package:shuktu/models/cart_item_model.dart';

import '../screens/cart_screen/cart_controller.dart';

class SharedPreferencesHelper {

  static const _isLoggedInKey = "isLoggedIn";
  static const _isOnboardingFirst = "isOnboardingFirst";
  static const _tokenKey = "authToken";
  static const _addressKey = "address";
  static const _addressPincode = "pincode";
  static const _addressId = "addressId";
  static const _userId = "userId";
  static const _userName = "userName";
  static const _userNumber = "userNumber";
  static const _userEmail = "userEmail";
  static const _completeAddress = "completeAddress";



  SharedPreferencesHelper._();
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._();
  factory SharedPreferencesHelper() => _instance;


  Future<void> saveLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, status);
  }

  Future<bool> getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> saveOnboardingStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isOnboardingFirst, status);
  }

  Future<bool> getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isOnboardingFirst) ?? false;
  }

  Future<void> saveAddress(String selectedAddress,String selectedPincode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_addressKey, selectedAddress);
    await prefs.setString(_addressPincode, selectedPincode);
  }

  Future<void> saveAddressId(String selectedAddressId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_addressId, selectedAddressId);
  }

  Future<String?> getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_addressKey);
  }

  Future<String?> getPincode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_addressPincode);
  }

  Future<String?> getSelectedAddressId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_addressId);
  }


  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userId, userId);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userId);
  }

  Future<void> saveUserInfo(String name, String number, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userName, name);
    await prefs.setString(_userNumber, number);
    await prefs.setString(_userEmail, email);
  }

  Future<void> saveCompleteAddress(String fullAddress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_completeAddress, fullAddress);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userName);
  }

  Future<String?> getUserNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNumber);
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmail);
  }

  Future<String?> getCompleteAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_completeAddress);
  }

  Future<void> logout(Realm realmInstance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.find<CartController>().clearCart();
    realmInstance.write(() {
      final cartItem = realmInstance.all<CartItem>();
      realmInstance.deleteMany(cartItem);
    });

  }
}