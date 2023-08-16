// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WorkOrderTable extends WorkOrder
    with TableInfo<$WorkOrderTable, WorkOrderModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkOrderTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _assetIdMeta =
      const VerificationMeta('assetId');
  @override
  late final GeneratedColumn<int> assetId = GeneratedColumn<int>(
      'asset_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<WorkOrderStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<WorkOrderStatus>($WorkOrderTable.$converterstatus);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumnWithTypeConverter<WorkOrderPriority, int> priority =
      GeneratedColumn<int>('priority', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<WorkOrderPriority>($WorkOrderTable.$converterpriority);
  static const VerificationMeta _assignedUserIdsMeta =
      const VerificationMeta('assignedUserIds');
  @override
  late final GeneratedColumnWithTypeConverter<List<int>?, String>
      assignedUserIds = GeneratedColumn<String>(
              'assigned_user_ids', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<int>?>(
              $WorkOrderTable.$converterassignedUserIdsn);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, assetId, description, status, priority, assignedUserIds];
  @override
  String get aliasedName => _alias ?? 'work_order';
  @override
  String get actualTableName => 'work_order';
  @override
  VerificationContext validateIntegrity(Insertable<WorkOrderModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(_assetIdMeta,
          assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta));
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    context.handle(_statusMeta, const VerificationResult.success());
    context.handle(_priorityMeta, const VerificationResult.success());
    context.handle(_assignedUserIdsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkOrderModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkOrderModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      assetId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}asset_id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      status: $WorkOrderTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      priority: $WorkOrderTable.$converterpriority.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!),
      assignedUserIds: $WorkOrderTable.$converterassignedUserIdsn.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}assigned_user_ids'])),
    );
  }

  @override
  $WorkOrderTable createAlias(String alias) {
    return $WorkOrderTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WorkOrderStatus, int, int> $converterstatus =
      const EnumIndexConverter<WorkOrderStatus>(WorkOrderStatus.values);
  static JsonTypeConverter2<WorkOrderPriority, int, int> $converterpriority =
      const EnumIndexConverter<WorkOrderPriority>(WorkOrderPriority.values);
  static TypeConverter<List<int>, String> $converterassignedUserIds =
      const IntListTypeConverter();
  static TypeConverter<List<int>?, String?> $converterassignedUserIdsn =
      NullAwareTypeConverter.wrap($converterassignedUserIds);
}

class WorkOrderModel extends DataClass implements Insertable<WorkOrderModel> {
  final int id;
  final String title;
  final int assetId;
  final String? description;
  final WorkOrderStatus status;
  final WorkOrderPriority priority;
  final List<int>? assignedUserIds;
  const WorkOrderModel(
      {required this.id,
      required this.title,
      required this.assetId,
      this.description,
      required this.status,
      required this.priority,
      this.assignedUserIds});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['asset_id'] = Variable<int>(assetId);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      final converter = $WorkOrderTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status));
    }
    {
      final converter = $WorkOrderTable.$converterpriority;
      map['priority'] = Variable<int>(converter.toSql(priority));
    }
    if (!nullToAbsent || assignedUserIds != null) {
      final converter = $WorkOrderTable.$converterassignedUserIdsn;
      map['assigned_user_ids'] =
          Variable<String>(converter.toSql(assignedUserIds));
    }
    return map;
  }

  WorkOrderCompanion toCompanion(bool nullToAbsent) {
    return WorkOrderCompanion(
      id: Value(id),
      title: Value(title),
      assetId: Value(assetId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      priority: Value(priority),
      assignedUserIds: assignedUserIds == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedUserIds),
    );
  }

  factory WorkOrderModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkOrderModel(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      assetId: serializer.fromJson<int>(json['assetId']),
      description: serializer.fromJson<String?>(json['description']),
      status: $WorkOrderTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      priority: $WorkOrderTable.$converterpriority
          .fromJson(serializer.fromJson<int>(json['priority'])),
      assignedUserIds: serializer.fromJson<List<int>?>(json['assignedUserIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'assetId': serializer.toJson<int>(assetId),
      'description': serializer.toJson<String?>(description),
      'status': serializer
          .toJson<int>($WorkOrderTable.$converterstatus.toJson(status)),
      'priority': serializer
          .toJson<int>($WorkOrderTable.$converterpriority.toJson(priority)),
      'assignedUserIds': serializer.toJson<List<int>?>(assignedUserIds),
    };
  }

  WorkOrderModel copyWith(
          {int? id,
          String? title,
          int? assetId,
          Value<String?> description = const Value.absent(),
          WorkOrderStatus? status,
          WorkOrderPriority? priority,
          Value<List<int>?> assignedUserIds = const Value.absent()}) =>
      WorkOrderModel(
        id: id ?? this.id,
        title: title ?? this.title,
        assetId: assetId ?? this.assetId,
        description: description.present ? description.value : this.description,
        status: status ?? this.status,
        priority: priority ?? this.priority,
        assignedUserIds: assignedUserIds.present
            ? assignedUserIds.value
            : this.assignedUserIds,
      );
  @override
  String toString() {
    return (StringBuffer('WorkOrderModel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('assetId: $assetId, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('assignedUserIds: $assignedUserIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, assetId, description, status, priority, assignedUserIds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkOrderModel &&
          other.id == this.id &&
          other.title == this.title &&
          other.assetId == this.assetId &&
          other.description == this.description &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.assignedUserIds == this.assignedUserIds);
}

class WorkOrderCompanion extends UpdateCompanion<WorkOrderModel> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> assetId;
  final Value<String?> description;
  final Value<WorkOrderStatus> status;
  final Value<WorkOrderPriority> priority;
  final Value<List<int>?> assignedUserIds;
  const WorkOrderCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.assetId = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.assignedUserIds = const Value.absent(),
  });
  WorkOrderCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int assetId,
    this.description = const Value.absent(),
    required WorkOrderStatus status,
    required WorkOrderPriority priority,
    this.assignedUserIds = const Value.absent(),
  })  : title = Value(title),
        assetId = Value(assetId),
        status = Value(status),
        priority = Value(priority);
  static Insertable<WorkOrderModel> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? assetId,
    Expression<String>? description,
    Expression<int>? status,
    Expression<int>? priority,
    Expression<String>? assignedUserIds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (assetId != null) 'asset_id': assetId,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (assignedUserIds != null) 'assigned_user_ids': assignedUserIds,
    });
  }

  WorkOrderCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? assetId,
      Value<String?>? description,
      Value<WorkOrderStatus>? status,
      Value<WorkOrderPriority>? priority,
      Value<List<int>?>? assignedUserIds}) {
    return WorkOrderCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      assetId: assetId ?? this.assetId,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedUserIds: assignedUserIds ?? this.assignedUserIds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<int>(assetId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      final converter = $WorkOrderTable.$converterstatus;
      map['status'] = Variable<int>(converter.toSql(status.value));
    }
    if (priority.present) {
      final converter = $WorkOrderTable.$converterpriority;
      map['priority'] = Variable<int>(converter.toSql(priority.value));
    }
    if (assignedUserIds.present) {
      final converter = $WorkOrderTable.$converterassignedUserIdsn;
      map['assigned_user_ids'] =
          Variable<String>(converter.toSql(assignedUserIds.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkOrderCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('assetId: $assetId, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('assignedUserIds: $assignedUserIds')
          ..write(')'))
        .toString();
  }
}

class $CheckListItemTable extends CheckListItem
    with TableInfo<$CheckListItemTable, CheckListItemModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckListItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _workOrderIdMeta =
      const VerificationMeta('workOrderId');
  @override
  late final GeneratedColumn<int> workOrderId = GeneratedColumn<int>(
      'work_order_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES work_order (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, title, completed, workOrderId];
  @override
  String get aliasedName => _alias ?? 'check_list_item';
  @override
  String get actualTableName => 'check_list_item';
  @override
  VerificationContext validateIntegrity(Insertable<CheckListItemModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('work_order_id')) {
      context.handle(
          _workOrderIdMeta,
          workOrderId.isAcceptableOrUnknown(
              data['work_order_id']!, _workOrderIdMeta));
    } else if (isInserting) {
      context.missing(_workOrderIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckListItemModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckListItemModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      workOrderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}work_order_id'])!,
    );
  }

  @override
  $CheckListItemTable createAlias(String alias) {
    return $CheckListItemTable(attachedDatabase, alias);
  }
}

class CheckListItemModel extends DataClass
    implements Insertable<CheckListItemModel> {
  final int id;
  final String title;
  final bool completed;
  final int workOrderId;
  const CheckListItemModel(
      {required this.id,
      required this.title,
      required this.completed,
      required this.workOrderId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['completed'] = Variable<bool>(completed);
    map['work_order_id'] = Variable<int>(workOrderId);
    return map;
  }

  CheckListItemCompanion toCompanion(bool nullToAbsent) {
    return CheckListItemCompanion(
      id: Value(id),
      title: Value(title),
      completed: Value(completed),
      workOrderId: Value(workOrderId),
    );
  }

  factory CheckListItemModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckListItemModel(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      completed: serializer.fromJson<bool>(json['completed']),
      workOrderId: serializer.fromJson<int>(json['workOrderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'completed': serializer.toJson<bool>(completed),
      'workOrderId': serializer.toJson<int>(workOrderId),
    };
  }

  CheckListItemModel copyWith(
          {int? id, String? title, bool? completed, int? workOrderId}) =>
      CheckListItemModel(
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
        workOrderId: workOrderId ?? this.workOrderId,
      );
  @override
  String toString() {
    return (StringBuffer('CheckListItemModel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('completed: $completed, ')
          ..write('workOrderId: $workOrderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, completed, workOrderId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckListItemModel &&
          other.id == this.id &&
          other.title == this.title &&
          other.completed == this.completed &&
          other.workOrderId == this.workOrderId);
}

class CheckListItemCompanion extends UpdateCompanion<CheckListItemModel> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> completed;
  final Value<int> workOrderId;
  const CheckListItemCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.completed = const Value.absent(),
    this.workOrderId = const Value.absent(),
  });
  CheckListItemCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.completed = const Value.absent(),
    required int workOrderId,
  })  : title = Value(title),
        workOrderId = Value(workOrderId);
  static Insertable<CheckListItemModel> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? completed,
    Expression<int>? workOrderId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (completed != null) 'completed': completed,
      if (workOrderId != null) 'work_order_id': workOrderId,
    });
  }

  CheckListItemCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<bool>? completed,
      Value<int>? workOrderId}) {
    return CheckListItemCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      workOrderId: workOrderId ?? this.workOrderId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (workOrderId.present) {
      map['work_order_id'] = Variable<int>(workOrderId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckListItemCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('completed: $completed, ')
          ..write('workOrderId: $workOrderId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $WorkOrderTable workOrder = $WorkOrderTable(this);
  late final $CheckListItemTable checkListItem = $CheckListItemTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [workOrder, checkListItem];
}
