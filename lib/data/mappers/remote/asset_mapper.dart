import 'package:tractian/data/data.dart';
import 'package:tractian/domain/domain.dart';

/// A utility class responsible for converting JSON data to an Asset object.
abstract class AssetMapper {
  /// Converts a JSON representation into an Asset object.
  static Asset fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      healthScore: json['healthscore'].toDouble(),
      model: json['model'],
      sensors: List.from(json['sensors']),
      image: json['image'],
      status: AssetStatusMapper.fromString(json['status'].toString()),
      statusHistory: List.from(
        json['healthHistory'].map(
          (item) => AssetStatusDataPoint(
              status: AssetStatusMapper.fromString(item['status'].toString()), date: DateTime.parse(item['timestamp'])),
        ),
      ),
    );
  }
}
