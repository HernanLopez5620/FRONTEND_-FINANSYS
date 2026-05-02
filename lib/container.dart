// container.dart
// Contenedor de inyección de dependencias.
// Arquitectura Hexagonal: conecta puertos con adaptadores.
// SOLID-DIP: los casos de uso reciben abstracciones, no implementaciones.
//
// ── Para cambiar de MOCK a REAL ──
// Cambia useMock = false cuando el backend esté corriendo.

import 'infrastructure/storage/local_storage_adapter.dart';

// Adaptadores MOCK
import 'infrastructure/api/mock_auth_adapter.dart';
import 'infrastructure/api/mock_gasto_adapter.dart';
import 'infrastructure/api/mock_categoria_adapter.dart';
import 'infrastructure/api/mock_presupuesto_adapter.dart';

// Adaptadores REALES
import 'infrastructure/api/http_client.dart';
import 'infrastructure/api/auth_api_adapter.dart';
import 'infrastructure/api/gasto_api_adapter.dart';
import 'infrastructure/api/categoria_api_adapter.dart';
import 'infrastructure/api/presupuesto_api_adapter.dart';

// Casos de uso
import 'application/usecases/login_usecase.dart';
import 'application/usecases/register_usecase.dart';
import 'application/usecases/get_profile_usecase.dart';
import 'application/usecases/logout_usecase.dart';
import 'application/usecases/list_users_usecase.dart';
import 'application/usecases/list_expenses_usecase.dart';
import 'application/usecases/create_expense_usecase.dart';
import 'application/usecases/update_expense_usecase.dart';
import 'application/usecases/delete_expense_usecase.dart';
import 'application/usecases/get_month_summary_usecase.dart';
import 'application/usecases/get_expenses_by_category_usecase.dart';
import 'application/usecases/get_monthly_comparison_usecase.dart';
import 'application/usecases/list_categories_usecase.dart';
import 'application/usecases/create_category_usecase.dart';
import 'application/usecases/list_budgets_usecase.dart';
import 'application/usecases/save_budget_usecase.dart';

class Container {
  // ── Cambiar a false cuando el backend esté corriendo ──
  static const bool useMock = true;

  // ── Storage siempre real ──
  static final storage = LocalStorageAdapter();

  // ── HTTP Client ──
  static final _http = HttpClient(storage);

  // ── Adaptadores según modo ──
  static final _authPort =
      useMock ? MockAuthAdapter(storage) : AuthApiAdapter(_http);

  static final _gastoPort =
      useMock ? MockGastoAdapter() : GastoApiAdapter(_http);

  static final _categoriaPort =
      useMock ? MockCategoriaAdapter() : CategoriaApiAdapter(_http);

  static final _presupuestoPort =
      useMock ? MockPresupuestoAdapter() : PresupuestoApiAdapter(_http);

  // ── Casos de uso — Auth ──
  static final loginUseCase = LoginUseCase(_authPort);
  static final registerUseCase = RegisterUseCase(_authPort);
  static final getProfileUseCase = GetProfileUseCase(_authPort, storage);
  static final logoutUseCase = LogoutUseCase(storage);
  static final listUsersUseCase = ListUsersUseCase(_authPort);

  // ── Casos de uso — Gastos ──
  static final listExpensesUseCase = ListExpensesUseCase(_gastoPort);
  static final createExpenseUseCase = CreateExpenseUseCase(_gastoPort);
  static final updateExpenseUseCase = UpdateExpenseUseCase(_gastoPort);
  static final deleteExpenseUseCase = DeleteExpenseUseCase(_gastoPort);
  static final getMonthSummaryUseCase = GetMonthSummaryUseCase(_gastoPort);
  static final getExpensesByCategoryUseCase =
      GetExpensesByCategoryUseCase(_gastoPort);
  static final getMonthlyComparisonUseCase =
      GetMonthlyComparisonUseCase(_gastoPort);

  // ── Casos de uso — Categorías ──
  static final listCategoriesUseCase = ListCategoriesUseCase(_categoriaPort);
  static final createCategoryUseCase = CreateCategoryUseCase(_categoriaPort);

  // ── Casos de uso — Presupuestos ──
  static final listBudgetsUseCase = ListBudgetsUseCase(_presupuestoPort);
  static final saveBudgetUseCase = SaveBudgetUseCase(_presupuestoPort);
}
