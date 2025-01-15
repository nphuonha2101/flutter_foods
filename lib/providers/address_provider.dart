import 'package:flutter/material.dart';
import 'package:flutter_foods/data/dtos/address_dto.dart';
import 'package:flutter_foods/data/models/address.dart';
import 'package:flutter_foods/services/address_service.dart';

class AddressProvider with ChangeNotifier {
  final AddressService _addressService;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  AddressProvider(this._addressService);

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<List<Address>> fetchAllByUserId(String userId) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      return (await _addressService.fetchAllByUserId(userId)).cast<Address>();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> create(AddressDto dto) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      await _addressService.create(dto);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> update(AddressDto dto, num id) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      await _addressService.update(dto, id);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> delete(num id) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      await _addressService.delete(id);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _isLoading = false;
    _hasError = false;
    _errorMessage = '';
    notifyListeners();
  }
}
