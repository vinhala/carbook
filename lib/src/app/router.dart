import 'package:carbook/src/features/garage/garage_screen.dart';
import 'package:carbook/src/features/maintenance/maintenance_item_editor_screen.dart';
import 'package:carbook/src/features/maintenance/maintenance_item_screen.dart';
import 'package:carbook/src/features/maintenance/maintenance_schedule_screen.dart';
import 'package:carbook/src/features/profile/car_profile_editor_screen.dart';
import 'package:carbook/src/features/profile/car_profile_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const GarageScreen()),
        GoRoute(
          path: '/cars/new',
          builder: (context, state) => const CarProfileEditorScreen(),
        ),
        GoRoute(
          path: '/cars/:carId',
          builder: (context, state) => CarProfileScreen(
            carId: int.tryParse(state.pathParameters['carId'] ?? ''),
          ),
        ),
        GoRoute(
          path: '/cars/:carId/edit',
          builder: (context, state) => CarProfileEditorScreen(
            carId: int.tryParse(state.pathParameters['carId'] ?? ''),
          ),
        ),
        GoRoute(
          path: '/cars/:carId/maintenance',
          builder: (context, state) => MaintenanceScheduleScreen(
            carId: int.tryParse(state.pathParameters['carId'] ?? ''),
          ),
        ),
        GoRoute(
          path: '/cars/:carId/maintenance/new',
          builder: (context, state) => MaintenanceItemEditorScreen(
            carId: int.tryParse(state.pathParameters['carId'] ?? ''),
          ),
        ),
        GoRoute(
          path: '/cars/:carId/maintenance/:itemId',
          builder: (context, state) => MaintenanceItemScreen(
            itemId: int.tryParse(state.pathParameters['itemId'] ?? ''),
            openLogComposer: state.uri.queryParameters['log'] == 'true',
          ),
        ),
      ],
    );
  }

  static final GoRouter router = createRouter();
}
