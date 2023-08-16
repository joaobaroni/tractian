import 'package:get/get.dart';
import 'package:tractian/data/data.dart';
import 'package:tractian/data/interfaces/database/app_database.dart';
import 'package:tractian/data/repositories/checklist_repository.dart';
import 'package:tractian/domain/repositories/repositories.dart';
import 'package:tractian/domain/usecases/create_checklist_item_usecase.dart';
import 'package:tractian/domain/usecases/get_checklist_by_work_order_usecase.dart';
import 'package:tractian/infrastructure/infrastructure.dart';
import 'package:tractian/presentation/presentation.dart';

import '../domain/usecases/usecases.dart';
import '../presentation/utils.dart';

final ILocalDatabase localDatabase = AppDatabase();

class AppBindings implements Bindings {
  static const _baseUrl = 'https://my-json-server.typicode.com/tractian/fake-api/';

  @override
  void dependencies() {
    _datasources();
    _repositories();
    _usecases();
    _viewModels();
  }

  void _datasources() {
    DM.registerLazySingleton<IAssetRemoteDataSource>(() => AssetRemoteDataSource(HttpAdapter(baseUrl: _baseUrl)),
        instanceRenewal: true);
    DM.registerLazySingleton<IWorkOrderRemoteDataSource>(
        () => WorkOrderRemoteDataSource(HttpAdapter(baseUrl: _baseUrl)),
        instanceRenewal: true);
    DM.registerLazySingleton<IUserRemoteDatasource>(() => UserRemoteDatasource(HttpAdapter(baseUrl: _baseUrl)),
        instanceRenewal: true);
  }

  void _repositories() {
    DM.registerLazySingleton<IWorkOrderRepository>(
        () => WorkOrderRepository(DM.get<IWorkOrderRemoteDataSource>(), localDatabase),
        instanceRenewal: true);
    DM.registerLazySingleton<IAssetRepository>(() => AssetRepository(DM.get<IAssetRemoteDataSource>()),
        instanceRenewal: true);
    DM.registerLazySingleton<IUserRepository>(() => UserRepository(DM.get<IUserRemoteDatasource>()),
        instanceRenewal: true);
    DM.registerLazySingleton<ICheckListRepository>(() => CheckListRepository(localDatabase), instanceRenewal: true);
  }

  void _usecases() {
    DM.registerLazySingleton<IGetWorkOrdersUsecase>(() => GetWorkOrdersUsecase(DM.get<IWorkOrderRepository>()),
        instanceRenewal: true);
    DM.registerLazySingleton<ISearchWorkOrderByTitleUsecase>(
        () => SearchWorkOrderByTitleUsecase(DM.get<IWorkOrderRepository>()),
        instanceRenewal: true);
    DM.registerLazySingleton<ICreateWorkOrderUsecase>(() => CreateWorkOrderUsecase(DM.get<IWorkOrderRepository>()),
        instanceRenewal: true);
    DM.registerLazySingleton<IGetAssetsUsecase>(() => GetAssetsUsecase(DM.get<IAssetRepository>()),
        instanceRenewal: true);
    DM.registerLazySingleton<IGetUserByIdUsecase>(() => GetUserByIdUsecase(DM.get<IUserRepository>()),
        instanceRenewal: true);
    DM.registerLazySingleton<IGetUsersUsecase>(() => GetUsersUsecase(DM.get<IUserRepository>()), instanceRenewal: true);
    DM.registerLazySingleton<IUpdateWorkOrderStatusUsecase>(
        () => UpdateWorkOrderStatusUsecase(DM.get<IWorkOrderRepository>()),
        instanceRenewal: true);
    DM.registerLazySingleton<IGetAssetByIdUsecase>(() => GetAssetByIdUsecase(DM.get<IAssetRepository>()),
        instanceRenewal: true);
    DM.registerLazySingleton<IGetChecklistByWorkOrderUsecase>(
        () => GetChecklistByWorkOrderUsecase(DM.get<ICheckListRepository>()),
        instanceRenewal: true);
    DM.registerLazySingleton<ICreateChecklistItemUsecase>(
        () => CreateCheckListItemUsecase(DM.get<ICheckListRepository>()),
        instanceRenewal: true);
    DM.registerLazySingleton<IUpdateWorkOrderUsecase>(() => UpdateWorkOrderUsecase(DM.get<IWorkOrderRepository>()),
        instanceRenewal: true);

    ///
    DM.registerLazySingleton<IUpdateCheckListItemUsecase>(
        () => UpdateCheckListItemUsecase(DM.get<ICheckListRepository>()),
        instanceRenewal: true);
  }

  void _viewModels() {
    DM.registerLazySingleton<WorkOrdersViewModel>(
        () => WorkOrdersViewModel(DM.get<IGetWorkOrdersUsecase>(), DM.get<ISearchWorkOrderByTitleUsecase>()),
        instanceRenewal: true);
    DM.registerLazySingleton<AssetsViewModel>(() => AssetsViewModel(DM.get<IGetAssetsUsecase>()),
        instanceRenewal: true);
    DM.registerLazySingleton<WorkOrderDetailViewModel>(
        () => WorkOrderDetailViewModel(
              DM.get<IGetUserByIdUsecase>(),
              DM.get<IUpdateCheckListItemUsecase>(),
              DM.get<IUpdateWorkOrderStatusUsecase>(),
              DM.get<IGetAssetByIdUsecase>(),
              DM.get<IGetChecklistByWorkOrderUsecase>(),
            ),
        instanceRenewal: true);
    DM.registerLazySingleton<WorkOrderCreationViewModel>(
        () => WorkOrderCreationViewModel(
              DM.get<ICreateChecklistItemUsecase>(),
              DM.get<ICreateWorkOrderUsecase>(),
              DM.get<IGetUsersUsecase>(),
              DM.get<IGetAssetsUsecase>(),
            ),
        instanceRenewal: true);
    DM.registerLazySingleton<WorkOrderEditingViewModel>(
        () => WorkOrderEditingViewModel(
              DM.get<IUpdateCheckListItemUsecase>(),
              DM.get<IUpdateWorkOrderUsecase>(),
              DM.get<IGetUsersUsecase>(),
              DM.get<IGetAssetsUsecase>(),
            ),
        instanceRenewal: true);
  }
}
