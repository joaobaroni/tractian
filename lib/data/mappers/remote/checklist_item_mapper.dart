import 'package:tractian/domain/domain.dart';

/// A utility class responsible for converting JSON data to a CheckListItem object.
abstract class CheckListItemMapper {
  /// Converts a JSON representation into a CheckListItem object.
  static CheckListItem fromJson(Map<String, dynamic> json) {
    return CheckListItem(title: json['task'], isCompleted: json['completed'], id: -1);
  }
}
