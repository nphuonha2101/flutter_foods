import 'package:flutter_foods/data/dtos/i_dto.dart';

abstract class IModel {
  IModel fromJson(Map<String, dynamic> json);
  IDto toDto();
}
