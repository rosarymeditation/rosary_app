import 'package:get/route_manager.dart';
import 'package:rosary/auth_screens/change_password.dart';
import 'package:rosary/auth_screens/forgot_password.dart';
import 'package:rosary/auth_screens/otp.dart';
import 'package:rosary/auth_screens/sign_in.dart';
import 'package:rosary/distress_screens/distress.dart';
import 'package:rosary/donation/donation_display_screen.dart';
import 'package:rosary/donation/donation_error_screen.dart';
import 'package:rosary/donation/donation_screen.dart';
import 'package:rosary/donation/donation_success.dart';
import 'package:rosary/feed_screens/comment_screen.dart';
import 'package:rosary/feed_screens/comment_edit_screen.dart';
import 'package:rosary/feed_screens/feed_edit_form_screen.dart';
import 'package:rosary/feed_screens/feed_form_screen.dart';
import 'package:rosary/feed_screens/user_feeds.dart';
import 'package:rosary/novena_screens/novena_detail.dart';
import 'package:rosary/novena_screens/novena_list_screen.dart';
import 'package:rosary/prayer_request/public_prayer_request_create.dart';
import 'package:rosary/prayer_screens/prayers.dart';
import 'package:rosary/prayer_screens/prayer_detail.dart';
import 'package:rosary/profile_screens/edit_profile.dart';
import 'package:rosary/profile_screens/profile.dart';
import 'package:rosary/profile_screens/settings_screen.dart';
import 'package:rosary/psalms_screens/psalm_detail.dart';
import 'package:rosary/psalms_screens/psalm_list_screen.dart';
import 'package:rosary/screens/about.dart';
import 'package:rosary/screens/affirmation.dart';
import 'package:rosary/screens/affirmation_verse.dart';
import 'package:rosary/screens/audio_listing.dart';
import 'package:rosary/screens/bug_feedback.dart';
import 'package:rosary/screens/chaplet.dart';
import 'package:rosary/screens/daily_verse.dart';
import 'package:rosary/screens/language.dart';
import 'package:rosary/screens/mystery.dart';
import 'package:rosary/screens/mystery_selection.dart';
import 'package:rosary/screens/pop_up_prayer.dart';
import 'package:rosary/screens/prayer_request.dart';
import 'package:rosary/screens/prayer_request_add.dart';
import 'package:rosary/screens/privacy_screen.dart';
import 'package:rosary/prayer_request/public_prayer_request.dart';
import 'package:rosary/screens/rosary_benefit.dart';
import 'package:rosary/screens/rosary_completion_screen.dart';
import 'package:rosary/screens/rosary_end_prayer.dart';
import 'package:rosary/screens/rosary_intro.dart';
import 'package:rosary/main_screens/start_screen.dart';
import 'package:rosary/songs/deep_sleep_screen.dart';
import 'package:rosary/songs/song_screen.dart';
import 'package:rosary/splash/splash_page.dart';
import 'package:rosary/stations/station_page.dart';
import 'package:rosary/tab_home.dart';

import '../distress_screens/distress_detail.dart';
import '../screens/rosary_progress_prayer.dart';
import '../auth_screens/sign_up.dart';

class RouteHelpers {
  static const String initial = "/";
  static const String home = "/tab-home";
  static const String deepSleepPage = "/deep-sleep";
  static const String distressPage = "/distress-page";
  static const String distressDetailPage = "/distress-detail-page";
  static const String chapletPage = "/home";
  static const String psalmListPage = "/psalm-list-page";
  static const String affirmationAndVerse = "/affirmation_verse";
  static const String privacyPage = "/privacy";
  static const String donationDisplayPage = "/donation-display-page";
  static const String songsPage = "/song-page";
  static const String donationPage = "/donation-page";
  static const String donationErrorPage = "/donation-error-page";
  static const String donationSuccessPage = "/donation-success-page";
  static const String affirmationPage = "/affirmation-page";
  static const String dailyVersePage = "/daily-verse-page";
  static const String profilePage = "/profile-home";
  static const String editProfilePage = "/profile-update-home";
  static const String feedPostPage = "/feed-post";
  static const String commentEdittPage = "/comment-edit";
  static const String prayerDetailPage = "/prayer-detail";
  static const String publicPrayerRequestCreatePage =
      "/public-prayer-request_create";
  static const String publicPrayerRequestPage = "/public-prayer-request";
  static const String feedEdittPage = "/feed-edit";
  static const String prayersPage = "/prayers-page";
  static const String psalmDetailPage = "/psalm-detail-page";
  static const String novenaListPage = "/novena-page";
  static const String novenaDetailPage = "/novena-detail-page";
  static const String signUpPage = "/sign-up";
  static const String otpPage = "/otp";
  static const String signInPage = "/sign-in";
  static const String forgotPasswordPage = "/forgot-password";
  static const String changePasswordPage = "/change-password";
  static const String prayerRequestPage = "/prayer-request";
  static const String prayerRequestAddPage = "/prayer-request-add";
  static const String adioListingPage = "/audio-listing";
  static const String bugFeedbackPage = "/bug-feedback";
  static const String startScreenPage = "/start-screen";
  static const String feedCommentScreenPage = "/feed-comment-screen";
  static const String mysterySelectionPage = "/mystery-selection-page";
  static const String rosaryIntroPage = "/rosary-intro-page";
  static const String popUpPrayer = "/popUpPrayer";
  static const String wayOfCross = "/wayOfCross";
  static const String mysteryPage = "/mystery-page";
  static const String settingsPage = "/setting-page";
  static const String endPrayerPage = "/end-prayer-page";
  static const String aboutPage = "/about-page";
  static const String userFeedPage = "/user-feed-page";
  static const String progressPrayerPage = "/progress-prayer";
  static const String rosaryBenefitPage = "/rosary-benefit-page";
  static const String rosaryCompletionPage = "/rosary-completion-page";
  static const String languagePage = "/language_page";

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashSreen()),
    GetPage(name: donationSuccessPage, page: () => DonationSuccessScreen()),
    GetPage(name: donationErrorPage, page: () => DonationErrorScreen()),
    GetPage(name: aboutPage, page: () => AboutPage()),
    GetPage(name: donationPage, page: () => DonationScreen()),
    GetPage(name: distressPage, page: () => DistressScreen()),
    GetPage(name: distressDetailPage, page: () => DistressDetailScreen()),
    GetPage(name: bugFeedbackPage, page: () => BugFeedbackPage()),
    GetPage(name: prayerDetailPage, page: () => PrayerDetailScreen()),
    GetPage(name: prayersPage, page: () => PrayersScreen()),
    GetPage(name: home, page: () => const TabHomePage()),
    GetPage(name: psalmListPage, page: () => const PsalmListScreen()),
    GetPage(name: languagePage, page: () => const LanguageScreen()),
    GetPage(name: chapletPage, page: () => ChapletPage()),
    GetPage(name: donationDisplayPage, page: () => DonationDisplayScreen()),
    GetPage(name: startScreenPage, page: () => StartScreen()),
    GetPage(name: profilePage, page: () => ProfileScreen()),
    GetPage(name: rosaryIntroPage, page: () => RosaryIntroPage()),
    //GetPage(name: mysterySelectionPage, page: () => MysterySelectionPage()),
    GetPage(name: prayerRequestPage, page: () => PrayerRequestScreen()),
    GetPage(name: progressPrayerPage, page: () => RosaryProgressPrayerScreen()),

    GetPage(name: mysteryPage, page: () => MysteryScreen()),
    GetPage(name: publicPrayerRequestPage, page: () => PublicPrayerRequest()),

    GetPage(name: rosaryBenefitPage, page: () => RosaryBenefitPage()),
    GetPage(name: endPrayerPage, page: () => RosaryEndPrayerScreen()),
    GetPage(name: wayOfCross, page: () => StationPage()),
    GetPage(name: signInPage, page: () => SignInPage()),
    GetPage(name: signUpPage, page: () => SignUpPage()),
    GetPage(name: forgotPasswordPage, page: () => ForgotPasswordPage()),
    GetPage(name: changePasswordPage, page: () => ChangePasswordPage()),
    GetPage(name: otpPage, page: () => OtpScreen()),
    GetPage(name: editProfilePage, page: () => EditProfilePage()),
    GetPage(name: feedEdittPage, page: () => FeedEditFormScreen()),
    GetPage(name: userFeedPage, page: () => UserFeedScreen()),
    GetPage(name: privacyPage, page: () => PrivacyScreen()),
    GetPage(name: psalmDetailPage, page: () => PsalmDetailScreen()),
    GetPage(name: novenaListPage, page: () => NovenaListScreen()),
    GetPage(name: novenaDetailPage, page: () => NovenaDetailScreen()),
    // GetPage(name: deepSleepPage, page: () => DeepSleepScreen()),
    GetPage(
      name: deepSleepPage,
      page: () {
        return DeepSleepScreen();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: popUpPrayer,
      page: () {
        return PopUpPrayer();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: dailyVersePage,
      page: () {
        return DailyVerseScreen();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: affirmationPage,
      page: () {
        return AffirmationScreen();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: prayerRequestAddPage,
      page: () {
        return PrayerRequestAddScreen();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: publicPrayerRequestCreatePage,
      page: () {
        return PublicPrayerRequestCreate();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: feedCommentScreenPage,
      page: () {
        return FeedCommentScreen();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: adioListingPage,
      page: () {
        return AudioListingScreen();
      },
      transition: Transition.downToUp,
    ),
    //GetPage(name: adioListingPage, page: () => AudioListingScreen()),
    GetPage(
      name: affirmationAndVerse,
      page: () {
        return AffirmationAndVerseScreen();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: rosaryCompletionPage,
      page: () {
        return RosaryCompletionScreen();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: feedPostPage,
      page: () {
        return FeedFormScreen();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: commentEdittPage,
      page: () {
        return CommentEditScreen();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: mysterySelectionPage,
      page: () {
        return MysterySelectionPage();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: songsPage,
      page: () {
        return SongScreen();
      },
      transition: Transition.downToUp,
    ),
    GetPage(
      name: settingsPage,
      page: () {
        return SettingsScreen();
      },
      transition: Transition.downToUp,
    ),
  ];
}
