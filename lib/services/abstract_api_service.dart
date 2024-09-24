import 'package:flutter_foods/core/constants/api.dart';
import 'package:flutter_foods/data/dtos/i_dto.dart';
import 'package:flutter_foods/data/models/i_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

mixin ApiService<M extends IModel, D extends IDto> {
  final String baseUrl = ApiConstants.baseUrl;
  final String version = ApiConstants.version.toString();
  final String port = ApiConstants.port.toString();
  final String endpoint = '${M.toString().toLowerCase()}s';

  Future<List<M>> fetchAll() async {
    final response =
        await http.get(Uri.parse('$baseUrl:$port/api/$version/$endpoint'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body
          .map((dynamic item) => createModel().fromJson(item) as M)
          .toList();
    } else {
      throw Exception('Failed to load ${M.toString().toLowerCase()}');
    }
  }

  Future<M> fetch(num id) async {
    final response =
        await http.get(Uri.parse('$baseUrl:$port/api/$version/$endpoint/$id'));
    if (response.statusCode == 200) {
      return createModel().fromJson(json.decode(response.body)) as M;
    } else {
      throw Exception('Failed to load ${M.toString().toLowerCase()}');
    }
  }

  Future<M> create(D dto) async {
    return http
        .post(
      Uri.parse('$baseUrl:$port/api/$version/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dto.toJson()),
    )
        .then((response) {
      if (response.statusCode == 201) {
        return createModel().fromJson(json.decode(response.body)) as M;
      } else {
        throw Exception('Failed to create ${M.toString().toLowerCase()}');
      }
    });
  }

  Future<M> update(D dto, num id) async {
    return http
        .put(
      Uri.parse('$baseUrl:$port/api/$version/$endpoint/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dto.toJson()),
    )
        .then((response) {
      if (response.statusCode == 200) {
        return createModel().fromJson(json.decode(response.body)) as M;
      } else {
        throw Exception('Failed to update ${M.toString().toLowerCase()}');
      }
    });
  }

  Future<void> delete(num id) {
    return http
        .delete(Uri.parse('$baseUrl:$port/api/$version/$endpoint/$id'))
        .then((response) {
      if (response.statusCode != 204) {
        throw Exception('Failed to delete ${M.toString().toLowerCase()}');
      }
    });
  }

  M createModel();
}
