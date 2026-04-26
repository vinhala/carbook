import 'package:carful/src/features/ai/ai_assistant_screen.dart';
import 'package:carful/src/features/ai/maintenance_ai_suggestions_screen.dart';
import 'package:carful/src/features/garage/garage_screen.dart';
import 'package:carful/src/features/maintenance/maintenance_item_editor_screen.dart';
import 'package:carful/src/features/maintenance/maintenance_item_screen.dart';
import 'package:carful/src/features/maintenance/maintenance_schedule_screen.dart';
import 'package:carful/src/features/profile/car_profile_editor_screen.dart';
import 'package:carful/src/features/profile/car_profile_screen.dart';
import 'package:carful/src/features/repairs/repair_entry_editor_screen.dart';
import 'package:carful/src/features/repairs/repair_entry_screen.dart';
import 'package:carful/src/features/repairs/repair_overview_screen.dart';
import 'package:carful/src/domain/repair_status.dart';
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
          path: '/cars/:carId/maintenance/suggestions',
          builder: (context, state) => MaintenanceAiSuggestionsScreen(
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
        GoRoute(
          path: '/cars/:carId/maintenance/:itemId/edit',
          builder: (context, state) => MaintenanceItemEditorScreen(
            carId: int.tryParse(state.pathParameters['carId'] ?? ''),
            itemId: int.tryParse(state.pathParameters['itemId'] ?? ''),
          ),
        ),
        GoRoute(
          path: '/cars/:carId/repairs',
          builder: (context, state) => RepairOverviewScreen(
            carId: int.tryParse(state.pathParameters['carId'] ?? ''),
          ),
        ),
        GoRoute(
          path: '/cars/:carId/repairs/new',
          builder: (context, state) => RepairEntryEditorScreen(
            carId: int.tryParse(state.pathParameters['carId'] ?? ''),
            initialStatus: _parseRepairStatus(
              state.uri.queryParameters['status'],
            ),
            initialModification:
                state.uri.queryParameters['modification'] == 'true',
          ),
        ),
        GoRoute(
          path: '/cars/:carId/repairs/:repairId',
          builder: (context, state) => RepairEntryScreen(
            entryId: int.tryParse(state.pathParameters['repairId'] ?? ''),
          ),
        ),
        GoRoute(
          path: '/cars/:carId/repairs/:repairId/edit',
          builder: (context, state) => RepairEntryEditorScreen(
            entryId: int.tryParse(state.pathParameters['repairId'] ?? ''),
            initialStatus: RepairStatus.planned,
            initialModification: false,
          ),
        ),
        GoRoute(
          path: '/cars/:carId/assistant',
          builder: (context, state) => AiAssistantScreen(
            carId: int.tryParse(state.pathParameters['carId'] ?? ''),
          ),
        ),
      ],
    );
  }

  static final GoRouter router = createRouter();
}

RepairStatus _parseRepairStatus(String? value) {
  if (value == RepairStatus.completed.storageValue) {
    return RepairStatus.completed;
  }
  return RepairStatus.planned;
}
