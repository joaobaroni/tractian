import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:tractian/data/data.dart';
import 'package:tractian/data/mappers/local/work_order_model_mapper.dart';
import 'package:tractian/domain/entities/work_order.dart';
import 'package:tractian/domain/entities/work_order_params.dart';
import 'package:tractian/domain/enums/work_order_status.dart';
import 'package:tractian/domain/repositories/repositories.dart';
import 'package:tractian/domain/validations/failures/failure.dart';
import 'package:tractian/infrastructure/infrastructure.dart';

import '../interfaces/database/app_database.dart';

class WorkOrderRepository implements IWorkOrderRepository {
  const WorkOrderRepository(this._remoteDatasource, this._database);

  final IWorkOrderRemoteDataSource _remoteDatasource;
  final ILocalDatabase _database;

  @override
  Future<Either<Failure, int>> create({required WorkOrderParams params}) async {
    try {
      final newRegisterId = await _database.addWorkOrder(WorkOrderCompanion.insert(
        title: params.title,
        assetId: params.assetId,
        status: WorkOrderStatus.open,
        priority: params.priority,
        assignedUserIds: Value(params.assignedUserIds),
        description: Value.ofNullable(params.description),
      ));
      return Right(newRegisterId);
    } catch (_) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<WorkOrder>>> get({int limit = 12, int offset = 0, String? title}) async {
    try {
      final localResults = await _database.queryWorkOrders(limit: limit, offset: offset);
      if (localResults.isEmpty) {
        final remoteResults = await _remoteDatasource.get(limit: limit, offset: offset);
        final List<WorkOrderCompanion> workOrderCompanions = remoteResults
            .map((e) => WorkOrderCompanion.insert(
                  title: e.title,
                  assetId: e.assetId,
                  status: e.status,
                  priority: e.priority,
                  assignedUserIds: Value.ofNullable(e.assignedUserIds),
                  description: Value.ofNullable(e.description),
                  id: Value(e.id),
                ))
            .toList();
        final List<CheckListItemCompanion> checkListItemsCompanions = [];
        for (final workOrder in remoteResults) {
          if (workOrder.checkList != null) {
            checkListItemsCompanions.addAll(workOrder.checkList!
                .map((e) => CheckListItemCompanion.insert(
                    title: e.title, workOrderId: workOrder.id, completed: Value(e.isCompleted)))
                .toList());
          }
        }

        await _database.addMultiplesWorkOrders(workOrderCompanions);
        await _database.addMultiplesCheckListItems(checkListItemsCompanions);
        return Right(remoteResults);
      }
      return Right(localResults.map((e) => WorkOrderModelMapper.toEntity(e)).toList());
    } catch (_) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<WorkOrder>>> searchByTitle(
      {required String title, int limit = 12, int offset = 0}) async {
    try {
      final result = await _database.queryWorkOrders(limit: limit, offset: offset, title: title);
      return Right(result.map((e) => WorkOrderModelMapper.toEntity(e)).toList());
    } catch (_) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> update({WorkOrderParams? params, required int id, WorkOrderStatus? status}) async {
    try {
      await _database.updateWorkOrderDetails(id: id, params: params, status: status);
      return const Right(unit);
    } catch (_) {
      return Left(Failure());
    }
  }
}
