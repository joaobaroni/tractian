import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:tractian/data/interfaces/database/app_database.dart';
import 'package:tractian/domain/domain.dart';

import '../../infrastructure/infrastructure.dart';

class CheckListRepository implements ICheckListRepository {
  CheckListRepository(this._database);
  final ILocalDatabase _database;

  @override
  Future<Either<Failure, int>> create(
      {required String title, required bool isCompleted, required int workOrderId}) async {
    try {
      final newRegisterId = await _database.addCheckListItem(
          CheckListItemCompanion.insert(title: title, workOrderId: workOrderId, completed: Value(isCompleted)));
      return Right(newRegisterId);
    } catch (_) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<CheckListItem>>> getByWorkOrder({required int workOrderId}) async {
    try {
      final items = await _database.queryCheckListItems(workOrderId: workOrderId);
      return Right(items.map((e) => CheckListItem(id: e.id, isCompleted: e.completed, title: e.title)).toList());
    } catch (_) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> update({required CheckListItem item}) async {
    try {
      await _database.updateCheckListItem(completed: item.isCompleted, id: item.id);
      return const Right(unit);
    } catch (_) {
      return Left(Failure());
    }
  }
}
