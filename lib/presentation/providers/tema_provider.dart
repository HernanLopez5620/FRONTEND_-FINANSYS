// presentation/providers/tema_provider.dart
import 'package:flutter/material.dart';
import '../../container.dart' as AppContainer;
import '../../core/theme/app_theme.dart';

class TemaProvider extends ChangeNotifier {
  String _tema = 'claro';
  String get tema => _tema;
  ThemeData get themeData => AppTheme.fromNombre(_tema);

  void cargarDesdeUsuario(String t) {
    _tema = t;
    notifyListeners();
  }

  Future<void> setTema(String t) async {
    _tema = t;
    notifyListeners();
    try {
      await AppContainer.Container.updateTemaUseCase.execute(t);
    } catch (_) {}
  }
}
