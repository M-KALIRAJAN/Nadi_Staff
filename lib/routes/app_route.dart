
import 'package:go_router/go_router.dart';
import 'package:tech_app/routes/route_name.dart';
import 'package:tech_app/view/auth/login_view.dart';
import 'package:tech_app/view/bottom_nav.dart';
import 'package:tech_app/view/bulk_request.dart';
import 'package:tech_app/view/material_inventory_view.dart';
import 'package:tech_app/view/material_request.dart';
import 'package:tech_app/view/spare_part_used.dart';
import 'package:tech_app/view/update_request.dart';
import 'package:tech_app/widgets/card/servicerequest_cart.dart';
import 'package:tech_app/model/ServiceList _Model.dart';

final Approute = GoRouter(
  initialLocation: RouteName.login,
  routes: [
    GoRoute(
      path: RouteName.login,
      builder: (context, state) =>const LoginView()
      ),
      GoRoute(
        path: RouteName.bottom_nav,
        builder: (context, state) => const BottomNav(),
        ),
        GoRoute(
          path: RouteName.inventory_list,
          builder: (context, state) => const MaterialInventoryView(),
          ),
GoRoute(
  path: RouteName.sparepart_used,
  builder: (context, state) {
    final String userServiceId = state.extra as String;
    return SparePartUsed(userServiceId: userServiceId); // or fetch your Datum by ID
  },
),
        GoRoute(
          path: RouteName.bulk_request,
          builder: (context, state) => const BulkRequest(),
          ),
           GoRoute(
          path: RouteName.material_request,
          builder: (context, state) => const MaterialRequest(),
          ),
          GoRoute(
  path: RouteName.service_card,
  builder: (context, state) {
    final Datum item = state.extra as Datum;
    return ServicerequestCart(data: item);
  },
),
            GoRoute(
              path: RouteName.updated_status,
              builder: (context, state) => const UpdateRequest(),
              )

  ]);