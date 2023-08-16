import 'dart:convert';

import 'package:drift/drift.dart';

class IntListTypeConverter extends TypeConverter<List<int>, String> {
  const IntListTypeConverter();

  @override
  List<int> fromSql(String fromDb) {
    return json.decode(fromDb).cast<int>();
  }

  @override
  String toSql(List<int> value) {
    return json.encode(value);
  }
}
