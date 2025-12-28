final String serverurl = "https://764b2e8f92a6.ngrok-free.app";
final urlClient = {
  //-------------------------- Auth URl ----------------------------//
  "registerAccount": '$serverurl/api/auth/register',
  "login": '$serverurl/api/auth/login',
  "loginverity": '$serverurl/api/verify-otp',
  "logout": '$serverurl/api/auth/logout',
  "otpRegister": "$serverurl/api/auth/register-confirm",
  "resetpassword": "$serverurl/api/auth/password/reset/confirm",
  "forgetpassword": "$serverurl/api/auth/password/reset/request",
  "forgetpasswordverity": "$serverurl/api/auth/password/reset/verity",
  //------------------------------------------------------------------

  ///----- ----------------------Profile----------------- ----- //
  "updateProfile": '$serverurl/api/profile/update',
  "getProfile": '$serverurl/api/profile/show',
  "getpictureProfile": '$serverurl/api/profile/pictureFile',
  //------------------------ settings url ---------------------------//
  "updateEmail": '$serverurl/api/auth/change-email',
  "updateEmailconfirm": '$serverurl/api/auth/change-email/confirm',

  "updatePhone": '$serverurl/api/auth/update-phone',
  "updatePassword": '$serverurl/api/auth/update-password',
  "verifyPassword": '$serverurl/api/auth/check-password',
  "getSetting": '$serverurl/api/setting/show',
  "settingsUpdate": '$serverurl/api/setting/update',
  //  apartment ////
  "getApartments": "$serverurl/api/apartment",
  "getApartmentImages": "$serverurl/api/apartment/getpicture",
  // -------------------------------- Booking ----------------------//
  "requestBooking": "$serverurl/api/bookings",
  "showBooking": "$serverurl/api/bookings",
  "cancelBooking": "$serverurl/api/bookings/destroy",
  "updateBooking": "$serverurl/api/bookings/update",

  // ------------------------------------------------------------------------------------------------//
  // -------------------------------------rentel app---------------------------------------------------//
  // ------------------------------------------------------------------------------------------------//
  "renterApartments": "$serverurl/api/apartment/renter-apartments",
  "add": "$serverurl/api/apartment/",
  "edit": "$serverurl/api/apartment/",
  "delete": "$serverurl/api/apartment/",
  "bookings_incoming": "$serverurl/api/rental/bookings/incoming",
  "bookings_accept": "$serverurl/api/bookings/accept",
  "bookings_decision": "$serverurl/api/bookings/modification-decision",
  "bookings_cancel": "$serverurl/api/bookings/cancel",
  "update-fcm-token": "$serverurl/api/update-fcm-token",
  /////////////// Notification //////////////////////
  ///
  "notifications": "$serverurl/api/notifications",
  "chat_messages": "$serverurl/api/messages",
  "send_message": "$serverurl/api/messages/send",
  "chat_list": "$serverurl/api/conversations",
};
