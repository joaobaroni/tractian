import 'package:get/get.dart';
import 'package:tractian/presentation/view/view.dart';

import '../domain/domain.dart';
import '../presentation/utils.dart';

///
/// App Routes
///
abstract class AppRoutes {
  static const String root = '/root';
  static const String workOrders = '/workorders';
  static const String assets = '/assets';
  static const String assetDetail = '/asset-detail';
  static const String workOrderDetail = '/workorder-detail';
  static const String workOrderCreation = '/workorder-creation';
  static const String workOrderEditing = '/workorder-editing';

  static List<GetPage> pages() => [
        GetPage(
          name: root,
          page: () => const RootView(),
        ),
        GetPage(
          name: workOrders,
          page: () => const WorkOrdersView(),
        ),
        GetPage(
          name: assets,
          page: () => const AssetsView(),
        ),
        GetPage(
          name: assetDetail,
          page: () => AssetDetail(asset: Nav.args.data as Asset),
        ),
        GetPage(
          name: workOrderDetail,
          page: () => WorkOrderDetailView(workOrder: Nav.args.data as WorkOrder),
        ),
        GetPage(
          name: workOrderCreation,
          page: () => WorkOrderCreationView(),
        ),
        GetPage(
          name: workOrderEditing,
          page: () => WorkOrderEditingView(arguments: Nav.args.data as WorkOrderEditingArguments),
        ),
      ];
}
