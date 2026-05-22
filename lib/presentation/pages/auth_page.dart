// presentation/pages/auth_page.dart
// SOLID-SRP: única responsabilidad — pantalla de login y registro.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../components/ui/app_toast.dart';
import '../../container.dart' as AppContainer;

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgPage,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(children: [
            const SizedBox(height: 40),

            // Logo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(Icons.account_balance_wallet_rounded,
                  color: Colors.white, size: 40),
            ),
            const SizedBox(height: 16),
            const Text('FinanSys',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                    letterSpacing: -0.5)),
            const SizedBox(height: 4),
            const Text('Tus finanzas bajo control',
                style: TextStyle(fontSize: 14, color: AppTheme.textGrey)),
            const SizedBox(height: 36),

            // Tabs
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: TabBar(
                controller: _tabCtrl,
                labelColor: Colors.white,
                unselectedLabelColor: AppTheme.primary,
                indicator: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(9),
                ),
                tabs: const [
                  Tab(text: 'Iniciar sesión'),
                  Tab(text: 'Registrarse')
                ],
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 380,
              child: TabBarView(
                controller: _tabCtrl,
                children: const [_LoginForm(), _RegisterForm()],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ── Login Form ──
class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await context.read<AuthProvider>().login(
          _emailCtrl.text.trim(),
          _passCtrl.text,
        );
    if (!ok && mounted) {
      AppToast.show(context,
          context.read<AuthProvider>().error ?? 'Error al iniciar sesión',
          type: ToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          controller: _emailCtrl,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Correo o usuario',
            prefixIcon:
                Icon(Icons.person_outline, color: AppTheme.textGrey, size: 20),
          ),
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Ingresa tu correo o usuario' : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _passCtrl,
          obscureText: _obscure,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            prefixIcon: const Icon(Icons.lock_outline,
                color: AppTheme.textGrey, size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                _obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppTheme.textGrey,
                size: 20,
              ),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Ingresa tu contraseña' : null,
        ),
        const SizedBox(height: 20),
        Consumer<AuthProvider>(
          builder: (_, auth, __) => ElevatedButton(
            onPressed: auth.loading ? null : _login,
            child: auth.loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5))
                : const Text('Ingresar'),
          ),
        ),
      ]),
    );
  }
}

// ── Register Form ──----------------------------------------------
class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure = true;

  bool? _usernameDisponible;
  String _usernameMsg = '';
  bool _checkingUsername = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _onUsernameChanged(String value) async {
    final regex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    if (!regex.hasMatch(value)) {
      setState(() {
        _usernameDisponible = false;
        _usernameMsg = 'Solo letras, números y _ (3-20 caracteres)';
        _checkingUsername = false;
      });
      return;
    }

    setState(() => _checkingUsername = true);

    final result =
        await AppContainer.Container.checkUsernameUseCase.execute(value);

    if (mounted) {
      setState(() {
        _usernameDisponible = result.disponible;
        _usernameMsg = result.msg;
        _checkingUsername = false;
      });
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_usernameDisponible != true) {
      AppToast.show(context, 'El username no está disponible',
          type: ToastType.error);
      return;
    }

    final ok = await context.read<AuthProvider>().register(
          _emailCtrl.text.trim(),
          _passCtrl.text,
          _nombreCtrl.text.trim(),
          _usernameCtrl.text.trim(),
        );

    if (!ok && mounted) {
      AppToast.show(
          context, context.read<AuthProvider>().error ?? 'Error al registrarse',
          type: ToastType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(children: [
          // Nombre real
          TextFormField(
            controller: _nombreCtrl,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nombre completo',
              prefixIcon: Icon(Icons.badge_outlined,
                  color: AppTheme.textGrey, size: 20),
            ),
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Ingresa tu nombre' : null,
          ),
          const SizedBox(height: 12),

          // Username con validación en tiempo real
          TextFormField(
            controller: _usernameCtrl,
            decoration: InputDecoration(
              labelText: 'Usuario (ej: JuanCa123)',
              prefixIcon: const Icon(Icons.alternate_email,
                  color: AppTheme.textGrey, size: 20),
              suffixIcon: _checkingUsername
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2)))
                  : _usernameDisponible == null
                      ? null
                      : Icon(
                          _usernameDisponible!
                              ? Icons.check_circle_rounded
                              : Icons.cancel_rounded,
                          color:
                              _usernameDisponible! ? Colors.green : Colors.red,
                          size: 20,
                        ),
              helperText: _usernameMsg.isEmpty
                  ? 'Solo letras, números y _ (3-20 caracteres)'
                  : _usernameMsg,
              helperStyle: TextStyle(
                color: _usernameDisponible == null
                    ? AppTheme.textHint
                    : _usernameDisponible!
                        ? Colors.green
                        : Colors.red,
              ),
            ),
            onChanged: _onUsernameChanged,
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Ingresa un usuario' : null,
          ),
          const SizedBox(height: 12),

          // Email
          TextFormField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
              prefixIcon: Icon(Icons.email_outlined,
                  color: AppTheme.textGrey, size: 20),
            ),
            validator: (v) =>
                (v == null || !v.contains('@')) ? 'Correo inválido' : null,
          ),
          const SizedBox(height: 12),

          // Contraseña
          TextFormField(
            controller: _passCtrl,
            obscureText: _obscure,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.lock_outline,
                  color: AppTheme.textGrey, size: 20),
              suffixIcon: IconButton(
                icon: Icon(
                    _obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppTheme.textGrey,
                    size: 20),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
            validator: (v) =>
                (v != null && v.length < 6) ? 'Mínimo 6 caracteres' : null,
          ),
          const SizedBox(height: 12),

          // Confirmar contraseña
          TextFormField(
            controller: _confirmCtrl,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirmar contraseña',
              prefixIcon:
                  Icon(Icons.lock_outline, color: AppTheme.textGrey, size: 20),
            ),
            validator: (v) =>
                v != _passCtrl.text ? 'Las contraseñas no coinciden' : null,
          ),
          const SizedBox(height: 20),

          Consumer<AuthProvider>(
            builder: (_, auth, __) => ElevatedButton(
              onPressed: auth.loading ? null : _register,
              child: auth.loading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2.5))
                  : const Text('Registrarme'),
            ),
          ),
        ]),
      ),
    );
  }
}
