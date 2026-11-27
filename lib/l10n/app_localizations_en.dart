// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonAccept => 'Accept';

  @override
  String get commonClose => 'Close';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonYes => 'Yes';

  @override
  String get commonNo => 'No';

  @override
  String get appTitle => 'FinanSys';

  @override
  String get dashRegister => 'Add';

  @override
  String get dashMonthlyComparison => 'Monthly comparison';

  @override
  String get dashExpensesByCategory => 'Expenses by category';

  @override
  String get dashLatestMovements => 'Latest transactions';

  @override
  String get dashSeeAll => 'See all';

  @override
  String get dashNoMovementsMonth => 'No transactions this month';

  @override
  String get dashTapPlusFirst => 'Tap + to add the first one';

  @override
  String get gastosFilterAll => 'All';

  @override
  String get gastosFilterExpenses => 'Expenses';

  @override
  String get gastosFilterIncome => 'Income';

  @override
  String get gastosEmptyTitle => 'No transactions';

  @override
  String get gastosEmptySubtitle => 'Tap + to add one';

  @override
  String get gastosDeleteTitle => 'Delete transaction';

  @override
  String gastosDeleteConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get gastosThisMovement => 'this transaction';

  @override
  String get catEmptyTitle => 'No categories';

  @override
  String get catEmptySubtitle => 'Create your first category';

  @override
  String get catCreate => 'Create category';

  @override
  String get budgetEmptyTitle => 'No budgets';

  @override
  String get budgetEmptySubtitle => 'Set limits per category';

  @override
  String get budgetCreate => 'Create budget';

  @override
  String get budgetMonthTitle => 'Budget for the month';

  @override
  String get headerViewProfile => 'View profile';

  @override
  String get headerAdmin => 'Administration';

  @override
  String get headerLogout => 'Log out';

  @override
  String get headerLogoutConfirm => 'Are you sure you want to log out?';

  @override
  String get headerDebtWarning => 'You have debts this month';

  @override
  String get headerBalanceAvailable => 'Available balance';

  @override
  String get headerIncome => 'Income';

  @override
  String get headerExpenses => 'Expenses';

  @override
  String get headerSavings => 'Savings';

  @override
  String get navHome => 'Home';

  @override
  String get navMovements => 'Transactions';

  @override
  String get navReports => 'Reports';

  @override
  String get navCategories => 'Categories';

  @override
  String get navBudgets => 'Budgets';

  @override
  String get navCurrencies => 'Currencies';

  @override
  String get authLoginTab => 'Log in';

  @override
  String get authRegisterTab => 'Sign up';

  @override
  String get authTagline => 'Your finances under control';

  @override
  String get authLoginError => 'Login failed';

  @override
  String get authEmailOrUser => 'Email or username';

  @override
  String get authEmailOrUserRequired => 'Enter your email or username';

  @override
  String get authPassword => 'Password';

  @override
  String get authPasswordRequired => 'Enter your password';

  @override
  String get authLoginButton => 'Log in';

  @override
  String get authUsernameHint =>
      'Letters, numbers and _ only (3-20 characters)';

  @override
  String get authMustAcceptTerms =>
      'You must accept the Terms and the Data Policy';

  @override
  String get authUsernameUnavailable => 'The username is not available';

  @override
  String get authRegisterError => 'Sign-up failed';

  @override
  String get authFullName => 'Full name';

  @override
  String get authNameRequired => 'Enter your name';

  @override
  String get authUsernameLabel => 'Username (e.g. JuanCa123)';

  @override
  String get authUsernameRequired => 'Enter a username';

  @override
  String get authEmail => 'Email address';

  @override
  String get authEmailInvalid => 'Invalid email';

  @override
  String get authPasswordMin => 'At least 6 characters';

  @override
  String get authConfirmPassword => 'Confirm password';

  @override
  String get authPasswordsMismatch => 'Passwords do not match';

  @override
  String get authAcceptPrefix => 'I have read and accept the ';

  @override
  String get authTermsLink => 'Terms and Conditions';

  @override
  String get authAuthorizePrefix => 'I authorize the ';

  @override
  String get authPersonalDataLink => 'Processing of my Personal Data';

  @override
  String get authRegisterButton => 'Sign me up';

  @override
  String get authGoogleLoginError => 'Could not log in with Google';

  @override
  String get authGoogleLoadError => 'Could not load Google sign-in';

  @override
  String get authOr => 'or';

  @override
  String get authGoogleTermsNotice =>
      'By continuing with Google you accept FinanSys\' Terms and Data Policy.';

  @override
  String get sessionReplacedNotice =>
      'Your account was opened in another window or device, so this session was closed.';

  @override
  String get sessionInvalidNotice =>
      'Your session is no longer valid. Please log in again.';

  @override
  String get sessionStillThereTitle => 'Are you still there?';

  @override
  String get sessionWillCloseIn =>
      'Your session will close due to inactivity in:';

  @override
  String get sessionContinueButton => 'Continue session';

  @override
  String get sessionClosedTitle => 'Session closed';

  @override
  String get sessionClosedInactivity =>
      'Your session was closed due to inactivity.';

  @override
  String get sessionCanLoginIn => 'You will be able to log in in:';

  @override
  String sessionSecondsShort(int segundos) {
    return '${segundos}s';
  }

  @override
  String get sessionWaitSecurityNotice =>
      'For your security you must wait before logging in again.';

  @override
  String get profileTitle => 'My profile';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get profileUpdateError => 'Could not update the profile';

  @override
  String get profileAccountActive => '✅ Active account';

  @override
  String get profileAccountInactive => '❌ Inactive account';

  @override
  String profileMemberSince(String fecha) {
    return 'Member since $fecha';
  }

  @override
  String get profilePersonalData => 'Personal data';

  @override
  String get profileUsername => 'Username';

  @override
  String get profileUsernameRequired => 'Enter a username';

  @override
  String get profileChangePasswordOptional => 'Change password (optional)';

  @override
  String get profileNewPassword => 'New password';

  @override
  String get profileSaveChanges => 'Save changes';

  @override
  String get profileAppearance => 'Appearance';

  @override
  String get profileThemeLight => 'Light';

  @override
  String get profileThemeDark => 'Dark';

  @override
  String get profileThemeGamer => 'Gamer';

  @override
  String get profileMyData => 'My data';

  @override
  String get profileBackupDescription =>
      'Download a copy of your data (profile, categories, transactions, budgets and foreign purchases) as a JSON file. It does not include passwords.';

  @override
  String get profileBackupDownloaded => 'Backup downloaded';

  @override
  String get profileBackupError => 'Could not download the backup';

  @override
  String get profileBackupGenerating => 'Generating...';

  @override
  String get profileBackupDownload => 'Download my data';

  @override
  String get profileLegalInfo => 'Legal information';

  @override
  String get profileDataPolicy => 'Data processing policy';

  @override
  String get profileLanguage => 'Language';

  @override
  String get adminTitle => 'Administration';

  @override
  String get adminRefreshTooltip => 'Refresh';

  @override
  String get adminTabSummary => 'Summary';

  @override
  String get adminTabUsers => 'Users';

  @override
  String get adminTabActivity => 'Activity';

  @override
  String get adminSummaryLoadError => 'Could not load the summary';

  @override
  String get adminStatUsers => 'Registered users';

  @override
  String get adminStatSessions => 'Open sessions';

  @override
  String get adminStatNew7d => 'New (7 days)';

  @override
  String get adminStatActive24h => 'Active (24 h)';

  @override
  String get adminStatRequests24h => 'Requests (24 h)';

  @override
  String get adminStatErrors24h => 'Errors (24 h)';

  @override
  String get adminSecurityNote =>
      'For security, this panel never shows passwords.';

  @override
  String get adminNoUsersFound => 'No users found';

  @override
  String get adminSearchHint => 'Search by name, username or email';

  @override
  String adminUserCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count users',
      one: '1 user',
    );
    return '$_temp0';
  }

  @override
  String get adminAdminBadge => 'Admin';

  @override
  String get adminOnline => 'Online';

  @override
  String get adminActionsUnit => 'actions';

  @override
  String get adminNoActivityYet => 'No activity';

  @override
  String get adminAgoNow => 'Just now';

  @override
  String adminAgoMinutes(int n) {
    return '$n min ago';
  }

  @override
  String adminAgoHours(int n) {
    return '$n h ago';
  }

  @override
  String adminAgoDays(int n) {
    return '$n d ago';
  }

  @override
  String get adminDetailUser => 'User';

  @override
  String get adminDetailEmail => 'Email';

  @override
  String get adminDetailRole => 'Role';

  @override
  String get adminRoleAdmin => 'Administrator';

  @override
  String get adminRoleUser => 'User';

  @override
  String get adminDetailRegistered => 'Registered';

  @override
  String get adminDetailStatus => 'Status';

  @override
  String get adminDetailSession => 'Session';

  @override
  String get adminSessionOpen => 'Open';

  @override
  String get adminSessionClosed => 'Closed';

  @override
  String get adminDetailActions => 'Actions';

  @override
  String adminActionsRegistered(int count) {
    return '$count recorded';
  }

  @override
  String get adminFilterAll => 'All';

  @override
  String get adminFilterOnlyErrors => 'Errors only';

  @override
  String get adminNoActivityRecorded => 'No activity recorded';

  @override
  String adminLoadMore(String shown, String total) {
    return 'Load more ($shown of $total)';
  }

  @override
  String adminTotalRecords(String total) {
    return '$total records in total';
  }

  @override
  String get adminLogAnonymous => 'No session (anonymous)';

  @override
  String get logLoginFailed => 'Failed login attempt';

  @override
  String get logLoginOk => 'Logged in';

  @override
  String get logRegisterFailed => 'Failed sign-up';

  @override
  String get logRegisterOk => 'Created their account';

  @override
  String get logLogout => 'Logged out';

  @override
  String get logProfileView => 'Viewed their profile';

  @override
  String get logProfileUpdate => 'Updated their profile';

  @override
  String get logThemeChange => 'Changed the theme';

  @override
  String get logCheckUsername => 'Checked a username';

  @override
  String get logForgotPassword => 'Requested a password reset';

  @override
  String get logResetPassword => 'Reset their password';

  @override
  String get logUsersList => 'Viewed the user list';

  @override
  String get logAdminPanel => 'Viewed the admin panel';

  @override
  String get logMovementCreate => 'Added a transaction';

  @override
  String get logMovementEdit => 'Edited a transaction';

  @override
  String get logMovementDelete => 'Deleted a transaction';

  @override
  String get logReportPdf => 'Downloaded a PDF report';

  @override
  String get logReportExcel => 'Downloaded an Excel report';

  @override
  String get logReportDownload => 'Downloaded a report';

  @override
  String get logReportsView => 'Viewed reports';

  @override
  String get logMovementsView => 'Viewed their transactions';

  @override
  String get logCategoryCreate => 'Created a category';

  @override
  String get logCategoryEdit => 'Edited a category';

  @override
  String get logCategoryDelete => 'Deleted a category';

  @override
  String get logCategoriesView => 'Viewed their categories';

  @override
  String get logBudgetSave => 'Saved a budget';

  @override
  String get logBudgetEdit => 'Edited a budget';

  @override
  String get logBudgetDelete => 'Deleted a budget';

  @override
  String get logBudgetsView => 'Viewed their budgets';

  @override
  String get logForeignSave => 'Saved a foreign purchase';

  @override
  String get logForeignDelete => 'Deleted a foreign purchase';

  @override
  String get logForeignView => 'Viewed their foreign purchases';

  @override
  String get logRatesView => 'Viewed exchange rates';

  @override
  String logWithError(String base) {
    return '$base (with error)';
  }

  @override
  String get divisasFillNameFirst => 'Enter a name and run a conversion first';

  @override
  String get divisasSaved => '✅ Purchase saved';

  @override
  String get divisasSaveError => '❌ Could not save';

  @override
  String get divisasCalcTitle => 'Currency calculator';

  @override
  String get divisasAutoUpdate => 'The result updates automatically';

  @override
  String get divisasFrom => 'From';

  @override
  String get divisasAmount => 'Amount';

  @override
  String get divisasTo => 'To';

  @override
  String get divisasPurchaseNameLabel => 'Purchase name (e.g. Nike T-shirt)';

  @override
  String get divisasSavePurchase => 'Save purchase';

  @override
  String get divisasSavedTitle => 'Saved purchases';

  @override
  String get divisasEmpty => 'No saved purchases';

  @override
  String get divisasDeleteTitle => 'Delete purchase';

  @override
  String divisasDeleteConfirm(String nombre) {
    return 'Are you sure you want to delete \"$nombre\"?';
  }

  @override
  String get reportTabByCategory => 'By category';

  @override
  String get reportTabMonthly => 'Monthly';

  @override
  String get reportDistribution => 'Expense distribution';

  @override
  String get reportNoDataMonth => 'No data this month';

  @override
  String get reportDetailByCategory => 'Detail by category';

  @override
  String get reportIncomeVsExpenses => 'Income vs. Expenses';

  @override
  String get reportNoData => 'No data';

  @override
  String get reportMonthlyComparison => 'Monthly comparison';

  @override
  String get reportIncome => 'Income';

  @override
  String get reportExpenses => 'Expenses';

  @override
  String get reportBalance => 'Balance';

  @override
  String reportDownloaded(String formato) {
    return 'Report downloaded ($formato)';
  }

  @override
  String get reportExportFailed => 'Could not export the report';

  @override
  String get reportExportTooltip => 'Export report';

  @override
  String reportOfMonth(String mes) {
    return 'Report for $mes';
  }

  @override
  String get reportDownloadPdf => 'Download PDF';

  @override
  String get reportDownloadExcel => 'Download Excel';

  @override
  String get reportFilePrefix => 'FinanSys_report';

  @override
  String get gastoFormSelectCategory => 'Select a category';

  @override
  String get gastoFormEdit => 'Edit transaction';

  @override
  String get gastoFormNew => 'New transaction';

  @override
  String get gastoFormTabExpense => 'Expense';

  @override
  String get gastoFormTabIncome => 'Income';

  @override
  String get gastoFormAmount => 'Amount';

  @override
  String get gastoFormDescription => 'Description (optional)';

  @override
  String get gastoFormCategory => 'Category';

  @override
  String get gastoFormNoCategories =>
      'You have no categories of this type. Go to Categories (bottom menu) and create an expense or income one to be able to save it.';

  @override
  String get gastoFormUpdate => 'Update';

  @override
  String get catFormTitle => 'New category';

  @override
  String get catFormName => 'Name';

  @override
  String get catFormType => 'Type';

  @override
  String get catFormTypeExpense => 'expense';

  @override
  String get catFormTypeIncome => 'income';

  @override
  String get catFormIcon => 'Icon';

  @override
  String get catFormColor => 'Color';

  @override
  String get catFormCreate => 'Create category';

  @override
  String get budgetFormTitle => 'New budget';

  @override
  String get budgetFormCategory => 'Category';

  @override
  String get budgetFormLimit => 'Limit amount';

  @override
  String get budgetFormSave => 'Save budget';

  @override
  String get chartIncome => 'Income';

  @override
  String get chartExpenses => 'Expenses';

  @override
  String get chartNoDataMonth => 'No data this month';

  @override
  String get chartTotalMonth => 'Total this month';

  @override
  String get legalTermsSection1Title => 'Acceptance of the Terms';

  @override
  String get legalTermsSection1Body =>
      'By creating an account on FinanSys, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you will not be able to access the service.';

  @override
  String get legalTermsSection2Title => 'Description of the Service';

  @override
  String get legalTermsSection2Body =>
      'FinanSys is a personal finance management application that lets you record income, expenses and budgets and perform currency conversions. The service is provided \"as is\" and may be modified or discontinued at any time.';

  @override
  String get legalTermsSection3Title => 'Registration and User Account';

  @override
  String get legalTermsSection3Body =>
      'To use FinanSys you must create an account by providing truthful and up-to-date information. You are responsible for keeping your password confidential and for all activity that takes place under your account. You must notify us immediately of any unauthorized use.';

  @override
  String get legalTermsSection4Title => 'Privacy and Data Processing';

  @override
  String get legalTermsSection4Body =>
      'We collect and process your personal data in accordance with our Privacy Policy. Your financial data is private and will not be shared with third parties without your explicit consent, except where required by law. Passwords are stored encrypted and never in plain text.';

  @override
  String get legalTermsSection5Title => 'Acceptable Use';

  @override
  String get legalTermsSection5Body =>
      'You agree to use FinanSys only for lawful, personal purposes. The following is prohibited: attempting to access other users\' accounts, reverse engineering the system, using the service for illegal activities, or attempting to compromise the security of the platform.';

  @override
  String get legalTermsSection6Title => 'Limitation of Liability';

  @override
  String get legalTermsSection6Body =>
      'FinanSys is not responsible for financial decisions made on the basis of the information shown in the application. Exchange rate information is indicative and may vary. We do not guarantee continuous availability of the service.';

  @override
  String get legalTermsSection7Title => 'Intellectual Property';

  @override
  String get legalTermsSection7Body =>
      'All content, design, code and features of FinanSys are the property of its developers. Reproducing, distributing or creating derivative works is not permitted without express written authorization.';

  @override
  String get legalTermsSection8Title => 'Changes';

  @override
  String get legalTermsSection8Body =>
      'We reserve the right to modify these terms at any time. Changes take effect when they are published in the application. Continued use of the service after the changes constitutes acceptance of the new terms.';

  @override
  String get legalTermsSection9Title => 'Account Cancellation';

  @override
  String get legalTermsSection9Body =>
      'You may cancel your account at any time. When you do, all your data will be permanently deleted from our servers. We reserve the right to suspend accounts that violate these terms.';

  @override
  String get legalTermsSection10Title => 'Contact';

  @override
  String get legalTermsSection10Body =>
      'For questions about these Terms and Conditions you can contact us through the application. We will do our best to respond within a reasonable time.';

  @override
  String get legalTermsAppBarTitle => 'Terms and Conditions';

  @override
  String get legalTermsTitle => 'Terms and Conditions of Use';

  @override
  String get legalLastUpdated => 'Last updated: October 2026';

  @override
  String get legalTermsFooterNote =>
      'By creating an account on FinanSys, you confirm that you have read, understood and accepted these Terms and Conditions in full.';

  @override
  String get legalTermsAcceptButton => 'Understood, I accept the terms';

  @override
  String get legalPrivacySection1Title => 'Data Controller';

  @override
  String get legalPrivacySection1Body =>
      'FinanSys, a personal finance management application developed as an academic project by students of the Universidad de Cundinamarca, is responsible for the processing of the personal data collected through this platform.';

  @override
  String get legalPrivacySection2Title => 'Personal Data Collected';

  @override
  String get legalPrivacySection2Body =>
      'We collect the following personal data:\n\n• Full name\n• Username\n• Email address\n• Password (stored in encrypted form with bcrypt)\n• Financial information: income, expenses, budgets and currency conversions recorded by the user\n• Activity data: date and time of access, IP address';

  @override
  String get legalPrivacySection3Title => 'Purpose of Processing';

  @override
  String get legalPrivacySection3Body =>
      'The personal data collected is used exclusively for:\n\n• Authentication and secure access to the account\n• Providing the personal financial management service\n• Personalizing the user experience\n• Security monitoring and detection of unauthorized access\n• Continuous improvement of the service';

  @override
  String get legalPrivacySection4Title => 'Data Subject Rights';

  @override
  String get legalPrivacySection4Body =>
      'As the owner of your personal data, you have the right to:\n\n• Know, update and correct your data\n• Request proof of the authorization granted\n• Be informed about how your data is used\n• Revoke the authorization and request the deletion of your data\n• Access your personal data free of charge\n\nYou can exercise these rights directly from your account settings.';

  @override
  String get legalPrivacySection5Title => 'Data Security';

  @override
  String get legalPrivacySection5Body =>
      'We implement technical and organizational measures to protect your data:\n\n• Passwords encrypted with the bcrypt algorithm (salt rounds: 10)\n• Authentication through JWT tokens that expire after 24 hours\n• Automatic logout after inactivity\n• Access and activity logging for auditing\n• Encrypted communication over HTTPS';

  @override
  String get legalPrivacySection6Title => 'Data Sharing';

  @override
  String get legalPrivacySection6Body =>
      'Your personal data will NOT be sold, leased or shared with third parties for commercial purposes. It may only be disclosed in the following cases:\n\n• By court order or request from a competent authority\n• When necessary to protect the rights of other users\n• With technical service providers strictly necessary for the operation of the platform, under confidentiality agreements';

  @override
  String get legalPrivacySection7Title => 'Data Retention';

  @override
  String get legalPrivacySection7Body =>
      'Your data will be kept as long as you maintain an active account on FinanSys. When you delete your account, all your personal and financial data will be permanently deleted from our servers within a maximum of 30 days.';

  @override
  String get legalPrivacySection8Title => 'Cookies and Local Storage';

  @override
  String get legalPrivacySection8Body =>
      'FinanSys uses the browser\'s local storage (localStorage) exclusively to keep the user\'s session through an authentication token. We do not use tracking or advertising cookies.';

  @override
  String get legalPrivacySection9Title => 'International Transfers';

  @override
  String get legalPrivacySection9Body =>
      'Data is stored on local servers or on cloud services based in jurisdictions that have adequate data protection standards. We do not carry out international data transfers without adequate safeguards.';

  @override
  String get legalPrivacySection10Title => 'Changes to the Policy';

  @override
  String get legalPrivacySection10Body =>
      'We reserve the right to update this policy. Changes will be notified through the application. Continued use of the service after notification implies acceptance of the new policy.';

  @override
  String get legalPrivacyAppBarTitle => 'Data Processing Policy';

  @override
  String get legalPrivacyTitle => 'Personal Data Processing Policy';

  @override
  String get legalPrivacyIntro =>
      'In accordance with Law 1581 of 2012 and Decree 1377 of 2013 of the Republic of Colombia, FinanSys sets out its personal data processing policy.';

  @override
  String get legalPrivacyFooterNote =>
      'By using FinanSys you authorize the processing of your personal data in accordance with this policy, in compliance with Law 1581 of 2012.';

  @override
  String get legalPrivacyAcceptButton => 'Understood';

  @override
  String errValidationMissingFields(String fields) {
    return 'Required information is missing: $fields';
  }

  @override
  String get errValidationUsernameFormat =>
      'Invalid username: only letters, numbers and _ (3-20 characters)';

  @override
  String errValidationPasswordMin(int min) {
    return 'The password must be at least $min characters long';
  }

  @override
  String get errValidationNothingToUpdate =>
      'You must send at least one field to update';

  @override
  String get errValidationInvalidTheme => 'Invalid theme';

  @override
  String get errValidationInvalidFormat => 'Invalid format: use PDF or Excel';

  @override
  String get errValidationInvalidMonth => 'Invalid month (1 to 12)';

  @override
  String get errValidationInvalidYear => 'Invalid year';

  @override
  String get errValidationInvalidUid => 'Invalid user identifier';

  @override
  String get errAuthUserNotFound => 'User not found';

  @override
  String get errAuthWrongPassword => 'Incorrect password';

  @override
  String get errAuthTokenMissing => 'You are not signed in';

  @override
  String get errAuthTokenInvalid =>
      'Your session is not valid. Please sign in again.';

  @override
  String get errSesionCerrada =>
      'Your session is no longer valid. Please sign in again.';

  @override
  String get errSesionReemplazada =>
      'Your account was opened in another window or device, so this session was closed.';

  @override
  String get errAuthSessionCheckFailed => 'The session could not be verified';

  @override
  String get errAuthForbiddenAdminOnly => 'Access for administrators only';

  @override
  String get errAuthAccountDisabled => 'Account disabled';

  @override
  String get errAuthResetLinkInvalid => 'The link is invalid or has expired';

  @override
  String get errAuthGoogleTokenMissing => 'The Google token is missing';

  @override
  String get errAuthGoogleTokenInvalid => 'Invalid or expired Google token';

  @override
  String get errAuthGoogleEmailUnverified =>
      'Your Google email is not verified';

  @override
  String get errAuthGoogleNotConfigured =>
      'Google sign-in is not configured on the server';

  @override
  String get errConflictEmailTaken => 'The email is already registered';

  @override
  String get errConflictUsernameTaken => 'The username is already taken';

  @override
  String get errNotFoundExpense => 'Expense not found';

  @override
  String get errNotFoundRoute => 'Resource not found';

  @override
  String errRateLimitDaily(int limit) {
    return 'Daily limit reached ($limit requests). Try again tomorrow.';
  }

  @override
  String get errExternalRateFetchFailed => 'Error fetching the exchange rate';

  @override
  String get errExternalConvertFailed => 'Error converting the currency';

  @override
  String get errInternalError => 'Internal server error';

  @override
  String get errNetwork => 'No connection. Check that the server is running.';

  @override
  String get errUnknown => 'An unexpected error occurred';

  @override
  String get authUsernameAvailable => 'Username available';

  @override
  String get errValidationInvalidFrequency =>
      'Invalid frequency: use weekly, monthly or yearly';

  @override
  String get errValidationInvalidAmount =>
      'The amount must be a number greater than zero';

  @override
  String get errValidationInvalidDate => 'Invalid date';

  @override
  String get errValidationInvalidType => 'Invalid type: use expense or income';

  @override
  String get errNotFoundRecurring => 'Recurring expense not found';

  @override
  String get recurTitle => 'Recurring expenses';

  @override
  String get recurOpenButton => 'Recurring';

  @override
  String get recurNew => 'New recurring';

  @override
  String get recurEdit => 'Edit recurring';

  @override
  String get recurEmptyTitle => 'No recurring expenses';

  @override
  String get recurEmptySubtitle =>
      'Add your rent, subscriptions or salary once and they will repeat on their own';

  @override
  String get recurFreqWeekly => 'Weekly';

  @override
  String get recurFreqMonthly => 'Monthly';

  @override
  String get recurFreqYearly => 'Yearly';

  @override
  String recurNext(String date) {
    return 'Next: $date';
  }

  @override
  String recurEnds(String date) {
    return 'Until $date';
  }

  @override
  String get recurPaused => 'Paused';

  @override
  String get recurPause => 'Pause';

  @override
  String get recurResume => 'Resume';

  @override
  String get recurAmount => 'Amount';

  @override
  String get recurDescription => 'Description (e.g. Rent)';

  @override
  String get recurCategory => 'Category';

  @override
  String get recurFrequency => 'Frequency';

  @override
  String get recurStartDate => 'Start date';

  @override
  String get recurEndDate => 'End date (optional)';

  @override
  String get recurNoEnd => 'No end date';

  @override
  String get recurClearEnd => 'Remove end date';

  @override
  String recurDeleteConfirm(String name) {
    return 'Delete \"$name\"? Movements already recorded are kept.';
  }

  @override
  String get recurInvalidForm => 'Check the amount and the category';

  @override
  String recurGenerated(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pending movements were recorded',
      one: '1 pending movement was recorded',
    );
    return '$_temp0';
  }

  @override
  String get authForgotLink => 'Forgot your password?';

  @override
  String get forgotTitle => 'Reset password';

  @override
  String get forgotIntro =>
      'Enter your email and we will send you a link to create a new password.';

  @override
  String get forgotEmailLabel => 'Email';

  @override
  String get forgotSend => 'Send link';

  @override
  String get forgotSent =>
      'If the email is registered, you will receive a link in a few minutes. Also check your spam folder.';

  @override
  String get resetTitle => 'New password';

  @override
  String get resetNewPassword => 'New password';

  @override
  String get resetConfirm => 'Confirm password';

  @override
  String get resetSave => 'Save password';

  @override
  String get resetSuccess => 'Password updated. You can now sign in.';

  @override
  String get resetBackToLogin => 'Back to sign in';

  @override
  String get budgetAlertsTitle => 'Budget alerts';

  @override
  String budgetAlertWarn(String categoria, int pct) {
    return '$categoria budget: you have used $pct%';
  }

  @override
  String budgetAlertOver(String categoria, int pct) {
    return 'You went over your $categoria budget ($pct%)';
  }

  @override
  String get errNotFoundGoal => 'Savings goal not found';

  @override
  String get errNotFoundContribution => 'Goal movement not found';

  @override
  String get errGoalInsufficientFunds =>
      'The withdrawal is more than what is saved in the goal';

  @override
  String get goalsTitle => 'Savings goals';

  @override
  String get goalsAccessSubtitle => 'Save for what you want to achieve';

  @override
  String get goalsNew => 'New goal';

  @override
  String get goalsEdit => 'Edit goal';

  @override
  String get goalsEmptyTitle => 'No goals yet';

  @override
  String get goalsEmptySubtitle =>
      'Create a goal, like a trip or an emergency fund, and keep adding contributions.';

  @override
  String get goalsIcon => 'Icon';

  @override
  String get goalsName => 'Goal name';

  @override
  String get goalsTarget => 'Target amount';

  @override
  String goalsDeadline(String date) {
    return 'Deadline: $date';
  }

  @override
  String get goalsNoDeadline => 'No deadline';

  @override
  String get goalsClearDeadline => 'Remove deadline';

  @override
  String get goalsInvalidForm => 'Enter a name and an amount greater than zero';

  @override
  String goalsProgress(String saved, String target, int pct) {
    return '$saved of $target · $pct%';
  }

  @override
  String get goalsCompleted => 'Goal reached!';

  @override
  String get goalsOverdue => 'The deadline has passed';

  @override
  String goalsSuggested(String amount) {
    return 'Save $amount a month to get there on time';
  }

  @override
  String get goalsDeposit => 'Add';

  @override
  String get goalsWithdraw => 'Withdraw';

  @override
  String goalsDepositTitle(String name) {
    return 'Add to $name';
  }

  @override
  String goalsWithdrawTitle(String name) {
    return 'Withdraw from $name';
  }

  @override
  String get goalsAmount => 'Amount';

  @override
  String get goalsNote => 'Note (optional)';

  @override
  String get goalsHistory => 'History';

  @override
  String get goalsHistoryEmpty => 'No movements yet';

  @override
  String get goalsContribution => 'Deposit';

  @override
  String get goalsWithdrawal => 'Withdrawal';

  @override
  String goalsDeleteConfirm(String name) {
    return 'Delete the goal \"$name\"? Its history will be deleted too.';
  }

  @override
  String get goalsDeleteMovementConfirm => 'Delete this movement?';

  @override
  String get errImportInvalidFile =>
      'The file could not be read. Use a valid .csv or .xlsx (4 MB maximum)';

  @override
  String errImportMissingColumns(String columns) {
    return 'Required columns are missing: $columns';
  }

  @override
  String get errImportNoRows => 'The file has no rows to import';

  @override
  String errImportTooManyRows(int max) {
    return 'The file has too many rows ($max maximum)';
  }

  @override
  String get errImportInvalidCategory =>
      'One of the rows has a category that does not exist';

  @override
  String get importTitle => 'Import transactions';

  @override
  String get importOpenButton => 'Import from CSV or Excel';

  @override
  String get importIntro =>
      'Upload a .csv or .xlsx file (up to 4 MB and 2000 rows). The first row must contain the column names.';

  @override
  String get importColumns =>
      'Columns: date and amount are required. You can also include category (the name of one of your categories), description and type (expense or income; if missing, it is treated as an expense). Headers can be in English or Spanish (fecha, monto, categoria, descripcion, tipo).';

  @override
  String get importTemplate => 'Download template';

  @override
  String get importPick => 'Choose file';

  @override
  String get importPickAnother => 'Choose another file';

  @override
  String importSummaryReady(int n) {
    return '$n ready';
  }

  @override
  String importSummaryErrors(int n) {
    return '$n with errors';
  }

  @override
  String importSummaryDuplicates(int n) {
    return '$n duplicates';
  }

  @override
  String importUnmatched(String names) {
    return 'Categories in the file that do not match yours: $names';
  }

  @override
  String get importFallbackLabel => 'Use this category for them';

  @override
  String get importFallbackNone => 'Skip those rows';

  @override
  String importIncludeDuplicates(int n) {
    return 'Include duplicates ($n)';
  }

  @override
  String importConfirm(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Import $n transactions',
      one: 'Import 1 transaction',
    );
    return '$_temp0';
  }

  @override
  String importDone(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n transactions imported',
      one: '1 transaction imported',
    );
    return '$_temp0';
  }

  @override
  String importMoreRows(int n) {
    return 'and $n more rows';
  }

  @override
  String importRowLabel(int n) {
    return 'Row $n';
  }

  @override
  String get importDuplicateTag => 'Duplicate';

  @override
  String get importErrInvalidDate => 'invalid date';

  @override
  String get importErrFutureDate => 'future date';

  @override
  String get importErrInvalidAmount => 'invalid amount';

  @override
  String get importErrInvalidType => 'invalid type';

  @override
  String get importErrUnknownCategory => 'category not found';
}
