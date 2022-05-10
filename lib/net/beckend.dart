import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ninja_express_client/models/address.dart';
import 'package:ninja_express_client/models/business.dart';
import 'package:ninja_express_client/models/catagories.dart';
import 'package:ninja_express_client/models/product.dart';
import 'package:ninja_express_client/models/user.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/cart.dart';
// import 'package:logger/logger.dart';

class Beckend {
  String baseurl = "http://143.198.141.57:8000";

  //SignUp
  Future<int> signUp(
      {required String name,
      required String email,
      required String password,
      required String type}) async {
    try {
      var url = Uri.parse(baseurl + '/api/auth/register/');
      final headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> jsonmap = {
        'name': name,
        'email': email,
        'password': password,
        'type': type
      };
      String jsonString = json.encode(jsonmap);
      final encoding = Encoding.getByName('utf-8');
      var response = await http.post(url, headers: headers, body: jsonString, encoding: encoding);
      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  //Sign In
  Future<List> signIn({required String email, required String password}) async {
    try {
      var url = Uri.parse(baseurl + '/api/auth/login');
      final headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> jsonmap = {'email': email, 'password': password, 'type': 'client'};
      String jsonString = json.encode(jsonmap);
      final encoding = Encoding.getByName('utf-8');
      var response = await http.post(url, headers: headers, body: jsonString, encoding: encoding);

      Map<String, dynamic> body = json.decode(response.body);
      return [response.statusCode, body];
    } catch (e) {
      return [500, null];
    }
  }

  //Reset Password
  Future<int> resetpass({required String email}) async {
    try {
      var url = Uri.parse(baseurl + '/api/auth/reset-password/');
      final headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> jsonmap = {
        'email': email,
      };
      String jsonString = json.encode(jsonmap);
      final encoding = Encoding.getByName('utf-8');
      var response = await http.post(url, headers: headers, body: jsonString, encoding: encoding);
      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  //Update Profile
  Future<int> updateprofile(
      {required String name, required String phone, File? photo, required String token}) async {
    try {
      var url = Uri.parse(baseurl + '/api/v1/clients');
      final headers = {'Authorization': 'Bearer ' + token};
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({'name': name, 'phone': phone});
      if (photo != null) request.files.add(await http.MultipartFile.fromPath('photo', photo.path));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  //Get User info
  Future<User?> getuser({required String token}) async {
    User user;

    try {
      var url = Uri.parse(baseurl + '/api/v1/profile?type=client');
      final headers = {'Authorization': 'Bearer' + token};
      var response = await http.get(url, headers: headers);

      Map<String, dynamic> body = json.decode(response.body);

      user = User.fromJson(body);

      return user;
    } catch (e) {
      return null;
    }
  }

  //Logout
  Future<int> logout({required String token}) async {
    try {
      var url = Uri.parse(baseurl + '/api/auth/logout');
      final headers = {'Authorization': 'Bearer' + token};

      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        final storage = new FlutterSecureStorage();
        await storage.write(key: 'jwt', value: '');
      }
      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  //Change Current Address
  Future<int> changeCurrentAddress(
      {required String token,
      int? oldaddressId,
      required int currentAddressId,
      required int userid}) async {
    try {
      var headers = {'Authorization': 'Bearer ' + token, 'Content-Type': 'application/json'};
      var request = http.Request('PUT', Uri.parse(baseurl + '/api/v1/clients/$userid/addresses'));
      request.body =
          json.encode({"old_address_id": oldaddressId, "current_address_id": currentAddressId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  Future<int> changeCurrentAddresstonewone(
      {required String token,
      int? oldaddressId,
      required int currentAddressId,
      required int userid}) async {
    try {
      var headers = {'Authorization': 'Bearer ' + token, 'Content-Type': 'application/json'};
      var request = http.Request('PUT', Uri.parse(baseurl + '/api/v1/clients/$userid/addresses'));
      request.body =
          json.encode({"old_address_id": oldaddressId, "current_address_id": currentAddressId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  //Get All Catagories
  Future<List<Catagories>> getcatagories({required String token}) async {
    List<Catagories> catagories = [];
    try {
      var url = Uri.parse(baseurl + '/api/v1/categories/');
      final headers = {'Authorization': 'Bearer ' + token};
      var response = await http.get(url, headers: headers);

      final body = json.decode(response.body);

      for (int i = 0; i < body.length; i++) {
        catagories.add(Catagories.fromJson(body[i]));
      }
      return catagories;
    } catch (e) {
      return catagories;
    }
  }

  Future<List<Business>> getbusinesses({required String token, required int id}) async {
    List<Business> subcatagories = [];
    try {
      var url = Uri.parse(baseurl + '/api/v1/categories/${id.toString()}/businesses?addressId=1');
      final headers = {'Authorization': 'Bearer ' + token};

      var response = await http.get(url, headers: headers);

      List<dynamic> body = json.decode(response.body);

      for (int i = 0; i < body.length; i++) {
        subcatagories.add(Business.fromjson(body[i]));
      }
      return subcatagories;
    } catch (e) {
      return subcatagories;
    }
  }

  Future<int> createClientAddress({
    required String token,
    required int clientid,
    required String address,
    required String country,
    required String state,
    required String city,
    required String description,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer' + token.trim(),
        'Content-Type': 'application/json'
      };

      var url = Uri.parse(baseurl + '/api/v1/clients/$clientid/addresses');
      Map<String, dynamic> jsonmap = {
        'address': address,
        'country': country,
        'state': state,
        'city': city,
        'description': description,
        'current': true
      };
      String jsonString = json.encode(jsonmap);
      final encoding = Encoding.getByName('utf-8');
      var response = await http.post(url, headers: headers, body: jsonString, encoding: encoding);

      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  Future<int> updateClientAddress({
    required String token,
    required int addressid,
    required String address,
    required String country,
    required String state,
    required String city,
    required String description,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer' + token.trim(),
        'Content-Type': 'application/json'
      };

      var url = Uri.parse(baseurl + '/api/v1/addresses/$addressid');
      Map<String, dynamic> jsonmap = {
        'address': address,
        'country': country,
        'state': state,
        'city': city,
        'description': description
      };
      String jsonString = json.encode(jsonmap);
      final encoding = Encoding.getByName('utf-8');
      var response = await http.put(url, headers: headers, body: jsonString, encoding: encoding);
      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  Future<int> updatepassword({
    required String token,
    required String password,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer' + token.trim(),
        'Content-Type': 'application/json'
      };

      var url = Uri.parse(baseurl + '/api/auth/password');
      Map<String, dynamic> jsonmap = {'password': password};
      String jsonString = json.encode(jsonmap);
      final encoding = Encoding.getByName('utf-8');
      var response = await http.put(url, headers: headers, body: jsonString, encoding: encoding);

      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  Future<List<Address>> getclientAddresses({required String token, required int id}) async {
    List<Address> addresses = [];
    try {
      var url = Uri.parse(baseurl + '/api/v1/clients/${id.toString()}/addresses');
      final headers = {'Authorization': 'Bearer ' + token};

      var response = await http.get(url, headers: headers);

      final body = json.decode(response.body);
      for (int i = 0; i < body.length; i++) {
        addresses.add(Address.fromjson(body[i]));
      }

      return addresses;
    } catch (e) {
      return addresses;
    }
  }

  Future<List<Product>> getbusinessProducts({required String token, required int id}) async {
    List<Product> businessProducts = [];
    try {
      var url = Uri.parse(baseurl + '/api/v1/businesses/${id.toString()}/products');
      final headers = {'Authorization': 'Bearer ' + token};

      var response = await http.get(url, headers: headers);

      final body = json.decode(response.body);

      for (int i = 0; i < body.length; i++) {
        businessProducts.add(Product.fromjson(body[i]));
      }
      return businessProducts;
    } catch (e) {
      return businessProducts;
    }
  }

  Future<Cart?> getcartProducts({required String token, required int cartid}) async {
    late Cart? cart;
    try {
      print(cartid);
      print(token);
      var url = Uri.parse(baseurl + '/api/v1/clients/$cartid/carts');
      final headers = {'Authorization': 'Bearer ' + token};

      var response = await http.get(url, headers: headers);

      final body = json.decode(response.body);

      print(Cart.fromjson(body));
      cart = Cart.fromjson(body);

      return cart;
    } catch (e) {
      return cart;
    }
  }

  Future<int> deletecartitem(
      {required String token,
      required int cartitemproductid,
      required String cartitemproductquantity}) async {
    try {
      print(token);
      var headers = {'Authorization': 'Bearer ' + token, 'Content-Type': 'application/json'};
      var request = http.Request(
          'DELETE', Uri.parse('143.198.141.57:8000/api/v1/carts/items/$cartitemproductid'));
      request.body = json.encode({
        "product_id": cartitemproductid,
        "quantity": cartitemproductquantity,
        "delivery_cost": "50"
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  Future<int> deleteAddress({required String token, required int addressid}) async {
    try {
      var url = Uri.parse(baseurl + '/api/v1/addresses/$addressid');
      final headers = {'Authorization': 'Bearer ' + token};
      var request = http.Request('DELETE', url);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      return response.statusCode;
    } catch (e) {
      return 500;
    }
  }

  Future<int> addItemToCart(
      {required int cartid,
      required int quantity,
      required int productId,
      required String token}) async {
    try {
      var headers = {'Authorization': token, 'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(baseurl + '/api/v1/carts/$cartid/items'));
      request.body =
          json.encode({"product_id": productId, "quantity": quantity, "delivery_cost": "50"});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      return response.statusCode;
    } catch (err) {
      return 500;
    }
  }
}
