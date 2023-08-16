import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';

/// Abstract class representing a repository for checklist-related operations.
abstract class ICheckListRepository {
  /// Updates a checklist item.
  ///
  Future<Either<Failure, Unit>> update({required CheckListItem item});

  /// Creates a new checklist item.
  ///
  Future<Either<Failure, int>> create({required String title, required bool isCompleted, required int workOrderId});

  Future<Either<Failure, List<CheckListItem>>> getByWorkOrder({required int workOrderId});
}
