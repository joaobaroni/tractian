import 'package:tractian/data/data.dart';
import 'package:tractian/domain/domain.dart';

abstract class IWorkOrderRemoteDataSource {
  Future<List<WorkOrder>> get({int limit = 12, int offset = 0});
}

class WorkOrderRemoteDataSource implements IWorkOrderRemoteDataSource {
  WorkOrderRemoteDataSource(this.client);

  final IHttpClient client;

  @override
  Future<List<WorkOrder>> get({int limit = 12, int offset = 0}) async {
    final result = await client.get('workorders');
    if (result.status != HttpStatus.ok) throw GenericHttpException(result.status.code);
    return List.from(result.data.map((item) => WorkOrderMapper.fromJson(item)));
  }
}
