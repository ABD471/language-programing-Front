final String serverurl = "https://6d6a30a113fd.ngrok-free.app";

final Map<String, String> urlClient = {
  // -------------------------- Auth URl ---------------------------- //
  "registerAccount":        '$serverurl/api/auth/register',
  "login":                  '$serverurl/api/auth/login',
  "loginverity":            '$serverurl/api/verify-otp',
  "logout":                 '$serverurl/api/auth/logout',
  "otpRegister":            "$serverurl/api/auth/register-confirm",
  "resetpassword":          "$serverurl/api/auth/password/reset/confirm",
  "forgetpassword":         "$serverurl/api/auth/password/reset/request",
  "forgetpasswordverity":   "$serverurl/api/auth/password/reset/verity",

  // -------------------------- Profile ----------------------------- //
  "updateProfile":          '$serverurl/api/profile/update',
  "getProfile":             '$serverurl/api/profile/show',
  "getpictureProfile":      '$serverurl/api/profile/pictureFile',

  // ------------------------- Settings ----------------------------- //
  "updateEmail":            '$serverurl/api/auth/change-email',
  "updateEmailconfirm":     '$serverurl/api/auth/change-email/confirm',
  "updatePhone":            '$serverurl/api/auth/update-phone',
  "updatePassword":         '$serverurl/api/auth/update-password',
  "verifyPassword":         '$serverurl/api/auth/check-password',
  "getSetting":             '$serverurl/api/setting/show',
  "settingsUpdate":         '$serverurl/api/setting/update',
  "update-fcm-token":       "$serverurl/api/update-fcm-token",

  // ------------------------- Apartment ---------------------------- //
  "getApartments":          "$serverurl/api/apartment",
  "getApartmentImages":     "$serverurl/api/apartment/getpicture",
  "renterApartments":       "$serverurl/api/apartment/renter-apartments",
  "add":                    "$serverurl/api/apartment/",
  "edit":                   "$serverurl/api/apartment/",
  "delete":                 "$serverurl/api/apartment/",

  // -------------------------- Booking ----------------------------- //
  "requestBooking":         "$serverurl/api/bookings",
  "showBooking":            "$serverurl/api/bookings",
  "cancelBooking":          "$serverurl/api/bookings/destroy",
  "updateBooking":          "$serverurl/api/bookings/update",
  
  // ----------------------- Rental (Owner) ------------------------- //
  "bookings_incoming":      "$serverurl/api/rental/bookings/incoming",
  "bookings_accept":        "$serverurl/api/bookings/accept",
  "bookings_decision":      "$serverurl/api/bookings/modification-decision",
  "bookings_cancel":        "$serverurl/api/bookings/cancel",

  // ------------------- Notification & Chat ------------------------ //
  "notifications":          "$serverurl/api/notifications",
  "chat_list":              "$serverurl/api/conversations",
  "chat_messages":          "$serverurl/api/messages",
  "send_message":           "$serverurl/api/messages/send",
  "mark_read":              "$serverurl/api/messages/mark-as-read",
};