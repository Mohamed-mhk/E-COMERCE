class AIRules {
  AIRules._(); // Private constructor to make it singleton-like

  // 1. Product Recommendations
  static const int maxRecommendedItems = 10;
  static const double minRecommendationScore = 0.5;

  // 2. Fraud Detection
  static const int maxFailedLogins = 5;
  static const Duration loginBlockDuration = Duration(minutes: 15);

  // 3. Personalized Marketing
  static const int maxPushNotificationsPerDay = 3;

  // 4. Search AI Rules
  static const int maxSearchSuggestions = 5;
  static const int minQueryLength = 2;

  // 5. Image Recognition Rules (for products)
  static const double minImageQuality = 0.7; // For AI image classifier
  static const int maxImageSizeMB = 5;

  // 6. Pricing AI Rules
  static const double maxDiscountPercent = 50.0;
  static const double minProfitMarginPercent = 5.0;

  // 7. General AI Safety & Ethics
  static const bool allowUserGeneratedContent = true;
  static const bool blockExplicitContent = true;
  static const bool logAIActionsForAudit = true;

  // Advanced: Feature flags for AI models
  static const bool enableSmartRecommendation = true;
  static const bool enableDynamicPricing = true;
}
