// container.dart
// Contenedor de inyección de dependencias.
// Arquitectura Hexagonal: conecta puertos con adaptadores.

import 'infrastructure/storage/local_storage_adapter.dart';
import 'infrastructure/api/http_client.dart';
import 'infrastructure/api/mock_auth_adapter.dart';
import 'infrastructure/api/mock_gasto_adapter.dart';
import 'infrastructure/api/mock_categoria_adapter.dart';
import 'infrastructure/api/mock_presupuesto_adapter.dart';
import 'infrastructure/api/mock_divisa_adapter.dart';
import 'infrastructure/api/auth_api_adapter.dart';
import 'infrastructure/api/gasto_api_adapter.dart';
import 'infrastructure/api/categoria_api_adapter.dart';
import 'infrastructure/api/presupuesto_api_adapter.dart';
import 'infrastructure/api/divisa_api_adapter.dart';
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
import 'application/usecases/get_exchange_rate_usecase.dart';
import 'application/usecases/convert_currency_usecase.dart';
import 'application/usecases/update_profile_usecase.dart';

class Container {
  static const bool useMock =
      false; // True = Ver como quedo sin conectar al Back  False= Conectado con el Back

  static final storage = LocalStorageAdapter();
  static final _http = HttpClient(storage);

  static final _authPort =
      useMock ? MockAuthAdapter(storage) : AuthApiAdapter(_http);

  static final _gastoPort =
      useMock ? MockGastoAdapter() : GastoApiAdapter(_http);

  static final _categoriaPort =
      useMock ? MockCategoriaAdapter() : CategoriaApiAdapter(_http);

  static final _presupuestoPort =
      useMock ? MockPresupuestoAdapter() : PresupuestoApiAdapter(_http);

  static final _divisaPort =
      useMock ? MockDivisaAdapter() : DivisaApiAdapter(_http);

  // ── Auth ──
  static final loginUseCase = LoginUseCase(_authPort);
  static final registerUseCase = RegisterUseCase(_authPort);
  static final getProfileUseCase = GetProfileUseCase(_authPort, storage);
  static final logoutUseCase = LogoutUseCase(storage);
  static final listUsersUseCase = ListUsersUseCase(_authPort);

  // ── Gastos ──
  static final listExpensesUseCase = ListExpensesUseCase(_gastoPort);
  static final createExpenseUseCase = CreateExpenseUseCase(_gastoPort);
  static final updateExpenseUseCase = UpdateExpenseUseCase(_gastoPort);
  static final deleteExpenseUseCase = DeleteExpenseUseCase(_gastoPort);
  static final getMonthSummaryUseCase = GetMonthSummaryUseCase(_gastoPort);
  static final getExpensesByCategoryUseCase = GetExpensesByCategoryUseCase(
    _gastoPort,
  );
  static final getMonthlyComparisonUseCase = GetMonthlyComparisonUseCase(
    _gastoPort,
  );

  // ── Categorías ──
  static final listCategoriesUseCase = ListCategoriesUseCase(_categoriaPort);
  static final createCategoryUseCase = CreateCategoryUseCase(_categoriaPort);

  // ── Presupuestos ──
  static final listBudgetsUseCase = ListBudgetsUseCase(_presupuestoPort);
  static final saveBudgetUseCase = SaveBudgetUseCase(_presupuestoPort);

  // ── Divisas ──
  static final getExchangeRateUseCase = GetExchangeRateUseCase(_divisaPort);
  static final convertCurrencyUseCase = ConvertCurrencyUseCase(_divisaPort);

  //---Edicion de Perfil---
  static final updateProfileUseCase = UpdateProfileUseCase(_authPort);
}
