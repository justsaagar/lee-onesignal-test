/// Template-level flags. Set to true to enable optional UI (e.g. feedback strip).
class AppConfig {
  AppConfig._();

  /// Set to true to show the feedback strip on the right edge of the app.
  static const bool showFeedbackStrip = false;

  /// Feedback email shown when the strip is tapped.
  static const String feedbackEmail = 'stackapp.solution@gmail.com';
}
