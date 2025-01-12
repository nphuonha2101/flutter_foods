import 'package:flutter_foods/data/dtos/address_dto.dart';
import 'package:flutter_foods/data/models/address.dart';
import 'package:flutter_foods/repositories/address_repository.dart';

class AddressService {
  final AddressRepository _addressRepository;

  AddressService(this._addressRepository);

  Future<Address> fetch(num id) async {
    try {
      return _addressRepository.fetch(id);
    } catch (e) {
      throw Exception('Failed to load address. Error: $e');
    }
  }

  Future<Address> create(AddressDto address) async {
    try {
      return _addressRepository.create(address);
    } catch (e) {
      throw Exception('Failed to create address. Error: $e');
    }
  }

  Future<Address> update(AddressDto address, num id) async {
    try {
      return _addressRepository.update(address, id);
    } catch (e) {
      throw Exception('Failed to update address. Error: $e');
    }
  }

  Future<void> delete(num id) async {
    try {
      return _addressRepository.delete(id);
    } catch (e) {
      throw Exception('Failed to delete address. Error: $e');
    }
  }

  Future<List<Address>> fetchAllByUserId(String userId) async {
    try {
      List<Address> items =
          await _addressRepository.fetchAllByUserId(userId);
      return items;
    } catch (e) {
      throw Exception('Failed to search addresses. Error: $e');
    }
  }
}
