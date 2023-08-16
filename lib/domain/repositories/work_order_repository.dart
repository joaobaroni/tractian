import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';

/// Abstract class representing a repository for work order-related operations.
abstract class IWorkOrderRepository {
  /// Searches for work orders by title.
  ///
  Future<Either<Failure, List<WorkOrder>>> searchByTitle({required String title, int limit = 12, int offset = 0});

  /// Retrieves a list of work orders.
  ///
  Future<Either<Failure, List<WorkOrder>>> get({int limit = 12, int offset = 0});

  /// Creates a new work order.
  ///
  Future<Either<Failure, int>> create({required WorkOrderParams params});

  /// Updates a work order.
  ///
  Future<Either<Failure, Unit>> update({WorkOrderParams? params, required int id, WorkOrderStatus? status});
}
