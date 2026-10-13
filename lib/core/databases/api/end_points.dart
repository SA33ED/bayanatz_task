class EndPoints {
  //! Base URL
  static String baseUrl = 'https://maxliss-app.com';

  //! Authentication
  static String signIn = "$baseUrl/api/v1/auth/login";
  static String signUp = "$baseUrl/api/v1/auth/register";
  static String submitOtp = "$baseUrl/api/v1/auth/verify-otp";
  static String resendCode = "$baseUrl/api/v1/auth/resend-otp";
  static String getProfile = "$baseUrl/api/v1/user/me";
  static String forgetPassword = "$baseUrl/api/v1/auth/forgot-password-request";
  static String submitForgetPasswordOtp =
      "$baseUrl/api/v1/auth/forgot-password-verify";
  static String resetPassword = "$baseUrl/api/v1/auth/forgot-password-reset";

  //!Home
  static String getUserSessions = "$baseUrl/api/v1/sessions/my";

  //! Reservation
  static String getChatQuestions = "$baseUrl/api/v1/user/questions";
  static String getFinalCost = "$baseUrl/api/v1/user/questions/answers";
  static String confirmReservation = "$baseUrl/api/v1/service-requests";
  static String getReservations = "$baseUrl/api/v1/service-requests/my";
  static String getPaymobUrl =
      "$baseUrl/api/v1/service-requests/{serviceRequestId}/payment";
  static String getReservationDetails(int? id) =>
      "$baseUrl/api/v1/service-requests/$id";
  static String cancelReservation(dynamic id) {
    return "$baseUrl/api/v1/service-requests/$id/status";
  }

  //!Profile
  static String updateProfile = "$baseUrl/api/v1/user/profile-basic";
  static String updatePhone = "$baseUrl/api/v1/user/request-phone-update";
  static String submitChangePhoneOtp = "$baseUrl/api/v1/user/verify-new-phone";
  static String updatePassword = "$baseUrl/api/v1/user/password";
  static String postFcmToken = "$baseUrl/api/v1/user/fcm-token";
  static String notifications = "$baseUrl/api/v1/user/notifications";
  static String changeLanguage = "$baseUrl/api/v1/user/lang";

  //! Addresses
  static String addresses = "$baseUrl/api/v1/user/addresses";
  static String updateAddress(dynamic id) {
    return "$baseUrl/api/v1/user/addresses/$id";
  }

  //! Countries, States, Cities
  static String states(int? countryId) =>
      "$baseUrl/api/v1/countries/$countryId/states";
  static String cities(int? stateId) =>
      "$baseUrl/api/v1/states/$stateId/cities";

  //! Community
  static String getPosts = "$baseUrl/api/v1/community";
  static String toggleLikes(int? postId, String? type) =>
      "$baseUrl/api/v1/community/$type/$postId/like";

  //! Reels
  static String getReels = "$baseUrl/api/v1/reels";
  static String getMyReels = "$baseUrl/api/v1/reels/my";
  static String reelDetails(int? reelId) => "$baseUrl/api/v1/reels/$reelId";
  static String toggleReelLike(int? reelId) =>
      "$baseUrl/api/v1/reels/$reelId/like";
  static String uploadReel = "$baseUrl/api/v1/reels";
  static String updateReel(int? reelId) => "$baseUrl/api/v1/reels/$reelId";
  static String deleteReel(int? reelId) => "$baseUrl/api/v1/reels/$reelId";
  static String shareReel(int? reelId) => "$baseUrl/api/v1/reels/$reelId/share";

  //! Salon Session
  static String createSalonSession = "$baseUrl/api/v1/salon-sessions/start";
  static String startSalonSession = "$baseUrl/api/v1/salon-sessions/user-start";
  static String uploadPhoto =
      "$baseUrl/api/v1/salon-sessions/user-upload-photo";
  static String endSalonSession = "$baseUrl/api/v1/salon-sessions/user-end";
  static String getSalonSession =
      "$baseUrl/api/v1/salon-sessions/get-by-request";
  static String rateSalon(dynamic salonId) =>
      "$baseUrl/api/v1/ratings/salons/$salonId";
  static String rateExpert(dynamic expertId) =>
      "$baseUrl/api/v1/ratings/experts/$expertId";

  //! Expert Session
  static String expertQrData(int expertId) =>
      "$baseUrl/api/v1/expert/$expertId/qr-data";
  static String confirmExpertArrival =
      "$baseUrl/api/v1/expert-sessions/user-confirm-arrival";
  static String endExpertSession =
      "$baseUrl/api/v1/expert-sessions/user-complete-service";
  static String getExpertSessionDetails(int? sessionId) =>
      "$baseUrl/api/v1/expert-sessions/$sessionId";
  static String getExpertSessionByRequestId(int? requestId) =>
      "$baseUrl/api/v1/expert-sessions/by-request/$requestId";

  //! App Info
  static String privacyPolicies = "$baseUrl/api/v1/content/privacy-policies";
  static String hairWashingSteps = "$baseUrl/api/v1/content/hair-washing-steps";

  //! Customer Support Chat
  static String chatSend = "$baseUrl/api/v1/user-admin-chat/send";
  static String getMessages = "$baseUrl/api/v1/user-admin-chat/ID/messages";

  //! Get Chats
  static String getChats = "$baseUrl/api/v1/user-admin-chat/my-chats";
}
