// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonAccept => 'Aceitar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonSearch => 'Buscar';

  @override
  String get commonLoading => 'Carregando...';

  @override
  String get commonYes => 'Sim';

  @override
  String get commonNo => 'Não';

  @override
  String get appTitle => 'FinanSys';

  @override
  String get dashRegister => 'Registrar';

  @override
  String get dashMonthlyComparison => 'Comparação mensal';

  @override
  String get dashExpensesByCategory => 'Despesas por categoria';

  @override
  String get dashLatestMovements => 'Últimas movimentações';

  @override
  String get dashSeeAll => 'Ver todas';

  @override
  String get dashNoMovementsMonth => 'Sem movimentações neste mês';

  @override
  String get dashTapPlusFirst => 'Toque em + para registrar a primeira';

  @override
  String get gastosFilterAll => 'Todos';

  @override
  String get gastosFilterExpenses => 'Despesas';

  @override
  String get gastosFilterIncome => 'Receitas';

  @override
  String get gastosEmptyTitle => 'Sem movimentações';

  @override
  String get gastosEmptySubtitle => 'Toque em + para registrar uma';

  @override
  String get gastosDeleteTitle => 'Excluir movimentação';

  @override
  String gastosDeleteConfirm(String name) {
    return 'Tem certeza de que deseja excluir \"$name\"?';
  }

  @override
  String get gastosThisMovement => 'esta movimentação';

  @override
  String get catEmptyTitle => 'Sem categorias';

  @override
  String get catEmptySubtitle => 'Crie a sua primeira categoria';

  @override
  String get catCreate => 'Criar categoria';

  @override
  String get budgetEmptyTitle => 'Sem orçamentos';

  @override
  String get budgetEmptySubtitle => 'Defina limites por categoria';

  @override
  String get budgetCreate => 'Criar orçamento';

  @override
  String get budgetMonthTitle => 'Orçamento do mês';

  @override
  String get headerViewProfile => 'Ver perfil';

  @override
  String get headerAdmin => 'Administração';

  @override
  String get headerLogout => 'Sair';

  @override
  String get headerLogoutConfirm => 'Tem certeza de que deseja sair?';

  @override
  String get headerDebtWarning => 'Você tem dívidas neste mês';

  @override
  String get headerBalanceAvailable => 'Saldo disponível';

  @override
  String get headerIncome => 'Receitas';

  @override
  String get headerExpenses => 'Despesas';

  @override
  String get headerSavings => 'Poupança';

  @override
  String get navHome => 'Início';

  @override
  String get navMovements => 'Movimentações';

  @override
  String get navReports => 'Relatórios';

  @override
  String get navCategories => 'Categorias';

  @override
  String get navBudgets => 'Orçamentos';

  @override
  String get navCurrencies => 'Moedas';

  @override
  String get authLoginTab => 'Entrar';

  @override
  String get authRegisterTab => 'Cadastrar-se';

  @override
  String get authTagline => 'Suas finanças sob controle';

  @override
  String get authLoginError => 'Erro ao entrar';

  @override
  String get authEmailOrUser => 'E-mail ou usuário';

  @override
  String get authEmailOrUserRequired => 'Informe seu e-mail ou usuário';

  @override
  String get authPassword => 'Senha';

  @override
  String get authPasswordRequired => 'Informe sua senha';

  @override
  String get authLoginButton => 'Entrar';

  @override
  String get authUsernameHint =>
      'Somente letras, números e _ (3 a 20 caracteres)';

  @override
  String get authMustAcceptTerms =>
      'Você deve aceitar os Termos e a Política de Dados';

  @override
  String get authUsernameUnavailable => 'O nome de usuário não está disponível';

  @override
  String get authRegisterError => 'Erro ao cadastrar';

  @override
  String get authFullName => 'Nome completo';

  @override
  String get authNameRequired => 'Informe seu nome';

  @override
  String get authUsernameLabel => 'Usuário (ex.: JuanCa123)';

  @override
  String get authUsernameRequired => 'Informe um usuário';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authEmailInvalid => 'E-mail inválido';

  @override
  String get authPasswordMin => 'Mínimo de 6 caracteres';

  @override
  String get authConfirmPassword => 'Confirmar senha';

  @override
  String get authPasswordsMismatch => 'As senhas não coincidem';

  @override
  String get authAcceptPrefix => 'Li e aceito os ';

  @override
  String get authTermsLink => 'Termos e Condições';

  @override
  String get authAuthorizePrefix => 'Autorizo o ';

  @override
  String get authPersonalDataLink => 'Tratamento dos meus Dados Pessoais';

  @override
  String get authRegisterButton => 'Cadastrar';

  @override
  String get authGoogleLoginError => 'Não foi possível entrar com o Google';

  @override
  String get authGoogleLoadError =>
      'Não foi possível carregar o login com o Google';

  @override
  String get authOr => 'ou';

  @override
  String get authGoogleTermsNotice =>
      'Ao continuar com o Google, você aceita os Termos e a Política de Dados do FinanSys.';

  @override
  String get sessionReplacedNotice =>
      'Sua conta foi aberta em outra janela ou dispositivo, por isso esta sessão foi encerrada.';

  @override
  String get sessionInvalidNotice =>
      'Sua sessão não é mais válida. Entre novamente.';

  @override
  String get sessionStillThereTitle => 'Você ainda está aí?';

  @override
  String get sessionWillCloseIn =>
      'Sua sessão será encerrada por inatividade em:';

  @override
  String get sessionContinueButton => 'Continuar sessão';

  @override
  String get sessionClosedTitle => 'Sessão encerrada';

  @override
  String get sessionClosedInactivity =>
      'Sua sessão foi encerrada por inatividade.';

  @override
  String get sessionCanLoginIn => 'Você poderá entrar em:';

  @override
  String sessionSecondsShort(int segundos) {
    return '${segundos}s';
  }

  @override
  String get sessionWaitSecurityNotice =>
      'Por segurança, você deve aguardar antes de entrar novamente.';

  @override
  String get profileTitle => 'Meu perfil';

  @override
  String get profileUpdated => 'Perfil atualizado';

  @override
  String get profileUpdateError => 'Não foi possível atualizar o perfil';

  @override
  String get profileAccountActive => '✅ Conta ativa';

  @override
  String get profileAccountInactive => '❌ Conta inativa';

  @override
  String profileMemberSince(String fecha) {
    return 'Membro desde $fecha';
  }

  @override
  String get profilePersonalData => 'Dados pessoais';

  @override
  String get profileUsername => 'Usuário';

  @override
  String get profileUsernameRequired => 'Informe um nome de usuário';

  @override
  String get profileChangePasswordOptional => 'Alterar senha (opcional)';

  @override
  String get profileNewPassword => 'Nova senha';

  @override
  String get profileSaveChanges => 'Salvar alterações';

  @override
  String get profileAppearance => 'Aparência';

  @override
  String get profileThemeLight => 'Claro';

  @override
  String get profileThemeDark => 'Escuro';

  @override
  String get profileThemeGamer => 'Gamer';

  @override
  String get profileMyData => 'Meus dados';

  @override
  String get profileBackupDescription =>
      'Baixe uma cópia dos seus dados (perfil, categorias, movimentações, orçamentos e compras no exterior) em um arquivo JSON. Não inclui senhas.';

  @override
  String get profileBackupDownloaded => 'Cópia de segurança baixada';

  @override
  String get profileBackupError => 'Não foi possível baixar a cópia';

  @override
  String get profileBackupGenerating => 'Gerando...';

  @override
  String get profileBackupDownload => 'Baixar meus dados';

  @override
  String get profileLegalInfo => 'Informações legais';

  @override
  String get profileDataPolicy => 'Política de tratamento de dados';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get adminTitle => 'Administração';

  @override
  String get adminRefreshTooltip => 'Atualizar';

  @override
  String get adminTabSummary => 'Resumo';

  @override
  String get adminTabUsers => 'Usuários';

  @override
  String get adminTabActivity => 'Atividade';

  @override
  String get adminSummaryLoadError => 'Não foi possível carregar o resumo';

  @override
  String get adminStatUsers => 'Usuários cadastrados';

  @override
  String get adminStatSessions => 'Sessões abertas';

  @override
  String get adminStatNew7d => 'Novos (7 dias)';

  @override
  String get adminStatActive24h => 'Ativos (24 h)';

  @override
  String get adminStatRequests24h => 'Requisições (24 h)';

  @override
  String get adminStatErrors24h => 'Erros (24 h)';

  @override
  String get adminSecurityNote =>
      'Por segurança, este painel nunca mostra senhas.';

  @override
  String get adminNoUsersFound => 'Nenhum usuário encontrado';

  @override
  String get adminSearchHint => 'Buscar por nome, usuário ou e-mail';

  @override
  String adminUserCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count usuários',
      one: '1 usuário',
    );
    return '$_temp0';
  }

  @override
  String get adminAdminBadge => 'Admin';

  @override
  String get adminOnline => 'Online';

  @override
  String get adminActionsUnit => 'ações';

  @override
  String get adminNoActivityYet => 'Sem atividade';

  @override
  String get adminAgoNow => 'Agora mesmo';

  @override
  String adminAgoMinutes(int n) {
    return 'Há $n min';
  }

  @override
  String adminAgoHours(int n) {
    return 'Há $n h';
  }

  @override
  String adminAgoDays(int n) {
    return 'Há $n d';
  }

  @override
  String get adminDetailUser => 'Usuário';

  @override
  String get adminDetailEmail => 'E-mail';

  @override
  String get adminDetailRole => 'Função';

  @override
  String get adminRoleAdmin => 'Administrador';

  @override
  String get adminRoleUser => 'Usuário';

  @override
  String get adminDetailRegistered => 'Cadastrado';

  @override
  String get adminDetailStatus => 'Status';

  @override
  String get adminDetailSession => 'Sessão';

  @override
  String get adminSessionOpen => 'Aberta';

  @override
  String get adminSessionClosed => 'Encerrada';

  @override
  String get adminDetailActions => 'Ações';

  @override
  String adminActionsRegistered(int count) {
    return '$count registradas';
  }

  @override
  String get adminFilterAll => 'Todos';

  @override
  String get adminFilterOnlyErrors => 'Somente erros';

  @override
  String get adminNoActivityRecorded => 'Sem atividade registrada';

  @override
  String adminLoadMore(String shown, String total) {
    return 'Carregar mais ($shown de $total)';
  }

  @override
  String adminTotalRecords(String total) {
    return '$total registros no total';
  }

  @override
  String get adminLogAnonymous => 'Sem sessão (anônimo)';

  @override
  String get logLoginFailed => 'Tentativa de login malsucedida';

  @override
  String get logLoginOk => 'Entrou na conta';

  @override
  String get logRegisterFailed => 'Cadastro malsucedido';

  @override
  String get logRegisterOk => 'Criou a sua conta';

  @override
  String get logLogout => 'Saiu da conta';

  @override
  String get logProfileView => 'Consultou o seu perfil';

  @override
  String get logProfileUpdate => 'Atualizou o seu perfil';

  @override
  String get logThemeChange => 'Alterou o tema';

  @override
  String get logCheckUsername => 'Verificou um nome de usuário';

  @override
  String get logForgotPassword => 'Pediu para redefinir a sua senha';

  @override
  String get logResetPassword => 'Redefiniu a sua senha';

  @override
  String get logUsersList => 'Consultou a lista de usuários';

  @override
  String get logAdminPanel => 'Consultou o painel de administração';

  @override
  String get logMovementCreate => 'Registrou uma movimentação';

  @override
  String get logMovementEdit => 'Editou uma movimentação';

  @override
  String get logMovementDelete => 'Excluiu uma movimentação';

  @override
  String get logReportPdf => 'Baixou um relatório em PDF';

  @override
  String get logReportExcel => 'Baixou um relatório em Excel';

  @override
  String get logReportDownload => 'Baixou um relatório';

  @override
  String get logReportsView => 'Consultou relatórios';

  @override
  String get logMovementsView => 'Consultou as suas movimentações';

  @override
  String get logCategoryCreate => 'Criou uma categoria';

  @override
  String get logCategoryEdit => 'Editou uma categoria';

  @override
  String get logCategoryDelete => 'Excluiu uma categoria';

  @override
  String get logCategoriesView => 'Consultou as suas categorias';

  @override
  String get logBudgetSave => 'Salvou um orçamento';

  @override
  String get logBudgetEdit => 'Editou um orçamento';

  @override
  String get logBudgetDelete => 'Excluiu um orçamento';

  @override
  String get logBudgetsView => 'Consultou os seus orçamentos';

  @override
  String get logForeignSave => 'Salvou uma compra no exterior';

  @override
  String get logForeignDelete => 'Excluiu uma compra no exterior';

  @override
  String get logForeignView => 'Consultou as suas compras no exterior';

  @override
  String get logRatesView => 'Consultou taxas de câmbio';

  @override
  String logWithError(String base) {
    return '$base (com erro)';
  }

  @override
  String get divisasFillNameFirst =>
      'Preencha o nome e faça uma conversão primeiro';

  @override
  String get divisasSaved => '✅ Compra salva';

  @override
  String get divisasSaveError => '❌ Erro ao salvar';

  @override
  String get divisasCalcTitle => 'Calculadora de moedas';

  @override
  String get divisasAutoUpdate => 'O resultado é atualizado automaticamente';

  @override
  String get divisasFrom => 'De';

  @override
  String get divisasAmount => 'Valor';

  @override
  String get divisasTo => 'Para';

  @override
  String get divisasPurchaseNameLabel => 'Nome da compra (ex.: Camiseta Nike)';

  @override
  String get divisasSavePurchase => 'Salvar compra';

  @override
  String get divisasSavedTitle => 'Compras salvas';

  @override
  String get divisasEmpty => 'Sem compras salvas';

  @override
  String get divisasDeleteTitle => 'Excluir compra';

  @override
  String divisasDeleteConfirm(String nombre) {
    return 'Tem certeza de que deseja excluir \"$nombre\"?';
  }

  @override
  String get reportTabByCategory => 'Por categoria';

  @override
  String get reportTabMonthly => 'Mensal';

  @override
  String get reportDistribution => 'Distribuição das despesas';

  @override
  String get reportNoDataMonth => 'Sem dados neste mês';

  @override
  String get reportDetailByCategory => 'Detalhe por categoria';

  @override
  String get reportIncomeVsExpenses => 'Receitas vs. Despesas';

  @override
  String get reportNoData => 'Sem dados';

  @override
  String get reportMonthlyComparison => 'Comparativo mensal';

  @override
  String get reportIncome => 'Receitas';

  @override
  String get reportExpenses => 'Despesas';

  @override
  String get reportBalance => 'Saldo';

  @override
  String reportDownloaded(String formato) {
    return 'Relatório baixado ($formato)';
  }

  @override
  String get reportExportFailed => 'Não foi possível exportar o relatório';

  @override
  String get reportExportTooltip => 'Exportar relatório';

  @override
  String reportOfMonth(String mes) {
    return 'Relatório de $mes';
  }

  @override
  String get reportDownloadPdf => 'Baixar PDF';

  @override
  String get reportDownloadExcel => 'Baixar Excel';

  @override
  String get reportFilePrefix => 'FinanSys_relatorio';

  @override
  String get gastoFormSelectCategory => 'Selecione uma categoria';

  @override
  String get gastoFormEdit => 'Editar movimentação';

  @override
  String get gastoFormNew => 'Nova movimentação';

  @override
  String get gastoFormTabExpense => 'Despesa';

  @override
  String get gastoFormTabIncome => 'Receita';

  @override
  String get gastoFormAmount => 'Valor';

  @override
  String get gastoFormDescription => 'Descrição (opcional)';

  @override
  String get gastoFormCategory => 'Categoria';

  @override
  String get gastoFormNoCategories =>
      'Você não tem categorias deste tipo. Vá em Categorias (menu inferior) e crie uma de despesa ou de receita para poder registrá-lo.';

  @override
  String get gastoFormUpdate => 'Atualizar';

  @override
  String get catFormTitle => 'Nova categoria';

  @override
  String get catFormName => 'Nome';

  @override
  String get catFormType => 'Tipo';

  @override
  String get catFormTypeExpense => 'despesa';

  @override
  String get catFormTypeIncome => 'receita';

  @override
  String get catFormIcon => 'Ícone';

  @override
  String get catFormColor => 'Cor';

  @override
  String get catFormCreate => 'Criar categoria';

  @override
  String get budgetFormTitle => 'Novo orçamento';

  @override
  String get budgetFormCategory => 'Categoria';

  @override
  String get budgetFormLimit => 'Valor limite';

  @override
  String get budgetFormSave => 'Salvar orçamento';

  @override
  String get chartIncome => 'Receitas';

  @override
  String get chartExpenses => 'Despesas';

  @override
  String get chartNoDataMonth => 'Sem dados neste mês';

  @override
  String get chartTotalMonth => 'Total neste mês';

  @override
  String get legalTermsSection1Title => 'Aceitação dos Termos';

  @override
  String get legalTermsSection1Body =>
      'Ao criar uma conta no FinanSys, você concorda em ficar vinculado a estes Termos e Condições. Se não concordar com alguma parte destes termos, não poderá acessar o serviço.';

  @override
  String get legalTermsSection2Title => 'Descrição do Serviço';

  @override
  String get legalTermsSection2Body =>
      'O FinanSys é um aplicativo de gestão de finanças pessoais que permite registrar receitas, despesas e orçamentos e realizar conversões de moedas. O serviço é fornecido \"no estado em que se encontra\" e pode ser modificado ou descontinuado a qualquer momento.';

  @override
  String get legalTermsSection3Title => 'Cadastro e Conta de Usuário';

  @override
  String get legalTermsSection3Body =>
      'Para usar o FinanSys, você deve criar uma conta fornecendo informações verdadeiras e atualizadas. Você é responsável por manter a confidencialidade da sua senha e por todas as atividades realizadas na sua conta. Você deve nos notificar imediatamente sobre qualquer uso não autorizado.';

  @override
  String get legalTermsSection4Title => 'Privacidade e Tratamento de Dados';

  @override
  String get legalTermsSection4Body =>
      'Coletamos e processamos os seus dados pessoais de acordo com a nossa Política de Privacidade. Os seus dados financeiros são privados e não serão compartilhados com terceiros sem o seu consentimento explícito, salvo exigência legal. As senhas são armazenadas criptografadas e nunca em texto simples.';

  @override
  String get legalTermsSection5Title => 'Uso Aceitável';

  @override
  String get legalTermsSection5Body =>
      'Você se compromete a usar o FinanSys apenas para fins legítimos e pessoais. É proibido: tentar acessar contas de outros usuários, realizar engenharia reversa do sistema, usar o serviço para atividades ilegais ou tentar comprometer a segurança da plataforma.';

  @override
  String get legalTermsSection6Title => 'Limitação de Responsabilidade';

  @override
  String get legalTermsSection6Body =>
      'O FinanSys não se responsabiliza por decisões financeiras tomadas com base nas informações exibidas no aplicativo. As informações de taxas de câmbio são referenciais e podem variar. Não garantimos a disponibilidade contínua do serviço.';

  @override
  String get legalTermsSection7Title => 'Propriedade Intelectual';

  @override
  String get legalTermsSection7Body =>
      'Todo o conteúdo, design, código e funcionalidades do FinanSys são propriedade dos seus desenvolvedores. Não é permitido reproduzir, distribuir ou criar trabalhos derivados sem autorização expressa por escrito.';

  @override
  String get legalTermsSection8Title => 'Modificações';

  @override
  String get legalTermsSection8Body =>
      'Reservamo-nos o direito de modificar estes termos a qualquer momento. As alterações entrarão em vigor quando forem publicadas no aplicativo. O uso continuado do serviço após as alterações constitui aceitação dos novos termos.';

  @override
  String get legalTermsSection9Title => 'Cancelamento da Conta';

  @override
  String get legalTermsSection9Body =>
      'Você pode cancelar a sua conta a qualquer momento. Ao fazê-lo, todos os seus dados serão excluídos permanentemente dos nossos servidores. Reservamo-nos o direito de suspender contas que violem estes termos.';

  @override
  String get legalTermsSection10Title => 'Contato';

  @override
  String get legalTermsSection10Body =>
      'Para dúvidas sobre estes Termos e Condições, você pode entrar em contato conosco pelo aplicativo. Faremos o nosso melhor para responder em um prazo razoável.';

  @override
  String get legalTermsAppBarTitle => 'Termos e Condições';

  @override
  String get legalTermsTitle => 'Termos e Condições de Uso';

  @override
  String get legalLastUpdated => 'Última atualização: outubro de 2026';

  @override
  String get legalTermsFooterNote =>
      'Ao criar uma conta no FinanSys, você confirma que leu, entendeu e aceitou estes Termos e Condições em sua totalidade.';

  @override
  String get legalTermsAcceptButton => 'Entendi, aceito os termos';

  @override
  String get legalPrivacySection1Title => 'Responsável pelo Tratamento';

  @override
  String get legalPrivacySection1Body =>
      'O FinanSys, aplicativo de gestão de finanças pessoais desenvolvido como projeto acadêmico por estudantes da Universidad de Cundinamarca, é responsável pelo tratamento dos dados pessoais coletados por meio desta plataforma.';

  @override
  String get legalPrivacySection2Title => 'Dados Pessoais Coletados';

  @override
  String get legalPrivacySection2Body =>
      'Coletamos os seguintes dados pessoais:\n\n• Nome completo\n• Nome de usuário (username)\n• E-mail\n• Senha (armazenada em formato criptografado com bcrypt)\n• Informações financeiras: receitas, despesas, orçamentos e conversões de moedas registrados pelo usuário\n• Dados de atividade: data e hora de acesso, endereço IP';

  @override
  String get legalPrivacySection3Title => 'Finalidade do Tratamento';

  @override
  String get legalPrivacySection3Body =>
      'Os dados pessoais coletados são utilizados exclusivamente para:\n\n• Autenticação e acesso seguro à conta\n• Prestação do serviço de gestão financeira pessoal\n• Personalização da experiência do usuário\n• Monitoramento de segurança e detecção de acessos não autorizados\n• Melhoria contínua do serviço';

  @override
  String get legalPrivacySection4Title => 'Direitos do Titular';

  @override
  String get legalPrivacySection4Body =>
      'Como titular dos seus dados pessoais, você tem direito a:\n\n• Conhecer, atualizar e retificar os seus dados\n• Solicitar prova da autorização concedida\n• Ser informado sobre o uso dos seus dados\n• Revogar a autorização e solicitar a exclusão dos seus dados\n• Acessar gratuitamente os seus dados pessoais\n\nVocê pode exercer esses direitos diretamente nas configurações da sua conta.';

  @override
  String get legalPrivacySection5Title => 'Segurança dos Dados';

  @override
  String get legalPrivacySection5Body =>
      'Implementamos medidas técnicas e organizacionais para proteger os seus dados:\n\n• Senhas criptografadas com o algoritmo bcrypt (salt rounds: 10)\n• Autenticação por tokens JWT com expiração de 24 horas\n• Encerramento automático da sessão por inatividade\n• Registro de acessos e atividade para auditoria\n• Comunicação criptografada por HTTPS';

  @override
  String get legalPrivacySection6Title => 'Compartilhamento de Dados';

  @override
  String get legalPrivacySection6Body =>
      'Os seus dados pessoais NÃO serão vendidos, alugados nem compartilhados com terceiros para fins comerciais. Só poderão ser divulgados nos seguintes casos:\n\n• Por ordem judicial ou exigência de autoridade competente\n• Quando necessário para proteger os direitos de outros usuários\n• Com prestadores de serviços técnicos estritamente necessários para o funcionamento da plataforma, sob acordos de confidencialidade';

  @override
  String get legalPrivacySection7Title => 'Retenção de Dados';

  @override
  String get legalPrivacySection7Body =>
      'Os seus dados serão mantidos enquanto você tiver uma conta ativa no FinanSys. Ao excluir a sua conta, todos os seus dados pessoais e financeiros serão excluídos permanentemente dos nossos servidores em um prazo máximo de 30 dias.';

  @override
  String get legalPrivacySection8Title => 'Cookies e Armazenamento Local';

  @override
  String get legalPrivacySection8Body =>
      'O FinanSys utiliza o armazenamento local do navegador (localStorage) exclusivamente para manter a sessão do usuário por meio de um token de autenticação. Não utilizamos cookies de rastreamento nem de publicidade.';

  @override
  String get legalPrivacySection9Title => 'Transferências Internacionais';

  @override
  String get legalPrivacySection9Body =>
      'Os dados são armazenados em servidores locais ou em serviços de nuvem sediados em jurisdições que possuem padrões adequados de proteção de dados. Não realizamos transferências internacionais de dados sem as garantias adequadas.';

  @override
  String get legalPrivacySection10Title => 'Alterações na Política';

  @override
  String get legalPrivacySection10Body =>
      'Reservamo-nos o direito de atualizar esta política. As alterações serão notificadas por meio do aplicativo. O uso continuado do serviço após a notificação implica a aceitação da nova política.';

  @override
  String get legalPrivacyAppBarTitle => 'Política de Tratamento de Dados';

  @override
  String get legalPrivacyTitle => 'Política de Tratamento de Dados Pessoais';

  @override
  String get legalPrivacyIntro =>
      'Em conformidade com a Lei 1581 de 2012 e o Decreto 1377 de 2013 da República da Colômbia, o FinanSys informa a sua política de tratamento de dados pessoais.';

  @override
  String get legalPrivacyFooterNote =>
      'Ao usar o FinanSys, você autoriza o tratamento dos seus dados pessoais de acordo com esta política, em cumprimento à Lei 1581 de 2012.';

  @override
  String get legalPrivacyAcceptButton => 'Entendi';

  @override
  String errValidationMissingFields(String fields) {
    return 'Faltam dados obrigatórios: $fields';
  }

  @override
  String get errValidationUsernameFormat =>
      'Usuário inválido: somente letras, números e _ (3 a 20 caracteres)';

  @override
  String errValidationPasswordMin(int min) {
    return 'A senha deve ter no mínimo $min caracteres';
  }

  @override
  String get errValidationNothingToUpdate =>
      'Envie pelo menos um campo para atualizar';

  @override
  String get errValidationInvalidTheme => 'Tema inválido';

  @override
  String get errValidationInvalidFormat => 'Formato inválido: use PDF ou Excel';

  @override
  String get errValidationInvalidMonth => 'Mês inválido (1 a 12)';

  @override
  String get errValidationInvalidYear => 'Ano inválido';

  @override
  String get errValidationInvalidUid => 'Identificador de usuário inválido';

  @override
  String get errAuthUserNotFound => 'Usuário não encontrado';

  @override
  String get errAuthWrongPassword => 'Senha incorreta';

  @override
  String get errAuthTokenMissing => 'Você não entrou na conta';

  @override
  String get errAuthTokenInvalid => 'Sua sessão não é válida. Entre novamente.';

  @override
  String get errSesionCerrada =>
      'Sua sessão não é mais válida. Entre novamente.';

  @override
  String get errSesionReemplazada =>
      'Sua conta foi aberta em outra janela ou dispositivo, por isso esta sessão foi encerrada.';

  @override
  String get errAuthSessionCheckFailed => 'Não foi possível verificar a sessão';

  @override
  String get errAuthForbiddenAdminOnly => 'Acesso somente para administradores';

  @override
  String get errAuthAccountDisabled => 'Conta desativada';

  @override
  String get errAuthResetLinkInvalid => 'O link é inválido ou expirou';

  @override
  String get errAuthGoogleTokenMissing => 'Falta o token do Google';

  @override
  String get errAuthGoogleTokenInvalid =>
      'Token do Google inválido ou expirado';

  @override
  String get errAuthGoogleEmailUnverified =>
      'O seu e-mail do Google não está verificado';

  @override
  String get errAuthGoogleNotConfigured =>
      'O login com o Google não está configurado no servidor';

  @override
  String get errConflictEmailTaken => 'O e-mail já está cadastrado';

  @override
  String get errConflictUsernameTaken => 'O nome de usuário já está em uso';

  @override
  String get errNotFoundExpense => 'Despesa não encontrada';

  @override
  String get errNotFoundRoute => 'Recurso não encontrado';

  @override
  String errRateLimitDaily(int limit) {
    return 'Limite diário atingido ($limit solicitações). Tente amanhã.';
  }

  @override
  String get errExternalRateFetchFailed => 'Erro ao consultar a taxa de câmbio';

  @override
  String get errExternalConvertFailed => 'Erro ao converter a moeda';

  @override
  String get errInternalError => 'Erro interno do servidor';

  @override
  String get errNetwork =>
      'Sem conexão. Verifique se o servidor está em execução.';

  @override
  String get errUnknown => 'Ocorreu um erro inesperado';

  @override
  String get authUsernameAvailable => 'Usuário disponível';

  @override
  String get errValidationInvalidFrequency =>
      'Frequência inválida: use semanal, mensal ou anual';

  @override
  String get errValidationInvalidAmount =>
      'O valor deve ser um número maior que zero';

  @override
  String get errValidationInvalidDate => 'Data inválida';

  @override
  String get errValidationInvalidType =>
      'Tipo inválido: use despesa ou receita';

  @override
  String get errNotFoundRecurring => 'Despesa recorrente não encontrada';

  @override
  String get recurTitle => 'Despesas recorrentes';

  @override
  String get recurOpenButton => 'Recorrentes';

  @override
  String get recurNew => 'Nova recorrente';

  @override
  String get recurEdit => 'Editar recorrente';

  @override
  String get recurEmptyTitle => 'Sem despesas recorrentes';

  @override
  String get recurEmptySubtitle =>
      'Registre o seu aluguel, assinaturas ou salário uma única vez e eles se repetirão sozinhos';

  @override
  String get recurFreqWeekly => 'Semanal';

  @override
  String get recurFreqMonthly => 'Mensal';

  @override
  String get recurFreqYearly => 'Anual';

  @override
  String recurNext(String date) {
    return 'Próxima: $date';
  }

  @override
  String recurEnds(String date) {
    return 'Até $date';
  }

  @override
  String get recurPaused => 'Pausada';

  @override
  String get recurPause => 'Pausar';

  @override
  String get recurResume => 'Retomar';

  @override
  String get recurAmount => 'Valor';

  @override
  String get recurDescription => 'Descrição (ex.: Aluguel)';

  @override
  String get recurCategory => 'Categoria';

  @override
  String get recurFrequency => 'Frequência';

  @override
  String get recurStartDate => 'Data de início';

  @override
  String get recurEndDate => 'Data final (opcional)';

  @override
  String get recurNoEnd => 'Sem data final';

  @override
  String get recurClearEnd => 'Remover data final';

  @override
  String recurDeleteConfirm(String name) {
    return 'Excluir \"$name\"? As movimentações já registradas são mantidas.';
  }

  @override
  String get recurInvalidForm => 'Revise o valor e a categoria';

  @override
  String recurGenerated(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count movimentações pendentes foram registradas',
      one: '1 movimentação pendente foi registrada',
    );
    return '$_temp0';
  }

  @override
  String get authForgotLink => 'Esqueceu a sua senha?';

  @override
  String get forgotTitle => 'Recuperar senha';

  @override
  String get forgotIntro =>
      'Informe o seu e-mail e enviaremos um link para criar uma nova senha.';

  @override
  String get forgotEmailLabel => 'E-mail';

  @override
  String get forgotSend => 'Enviar link';

  @override
  String get forgotSent =>
      'Se o e-mail estiver cadastrado, você receberá um link em alguns minutos. Verifique também a pasta de spam.';

  @override
  String get resetTitle => 'Nova senha';

  @override
  String get resetNewPassword => 'Nova senha';

  @override
  String get resetConfirm => 'Confirmar senha';

  @override
  String get resetSave => 'Salvar senha';

  @override
  String get resetSuccess => 'Senha atualizada. Agora você já pode entrar.';

  @override
  String get resetBackToLogin => 'Voltar para o login';

  @override
  String get budgetAlertsTitle => 'Alertas de orçamento';

  @override
  String budgetAlertWarn(String categoria, int pct) {
    return 'Orçamento de $categoria: você usou $pct %';
  }

  @override
  String budgetAlertOver(String categoria, int pct) {
    return 'Você ultrapassou o orçamento de $categoria ($pct %)';
  }

  @override
  String get errNotFoundGoal => 'Meta de poupança não encontrada';

  @override
  String get errNotFoundContribution => 'Movimentação da meta não encontrada';

  @override
  String get errGoalInsufficientFunds =>
      'A retirada é maior do que o valor poupado na meta';

  @override
  String get goalsTitle => 'Metas de poupança';

  @override
  String get goalsAccessSubtitle => 'Poupe para aquilo que você quer alcançar';

  @override
  String get goalsNew => 'Nova meta';

  @override
  String get goalsEdit => 'Editar meta';

  @override
  String get goalsEmptyTitle => 'Você ainda não tem metas';

  @override
  String get goalsEmptySubtitle =>
      'Crie uma meta, como uma viagem ou uma reserva de emergência, e vá somando aportes.';

  @override
  String get goalsIcon => 'Ícone';

  @override
  String get goalsName => 'Nome da meta';

  @override
  String get goalsTarget => 'Valor objetivo';

  @override
  String goalsDeadline(String date) {
    return 'Data limite: $date';
  }

  @override
  String get goalsNoDeadline => 'Sem data limite';

  @override
  String get goalsClearDeadline => 'Remover data limite';

  @override
  String get goalsInvalidForm => 'Informe um nome e um valor maior que zero';

  @override
  String goalsProgress(String saved, String target, int pct) {
    return '$saved de $target · $pct %';
  }

  @override
  String get goalsCompleted => 'Meta alcançada!';

  @override
  String get goalsOverdue => 'O prazo já venceu';

  @override
  String goalsSuggested(String amount) {
    return 'Poupe $amount por mês para chegar a tempo';
  }

  @override
  String get goalsDeposit => 'Aportar';

  @override
  String get goalsWithdraw => 'Retirar';

  @override
  String goalsDepositTitle(String name) {
    return 'Aportar em $name';
  }

  @override
  String goalsWithdrawTitle(String name) {
    return 'Retirar de $name';
  }

  @override
  String get goalsAmount => 'Valor';

  @override
  String get goalsNote => 'Observação (opcional)';

  @override
  String get goalsHistory => 'Histórico';

  @override
  String get goalsHistoryEmpty => 'Ainda não há movimentações';

  @override
  String get goalsContribution => 'Aporte';

  @override
  String get goalsWithdrawal => 'Retirada';

  @override
  String goalsDeleteConfirm(String name) {
    return 'Excluir a meta \"$name\"? O histórico dela também será apagado.';
  }

  @override
  String get goalsDeleteMovementConfirm => 'Excluir esta movimentação?';

  @override
  String get errImportInvalidFile =>
      'Não foi possível ler o arquivo. Use um .csv ou .xlsx válido (máximo de 4 MB)';

  @override
  String errImportMissingColumns(String columns) {
    return 'Faltam colunas obrigatórias: $columns';
  }

  @override
  String get errImportNoRows => 'O arquivo não tem linhas para importar';

  @override
  String errImportTooManyRows(int max) {
    return 'O arquivo tem linhas demais (máximo de $max)';
  }

  @override
  String get errImportInvalidCategory =>
      'Uma das linhas tem uma categoria que não existe';

  @override
  String get importTitle => 'Importar movimentações';

  @override
  String get importOpenButton => 'Importar de CSV ou Excel';

  @override
  String get importIntro =>
      'Envie um arquivo .csv ou .xlsx (até 4 MB e 2000 linhas). A primeira linha deve ter os nomes das colunas.';

  @override
  String get importColumns =>
      'Colunas: data e valor são indispensáveis. Você também pode incluir categoria (o nome de uma das suas categorias), descricao e tipo (despesa ou receita; se faltar, será considerado despesa).';

  @override
  String get importTemplate => 'Baixar modelo';

  @override
  String get importPick => 'Escolher arquivo';

  @override
  String get importPickAnother => 'Escolher outro arquivo';

  @override
  String importSummaryReady(int n) {
    return '$n prontas';
  }

  @override
  String importSummaryErrors(int n) {
    return '$n com erros';
  }

  @override
  String importSummaryDuplicates(int n) {
    return '$n duplicadas';
  }

  @override
  String importUnmatched(String names) {
    return 'Categorias do arquivo que não correspondem às suas: $names';
  }

  @override
  String get importFallbackLabel => 'Usar esta categoria para elas';

  @override
  String get importFallbackNone => 'Não importar essas linhas';

  @override
  String importIncludeDuplicates(int n) {
    return 'Incluir as duplicadas ($n)';
  }

  @override
  String importConfirm(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Importar $n movimentações',
      one: 'Importar 1 movimentação',
    );
    return '$_temp0';
  }

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n movimentações importadas',
      one: '1 movimentação importada',
    );
    return '$_temp0';
  }

  @override
  String importMoreRows(int n) {
    return 'e mais $n linhas';
  }

  @override
  String importRowLabel(int n) {
    return 'Linha $n';
  }

  @override
  String get importDuplicateTag => 'Duplicada';

  @override
  String get importErrInvalidDate => 'data inválida';

  @override
  String get importErrFutureDate => 'data futura';

  @override
  String get importErrInvalidAmount => 'valor inválido';

  @override
  String get importErrInvalidType => 'tipo inválido';

  @override
  String get importErrUnknownCategory => 'categoria não encontrada';
}
