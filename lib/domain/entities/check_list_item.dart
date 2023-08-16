import 'package:equatable/equatable.dart';

/// Class representing a checklist item.
class CheckListItem extends Equatable {
  /// Creates a new instance of [CheckListItem].
  const CheckListItem({
    required this.title,
    required this.isCompleted,
    required this.id,
  });

  /// The title or description of the checklist item.
  final String title;

  /// Indicates whether the checklist item has been completed.
  final bool isCompleted;

  final int id;

  /// Creates a copy of this [CheckListItem] with specified attributes replaced.
  CheckListItem copyWith({int? id, String? title, bool? isCompleted}) {
    return CheckListItem(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [title, isCompleted];
}
