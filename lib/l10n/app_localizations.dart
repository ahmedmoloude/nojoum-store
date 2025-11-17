import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// App name field label
  ///
  /// In en, this message translates to:
  /// **'Application Name'**
  String get appName;

  /// The description of the application
  ///
  /// In en, this message translates to:
  /// **'Mauritanian innovation at your fingertips'**
  String get appDescription;

  /// Welcome title on home screen
  ///
  /// In en, this message translates to:
  /// **'Welcome to Noujoum Store'**
  String get welcomeTitle;

  /// Welcome subtitle on home screen
  ///
  /// In en, this message translates to:
  /// **'Discover the best Mauritanian applications'**
  String get welcomeSubtitle;

  /// Featured apps section title
  ///
  /// In en, this message translates to:
  /// **'Featured Applications'**
  String get featuredApps;

  /// All apps section title
  ///
  /// In en, this message translates to:
  /// **'All Applications'**
  String get allApps;

  /// Categories section title
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Search button/field label
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Filter button label
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// Sort button label
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// Contact developer button
  ///
  /// In en, this message translates to:
  /// **'Contact Developer'**
  String get contactDeveloper;

  /// Share button
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Add to favorites button
  ///
  /// In en, this message translates to:
  /// **'Add to Favorites'**
  String get addToFavorites;

  /// Remove from favorites button
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get removeFromFavorites;

  /// No search results message
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// Try different search suggestion
  ///
  /// In en, this message translates to:
  /// **'Try a different search'**
  String get tryDifferentSearch;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Email label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Phone label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Website label
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// WhatsApp label
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// Developer label
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// App category label
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Rating label
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// Downloads label
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloads;

  /// Date added label
  ///
  /// In en, this message translates to:
  /// **'Date Added'**
  String get dateAdded;

  /// Screenshots section title
  ///
  /// In en, this message translates to:
  /// **'Screenshots'**
  String get screenshots;

  /// Description section title
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Tags label
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// Home navigation tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Catalog navigation tab
  ///
  /// In en, this message translates to:
  /// **'Catalog'**
  String get catalog;

  /// Favorites navigation tab
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// Profile navigation tab
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Error message when apps fail to load
  ///
  /// In en, this message translates to:
  /// **'Error loading applications'**
  String get errorLoadingApps;

  /// Error message when contacting developer fails
  ///
  /// In en, this message translates to:
  /// **'Error contacting developer'**
  String get errorContactingDeveloper;

  /// Error message when sharing fails
  ///
  /// In en, this message translates to:
  /// **'Error sharing application'**
  String get errorSharingApp;

  /// Error message when adding to favorites fails
  ///
  /// In en, this message translates to:
  /// **'Error adding to favorites'**
  String get errorAddingToFavorites;

  /// Success message when added to favorites
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get addedToFavorites;

  /// Success message when removed from favorites
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get removedFromFavorites;

  /// Success message when app is shared
  ///
  /// In en, this message translates to:
  /// **'Application shared'**
  String get appShared;

  /// Login screen title
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Login screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Connect to publish your applications'**
  String get loginSubtitle;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No account text on login screen
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account yet?'**
  String get noAccountYet;

  /// Create account button text
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Continue without account button
  ///
  /// In en, this message translates to:
  /// **'Continue without account'**
  String get continueWithoutAccount;

  /// Register screen title
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Name field label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Company name label
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get companyName;

  /// Bio field label
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// Already have account text on register screen
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Browse mode hero title
  ///
  /// In en, this message translates to:
  /// **'Discover the best Mauritanian digital solutions'**
  String get discoverBestSolutions;

  /// Publish mode hero title
  ///
  /// In en, this message translates to:
  /// **'Share your innovation with Mauritania'**
  String get shareYourInnovation;

  /// Browse mode hero description
  ///
  /// In en, this message translates to:
  /// **'Find applications and software created by local developers to meet your needs.'**
  String get findAppsCreatedByLocalDevelopers;

  /// Publish mode hero description
  ///
  /// In en, this message translates to:
  /// **'Join our marketplace and connect with potential clients across the country.'**
  String get joinMarketplaceConnectWithClients;

  /// Explore now button
  ///
  /// In en, this message translates to:
  /// **'Explore Now'**
  String get exploreNow;

  /// Start publishing button
  ///
  /// In en, this message translates to:
  /// **'Start Publishing'**
  String get startPublishing;

  /// Apps available stats label
  ///
  /// In en, this message translates to:
  /// **'Apps Available'**
  String get appsAvailable;

  /// Active developers stats label
  ///
  /// In en, this message translates to:
  /// **'Active Developers'**
  String get activeDevelopers;

  /// Search placeholder text
  ///
  /// In en, this message translates to:
  /// **'Search Mauritanian applications'**
  String get searchMauritanianApps;

  /// Search hint text
  ///
  /// In en, this message translates to:
  /// **'Type an application name, developer or category'**
  String get typeAppNameDeveloperCategory;

  /// Language selection label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Arabic language name in Arabic
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// French language name in French
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get french;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Email validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// Valid email validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// Password validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// Login success message
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccessful;

  /// Login error message
  ///
  /// In en, this message translates to:
  /// **'Login error: {error}'**
  String loginError(String error);

  /// Dashboard screen title
  ///
  /// In en, this message translates to:
  /// **'My Dashboard'**
  String get myDashboard;

  /// Logout button
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Verified account status
  ///
  /// In en, this message translates to:
  /// **'Verified Account'**
  String get verifiedAccount;

  /// Publish app button
  ///
  /// In en, this message translates to:
  /// **'Publish App'**
  String get publishApp;

  /// Payments button
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// Error loading user apps
  ///
  /// In en, this message translates to:
  /// **'Error loading your applications'**
  String get errorLoadingYourApps;

  /// No apps published message
  ///
  /// In en, this message translates to:
  /// **'No applications published'**
  String get noAppsPublished;

  /// Suggestion to publish first app
  ///
  /// In en, this message translates to:
  /// **'Start by publishing your first application'**
  String get startByPublishingFirstApp;

  /// My apps section title
  ///
  /// In en, this message translates to:
  /// **'My Applications ({count})'**
  String myApps(int count);

  /// My account screen title
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// Login prompt message
  ///
  /// In en, this message translates to:
  /// **'Login to access your dashboard'**
  String get loginToAccessDashboard;

  /// Dashboard description
  ///
  /// In en, this message translates to:
  /// **'Manage your published applications and track their performance'**
  String get managePublishedApps;

  /// App details screen title
  ///
  /// In en, this message translates to:
  /// **'App Details'**
  String get appDetails;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Size label
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// Last updated label
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdated;

  /// Requirements section
  ///
  /// In en, this message translates to:
  /// **'Requirements'**
  String get requirements;

  /// Permissions section
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// Reviews section
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// Related apps section
  ///
  /// In en, this message translates to:
  /// **'Related Apps'**
  String get relatedApps;

  /// Payment history screen title
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get paymentHistory;

  /// No payment history message
  ///
  /// In en, this message translates to:
  /// **'No payment history'**
  String get noPaymentHistory;

  /// First payment suggestion
  ///
  /// In en, this message translates to:
  /// **'Make your first payment to see history here'**
  String get makeFirstPayment;

  /// Subscription packages screen title
  ///
  /// In en, this message translates to:
  /// **'Subscription Packages'**
  String get subscriptionPackages;

  /// Package selection subtitle
  ///
  /// In en, this message translates to:
  /// **'Choose a package that suits your needs'**
  String get choosePackage;

  /// Month unit
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// Months unit
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get months;

  /// Select package button
  ///
  /// In en, this message translates to:
  /// **'Select Package'**
  String get selectPackage;

  /// Basic info section title
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInfo;

  /// Tagline field label
  ///
  /// In en, this message translates to:
  /// **'Tagline'**
  String get tagline;

  /// Short description field label
  ///
  /// In en, this message translates to:
  /// **'Short Description'**
  String get shortDescription;

  /// Detailed description field label
  ///
  /// In en, this message translates to:
  /// **'Detailed Description'**
  String get detailedDescription;

  /// App name required validation
  ///
  /// In en, this message translates to:
  /// **'Application name is required'**
  String get appNameRequired;

  /// Tagline required validation
  ///
  /// In en, this message translates to:
  /// **'Tagline is required'**
  String get taglineRequired;

  /// Description validation message
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get descriptionRequired;

  /// Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Previous button
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// Submit button
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Browse apps mode
  ///
  /// In en, this message translates to:
  /// **'Browse Apps'**
  String get browseApps;

  /// Publish apps mode
  ///
  /// In en, this message translates to:
  /// **'Publish Apps'**
  String get publishApps;

  /// Publish my app button
  ///
  /// In en, this message translates to:
  /// **'Publish My App'**
  String get publishMyApp;

  /// Ad space title
  ///
  /// In en, this message translates to:
  /// **'Advertise Here'**
  String get adSpaceTitle;

  /// Ad space subtitle
  ///
  /// In en, this message translates to:
  /// **'Promote your app to thousands of users'**
  String get adSpaceSubtitle;

  /// Sponsored apps section title
  ///
  /// In en, this message translates to:
  /// **'Sponsored Apps'**
  String get sponsoredAppsTitle;

  /// Success stories section title
  ///
  /// In en, this message translates to:
  /// **'Success Stories'**
  String get successStories;

  /// Success story title
  ///
  /// In en, this message translates to:
  /// **'Local hospital adopts MauriHealth'**
  String get hospitalAdoptsMauriHealth;

  /// Success story description
  ///
  /// In en, this message translates to:
  /// **'40% improvement in patient care'**
  String get patientCareImprovement;

  /// Success story title
  ///
  /// In en, this message translates to:
  /// **'SME increases sales by 60%'**
  String get smeIncreasesSales;

  /// Success story description
  ///
  /// In en, this message translates to:
  /// **'Thanks to Sahara Inventory'**
  String get thanksSaharaInventory;

  /// Newsletter section title
  ///
  /// In en, this message translates to:
  /// **'Stay informed about new Mauritanian apps'**
  String get newsletterStayInformed;

  /// Newsletter subtitle
  ///
  /// In en, this message translates to:
  /// **'Get weekly updates on the latest innovations'**
  String get newsletterSubtitle;

  /// Sign up button
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Apps available count label
  ///
  /// In en, this message translates to:
  /// **'Apps Available'**
  String get appsAvailableCount;

  /// Active developers count label
  ///
  /// In en, this message translates to:
  /// **'Active Developers'**
  String get activeDevelopersCount;

  /// Satisfied clients count label
  ///
  /// In en, this message translates to:
  /// **'Satisfied Clients'**
  String get satisfiedClients;

  /// Sort by name ascending
  ///
  /// In en, this message translates to:
  /// **'Name A-Z'**
  String get sortNameAsc;

  /// Sort by name descending
  ///
  /// In en, this message translates to:
  /// **'Name Z-A'**
  String get sortNameDesc;

  /// Sort by rating
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get sortTopRated;

  /// Sort by downloads
  ///
  /// In en, this message translates to:
  /// **'Most Downloaded'**
  String get sortMostDownloaded;

  /// Sort by newest
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get sortNewest;

  /// Sort by oldest
  ///
  /// In en, this message translates to:
  /// **'Oldest'**
  String get sortOldest;

  /// App information section title
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get appInfo;

  /// Target audience label
  ///
  /// In en, this message translates to:
  /// **'Target Audience'**
  String get targetAudience;

  /// Developer type label
  ///
  /// In en, this message translates to:
  /// **'Developer Type'**
  String get developerType;

  /// No email available message
  ///
  /// In en, this message translates to:
  /// **'No email available'**
  String get noEmailAvailable;

  /// Email subject for contacting about app
  ///
  /// In en, this message translates to:
  /// **'Contact about {appName}'**
  String contactEmailSubject(String appName);

  /// Error opening email app
  ///
  /// In en, this message translates to:
  /// **'Could not open email app'**
  String get emailOpenError;

  /// No phone available message
  ///
  /// In en, this message translates to:
  /// **'No phone number available'**
  String get noPhoneAvailable;

  /// Error opening phone app
  ///
  /// In en, this message translates to:
  /// **'Could not open phone app'**
  String get callOpenError;

  /// Call button
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// Unknown package label
  ///
  /// In en, this message translates to:
  /// **'Unknown Package'**
  String get unknownPackage;

  /// Reference label
  ///
  /// In en, this message translates to:
  /// **'Ref'**
  String get reference;

  /// Amount label
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Submission date label
  ///
  /// In en, this message translates to:
  /// **'Submission Date'**
  String get submissionDate;

  /// Payment date label
  ///
  /// In en, this message translates to:
  /// **'Payment Date'**
  String get paymentDate;

  /// Review date label
  ///
  /// In en, this message translates to:
  /// **'Review Date'**
  String get reviewDate;

  /// Your notes label
  ///
  /// In en, this message translates to:
  /// **'Your Notes'**
  String get yourNotes;

  /// Admin notes label
  ///
  /// In en, this message translates to:
  /// **'Admin Notes'**
  String get adminNotes;

  /// Cancel transaction button
  ///
  /// In en, this message translates to:
  /// **'Cancel Transaction'**
  String get cancelTransaction;

  /// Confirm cancellation dialog title
  ///
  /// In en, this message translates to:
  /// **'Confirm Cancellation'**
  String get confirmCancellation;

  /// Cancel transaction confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this transaction?'**
  String get areYouSureCancelTransaction;

  /// No button
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Yes cancel button
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get yesCancel;

  /// Transaction cancelled success message
  ///
  /// In en, this message translates to:
  /// **'Transaction cancelled successfully'**
  String get transactionCancelledSuccess;

  /// Error cancelling transaction message
  ///
  /// In en, this message translates to:
  /// **'Error cancelling transaction: {error}'**
  String errorCancelling(String error);

  /// Upload failed message
  ///
  /// In en, this message translates to:
  /// **'Upload failed: {error}'**
  String uploadFailed(String error);

  /// Icon uploaded success message
  ///
  /// In en, this message translates to:
  /// **'Icon uploaded successfully'**
  String get iconUploadedSuccess;

  /// Max screenshots limit message
  ///
  /// In en, this message translates to:
  /// **'Maximum 5 screenshots allowed'**
  String get maxScreenshotsLimit;

  /// Screenshots uploaded count message
  ///
  /// In en, this message translates to:
  /// **'{count} screenshot(s) uploaded successfully'**
  String screenshotsUploadedCount(int count);

  /// Generic upload failed message
  ///
  /// In en, this message translates to:
  /// **'Upload failed: {error}'**
  String uploadFailedGeneric(String error);

  /// Login required dialog title
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get loginRequiredTitle;

  /// Login required dialog content
  ///
  /// In en, this message translates to:
  /// **'You need to be logged in to publish an app. Would you like to login now?'**
  String get loginRequiredContent;

  /// Subscription required dialog title
  ///
  /// In en, this message translates to:
  /// **'Subscription Required'**
  String get subscriptionRequiredTitle;

  /// Subscription required dialog content
  ///
  /// In en, this message translates to:
  /// **'You need an active subscription to publish apps. Would you like to view subscription packages?'**
  String get subscriptionRequiredContent;

  /// View subscriptions button
  ///
  /// In en, this message translates to:
  /// **'View Subscriptions'**
  String get viewSubscriptions;

  /// Publish app screen title
  ///
  /// In en, this message translates to:
  /// **'Publish App'**
  String get publishAppTitle;

  /// Step progress indicator
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepProgress(int current, int total);

  /// Basic info step title
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get stepBasicInfo;

  /// Technical details step title
  ///
  /// In en, this message translates to:
  /// **'Technical Details'**
  String get stepTechnicalDetails;

  /// Pricing step title
  ///
  /// In en, this message translates to:
  /// **'Pricing & License'**
  String get stepPricing;

  /// Business details step title
  ///
  /// In en, this message translates to:
  /// **'Business Details'**
  String get stepBusinessDetails;

  /// App name field label
  ///
  /// In en, this message translates to:
  /// **'Application Name *'**
  String get appNameLabel;

  /// App name field hint
  ///
  /// In en, this message translates to:
  /// **'Ex: MauriCRM Pro'**
  String get appNameHint;

  /// Tagline field label
  ///
  /// In en, this message translates to:
  /// **'Tagline *'**
  String get taglineLabel;

  /// Tagline field hint
  ///
  /// In en, this message translates to:
  /// **'Ex: Professional client management system'**
  String get taglineHint;

  /// Short description field label
  ///
  /// In en, this message translates to:
  /// **'Short Description *'**
  String get shortDescriptionLabel;

  /// Short description field hint
  ///
  /// In en, this message translates to:
  /// **'Briefly describe your application...'**
  String get shortDescriptionHint;

  /// Short description required validation
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get shortDescriptionRequired;

  /// Main category field label
  ///
  /// In en, this message translates to:
  /// **'Main Category *'**
  String get mainCategoryLabel;

  /// Select category validation message
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get selectCategoryValidation;

  /// Target audience field label
  ///
  /// In en, this message translates to:
  /// **'Target Audience *'**
  String get targetAudienceLabel;

  /// Individuals target audience
  ///
  /// In en, this message translates to:
  /// **'Individuals'**
  String get individuals;

  /// Small business target audience
  ///
  /// In en, this message translates to:
  /// **'Small Businesses'**
  String get smallBusiness;

  /// Enterprise target audience
  ///
  /// In en, this message translates to:
  /// **'Large Enterprises'**
  String get enterprise;

  /// Government target audience
  ///
  /// In en, this message translates to:
  /// **'Government'**
  String get government;

  /// Select target audience validation
  ///
  /// In en, this message translates to:
  /// **'Please select target audience'**
  String get selectTargetAudienceValidation;

  /// App icon field label
  ///
  /// In en, this message translates to:
  /// **'Application Icon *'**
  String get appIconLabel;

  /// Upload icon button
  ///
  /// In en, this message translates to:
  /// **'Upload Icon'**
  String get uploadIcon;

  /// Replace button
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get replace;

  /// Upload icon validation
  ///
  /// In en, this message translates to:
  /// **'Please upload application icon'**
  String get uploadIconValidation;

  /// Screenshots field label
  ///
  /// In en, this message translates to:
  /// **'Screenshots *'**
  String get screenshotsLabel;

  /// Add screenshots button
  ///
  /// In en, this message translates to:
  /// **'Add Screenshots'**
  String get addScreenshots;

  /// Add more screenshots button
  ///
  /// In en, this message translates to:
  /// **'Add More Screenshots'**
  String get addMoreScreenshots;

  /// Screenshots uploaded status
  ///
  /// In en, this message translates to:
  /// **'{count} screenshot(s) uploaded'**
  String screenshotsUploadedStatus(int count);

  /// Screenshots required validation
  ///
  /// In en, this message translates to:
  /// **'At least one screenshot is required'**
  String get screenshotsRequired;

  /// Subcategory field label
  ///
  /// In en, this message translates to:
  /// **'Subcategory *'**
  String get subcategoryLabel;

  /// Subcategory field hint
  ///
  /// In en, this message translates to:
  /// **'Ex: CRM, Accounting, etc.'**
  String get subcategoryHint;

  /// Subcategory required validation
  ///
  /// In en, this message translates to:
  /// **'Subcategory is required'**
  String get subcategoryRequired;

  /// Tags field label
  ///
  /// In en, this message translates to:
  /// **'Tags *'**
  String get tagsLabel;

  /// Tags field hint
  ///
  /// In en, this message translates to:
  /// **'Separate tags with commas (ex: management, client, sales)'**
  String get tagsHint;

  /// Tags required validation
  ///
  /// In en, this message translates to:
  /// **'At least one tag is required'**
  String get tagsRequired;

  /// Email input hint
  ///
  /// In en, this message translates to:
  /// **'Your email'**
  String get yourEmailHint;

  /// OK button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Publish application button
  ///
  /// In en, this message translates to:
  /// **'Publish Application'**
  String get publishApplication;

  /// Fix form errors message
  ///
  /// In en, this message translates to:
  /// **'Please fix form errors'**
  String get pleaseFixFormErrors;

  /// App published dialog title
  ///
  /// In en, this message translates to:
  /// **'App Published'**
  String get appPublishedTitle;

  /// App published dialog content
  ///
  /// In en, this message translates to:
  /// **'Your app has been submitted for review and will be published once approved.'**
  String get appPublishedContent;

  /// Error publishing app message
  ///
  /// In en, this message translates to:
  /// **'Error publishing app: {error}'**
  String errorPublishing(String error);

  /// App type field label
  ///
  /// In en, this message translates to:
  /// **'Application Type *'**
  String get appTypeLabel;

  /// App type validation message
  ///
  /// In en, this message translates to:
  /// **'Please select an application type'**
  String get selectAppTypeValidation;

  /// Platforms field label
  ///
  /// In en, this message translates to:
  /// **'Platforms *'**
  String get platformsLabel;

  /// Platform validation message
  ///
  /// In en, this message translates to:
  /// **'Please select at least one platform'**
  String get selectPlatformValidation;

  /// Version field label
  ///
  /// In en, this message translates to:
  /// **'Version *'**
  String get versionLabel;

  /// Version field hint
  ///
  /// In en, this message translates to:
  /// **'Ex: 1.0.0'**
  String get versionHint;

  /// Version required validation
  ///
  /// In en, this message translates to:
  /// **'Version is required'**
  String get versionRequired;

  /// System requirements field label
  ///
  /// In en, this message translates to:
  /// **'System Requirements'**
  String get systemRequirementsLabel;

  /// System requirements field hint
  ///
  /// In en, this message translates to:
  /// **'Ex: Android 5.0+, iOS 12.0+'**
  String get systemRequirementsHint;

  /// App name validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter the application name'**
  String get validationAppNameRequired;

  /// Tagline validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter the application tagline'**
  String get validationTaglineRequired;

  /// Description validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter the application description'**
  String get validationDescriptionRequired;

  /// Category validation error
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get validationCategoryRequired;

  /// Invalid category error
  ///
  /// In en, this message translates to:
  /// **'Invalid category selected'**
  String get validationInvalidCategory;

  /// Target audience validation error
  ///
  /// In en, this message translates to:
  /// **'Please select the target audience'**
  String get validationTargetAudienceRequired;

  /// Icon validation error
  ///
  /// In en, this message translates to:
  /// **'Please upload the application icon'**
  String get validationIconRequired;

  /// Screenshots validation error
  ///
  /// In en, this message translates to:
  /// **'Please add at least one screenshot'**
  String get validationScreenshotsRequired;

  /// Subcategory validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter the subcategory'**
  String get validationSubcategoryRequired;

  /// Tags validation error
  ///
  /// In en, this message translates to:
  /// **'Please add at least one tag'**
  String get validationTagsRequired;

  /// App type validation error
  ///
  /// In en, this message translates to:
  /// **'Please select the application type'**
  String get validationAppTypeRequired;

  /// Platforms validation error
  ///
  /// In en, this message translates to:
  /// **'Please select at least one platform'**
  String get validationPlatformsRequired;

  /// Version validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter the application version'**
  String get validationVersionRequired;

  /// License type validation error
  ///
  /// In en, this message translates to:
  /// **'Please select the license type'**
  String get validationLicenseTypeRequired;

  /// Pricing model validation error
  ///
  /// In en, this message translates to:
  /// **'Please select the pricing model'**
  String get validationPricingModelRequired;

  /// Business value validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter the business value'**
  String get validationBusinessValueRequired;

  /// Key features validation error
  ///
  /// In en, this message translates to:
  /// **'Please add at least one key feature'**
  String get validationKeyFeaturesRequired;

  /// Mobile app type
  ///
  /// In en, this message translates to:
  /// **'Mobile Application'**
  String get appTypeMobile;

  /// Web app type
  ///
  /// In en, this message translates to:
  /// **'Web Application'**
  String get appTypeWeb;

  /// Desktop app type
  ///
  /// In en, this message translates to:
  /// **'Desktop Application'**
  String get appTypeDesktop;

  /// SaaS app type
  ///
  /// In en, this message translates to:
  /// **'SaaS / Cloud'**
  String get appTypeSaas;

  /// API app type
  ///
  /// In en, this message translates to:
  /// **'API / Service'**
  String get appTypeApi;

  /// Plugin app type
  ///
  /// In en, this message translates to:
  /// **'Plugin / Extension'**
  String get appTypePlugin;

  /// Template app type
  ///
  /// In en, this message translates to:
  /// **'Template / Model'**
  String get appTypeTemplate;

  /// Free pricing model
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get pricingModelFree;

  /// Freemium pricing model
  ///
  /// In en, this message translates to:
  /// **'Freemium'**
  String get pricingModelFreemium;

  /// Paid pricing model
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get pricingModelPaid;

  /// Enterprise pricing model
  ///
  /// In en, this message translates to:
  /// **'Enterprise'**
  String get pricingModelEnterprise;

  /// Custom pricing model
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get pricingModelCustom;

  /// Email support type
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get supportTypeEmail;

  /// Phone support type
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get supportTypePhone;

  /// Chat support type
  ///
  /// In en, this message translates to:
  /// **'Online Chat'**
  String get supportTypeChat;

  /// Training support type
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get supportTypeTraining;

  /// Documentation support type
  ///
  /// In en, this message translates to:
  /// **'Documentation'**
  String get supportTypeDocumentation;

  /// Category label
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// Error loading categories message
  ///
  /// In en, this message translates to:
  /// **'Error loading categories'**
  String get errorLoadingCategories;

  /// No categories available message
  ///
  /// In en, this message translates to:
  /// **'No categories available'**
  String get noCategoriesAvailable;

  /// View all button
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// Popular categories section title
  ///
  /// In en, this message translates to:
  /// **'Popular Categories'**
  String get popularCategories;

  /// Featured label
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// No transactions message
  ///
  /// In en, this message translates to:
  /// **'No transactions'**
  String get noTransactions;

  /// No payments yet message
  ///
  /// In en, this message translates to:
  /// **'No payments yet'**
  String get noPaymentsYet;

  /// Error loading payment info
  ///
  /// In en, this message translates to:
  /// **'Error loading payment info: {error}'**
  String errorLoadingPaymentInfo(String error);

  /// Error selecting image
  ///
  /// In en, this message translates to:
  /// **'Error selecting image: {error}'**
  String errorSelectingImage(String error);

  /// Please select transaction image message
  ///
  /// In en, this message translates to:
  /// **'Please select transaction image'**
  String get pleaseSelectTransactionImage;

  /// Payment submitted success message
  ///
  /// In en, this message translates to:
  /// **'Payment submitted successfully'**
  String get paymentSubmittedSuccess;

  /// Error submitting
  ///
  /// In en, this message translates to:
  /// **'Error submitting: {error}'**
  String errorSubmitting(String error);

  /// Payment title
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// Subscription summary title
  ///
  /// In en, this message translates to:
  /// **'Subscription Summary'**
  String get subscriptionSummaryTitle;

  /// Package label
  ///
  /// In en, this message translates to:
  /// **'Package'**
  String get packageLabel;

  /// Duration label
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get durationLabel;

  /// Price label
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get priceLabel;

  /// Payment instructions title
  ///
  /// In en, this message translates to:
  /// **'Payment Instructions'**
  String get paymentInstructionsTitle;

  /// Bank label
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bankLabel;

  /// Account number label
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumberLabel;

  /// Phone label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneLabel;

  /// Transaction proof required title
  ///
  /// In en, this message translates to:
  /// **'Transaction Proof Required'**
  String get transactionProofRequired;

  /// Upload receipt hint
  ///
  /// In en, this message translates to:
  /// **'Upload receipt or transaction proof'**
  String get uploadReceiptHint;

  /// Tap to select image hint
  ///
  /// In en, this message translates to:
  /// **'Tap to select image'**
  String get tapToSelectImage;

  /// Image types hint
  ///
  /// In en, this message translates to:
  /// **'JPG, PNG, PDF supported'**
  String get imageTypesHint;

  /// Payment date required title
  ///
  /// In en, this message translates to:
  /// **'Payment Date Required'**
  String get paymentDateRequired;

  /// Notes optional title
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get notesOptional;

  /// Notes hint
  ///
  /// In en, this message translates to:
  /// **'Add any additional notes about your payment...'**
  String get notesHint;

  /// Submit payment button
  ///
  /// In en, this message translates to:
  /// **'Submit Payment'**
  String get submitPayment;

  /// Error searching
  ///
  /// In en, this message translates to:
  /// **'Error searching: {error}'**
  String errorSearching(String error);

  /// No results for query
  ///
  /// In en, this message translates to:
  /// **'No results found for \'{query}\''**
  String noResultsForQuery(String query);

  /// Technical details section title
  ///
  /// In en, this message translates to:
  /// **'Technical Details'**
  String get technicalDetails;

  /// Business information section title
  ///
  /// In en, this message translates to:
  /// **'Business Information'**
  String get businessInformation;

  /// Support and documentation section title
  ///
  /// In en, this message translates to:
  /// **'Support & Documentation'**
  String get supportAndDocumentation;

  /// App type label
  ///
  /// In en, this message translates to:
  /// **'App Type'**
  String get appType;

  /// Platforms label
  ///
  /// In en, this message translates to:
  /// **'Platforms'**
  String get platforms;

  /// Current version label
  ///
  /// In en, this message translates to:
  /// **'Current Version'**
  String get currentVersion;

  /// Active users label
  ///
  /// In en, this message translates to:
  /// **'Active Users'**
  String get activeUsers;

  /// Business value label
  ///
  /// In en, this message translates to:
  /// **'Business Value'**
  String get businessValue;

  /// Key features label
  ///
  /// In en, this message translates to:
  /// **'Key Features'**
  String get keyFeatures;

  /// Business sectors label
  ///
  /// In en, this message translates to:
  /// **'Business Sectors'**
  String get businessSectors;

  /// Technical requirements label
  ///
  /// In en, this message translates to:
  /// **'Technical Requirements'**
  String get technicalRequirements;

  /// Support options label
  ///
  /// In en, this message translates to:
  /// **'Support Options'**
  String get supportOptions;

  /// Languages label
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// Documentation label
  ///
  /// In en, this message translates to:
  /// **'Documentation'**
  String get documentation;

  /// Available status
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// Not available status
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// Open source label
  ///
  /// In en, this message translates to:
  /// **'Open Source'**
  String get openSource;

  /// Verified label
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// Free trial label
  ///
  /// In en, this message translates to:
  /// **'Free Trial'**
  String get freeTrial;

  /// Trial days
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String trialDays(int days);

  /// View documentation button
  ///
  /// In en, this message translates to:
  /// **'View Documentation'**
  String get viewDocumentation;

  /// Download app button
  ///
  /// In en, this message translates to:
  /// **'Download App'**
  String get downloadApp;

  /// Try demo button
  ///
  /// In en, this message translates to:
  /// **'Try Demo'**
  String get tryDemo;

  /// Subcategory label
  ///
  /// In en, this message translates to:
  /// **'Subcategory'**
  String get subcategory;

  /// Publish date label
  ///
  /// In en, this message translates to:
  /// **'Publish Date'**
  String get publishDate;

  /// Pricing label
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
