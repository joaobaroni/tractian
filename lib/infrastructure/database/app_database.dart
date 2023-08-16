import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tractian/infrastructure/database/type_converters/string_list_type_converter.dart';
import 'package:path/path.dart' as p;

import '../../data/interfaces/database/app_database.dart';
import '../../domain/domain.dart';

part 'app_database.g.dart';

@DataClassName("WorkOrderModel")
class WorkOrder extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get assetId => integer()();
  TextColumn get description => text().nullable()();
  IntColumn get status => intEnum<WorkOrderStatus>()();
  IntColumn get priority => intEnum<WorkOrderPriority>()();
  TextColumn get assignedUserIds => text().map(const IntListTypeConverter()).nullable()();
}

@DataClassName("CheckListItemModel")
class CheckListItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  IntColumn get workOrderId => integer().references(WorkOrder, #id)();
}

@DriftDatabase(tables: [WorkOrder, CheckListItem])
class AppDatabase extends _$AppDatabase implements ILocalDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  Future<int> addCheckListItem(CheckListItemCompanion companion) async {
    return await into(checkListItem).insert(companion);
  }

  @override
  Future<int> addWorkOrder(WorkOrderCompanion companion) async {
    return await into(workOrder).insert(companion);
  }

  @override
  Future<List<CheckListItemModel>> queryCheckListItems(
      {required int workOrderId, int limit = 12, int offset = 0}) async {
    return (select(checkListItem)..where((t) => t.workOrderId.equals(workOrderId))).get();
  }

  @override
  Future<List<WorkOrderModel>> queryWorkOrders({int limit = 12, int offset = 0, String? title}) {
    if (title != null) {
      return (select(workOrder)
            ..where((tbl) => tbl.title.contains(title))
            ..limit(limit, offset: offset))
          .get();
    }
    return (select(workOrder)..limit(limit, offset: offset)).get();
  }

  @override
  Future<void> updateCheckListItem({required int id, required bool completed}) async {
    await (update(checkListItem)..where((tbl) => tbl.id.equals(id)))
        .write(CheckListItemCompanion(completed: Value(completed)));
  }

  @override
  Future<void> updateWorkOrderDetails({required int id, WorkOrderParams? params, WorkOrderStatus? status}) async {
    WorkOrderCompanion companion = WorkOrderCompanion();
    if (params != null) {
      companion = companion.copyWith(
        assetId: Value(params.assetId),
        assignedUserIds: Value.ofNullable(params.assignedUserIds),
        description: Value.ofNullable(params.description),
        priority: Value(params.priority),
        title: Value(params.title),
      );
    }
    if (status != null) companion = companion.copyWith(status: Value.ofNullable(status));
    await (update(workOrder)..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  @override
  Future<void> addMultiplesWorkOrders(List<WorkOrderCompanion> companions) async {
    await batch((batch) {
      batch.insertAll(workOrder, companions);
    });
  }

  @override
  Future<void> addMultiplesCheckListItems(List<CheckListItemCompanion> companions) async {
    await batch((batch) {
      batch.insertAll(checkListItem, companions);
    });
  }

  @override
  Stream<List<WorkOrderModel>> watchWorkOrders({int limit = 12, int offset = 0, String? title}) {
    if (title != null) {
      return (select(workOrder)
            ..where((tbl) => tbl.title.contains(title))
            ..limit(limit, offset: offset))
          .watch();
    }
    return (select(workOrder)..limit(limit, offset: offset)).watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
