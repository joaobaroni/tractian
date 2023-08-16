import 'package:tractian/domain/domain.dart';

abstract class CheckListItemMapper {
  static CheckListItem fromJson(Map<String, dynamic> json) {
    return CheckListItem(title: json['title'], isCompleted: json['isCompleted'], id: json['id']);
  }

  static Map<String, dynamic> toJson(CheckListItem item) {
    return {
      'id': item.id,
      'isCompleted': item.isCompleted,
      'title': item.title,
    };
  }
}
