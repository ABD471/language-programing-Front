final String serverurl = "http://192.168.1.233:80";
final urlClient = {
  "registerAccount": '$serverurl/api/auth/register',
  "login": '$serverurl/api/auth/login',
  "logout": '$serverurl/api/logout',
  "otpRegister": "$serverurl/api/verify-otp",
  "resetpassword": "$serverurl/api/auth/password/reset/confirm",
  "forgetpassword": "$serverurl/api/auth/password/reset/request",

  ///----- Profile ----- ///
  "updateProfile": '$serverurl/api/profile/update',
  "getProfile": '$serverurl/api/profile/show',
  "getpictureProfile": '$serverurl/api/profile/pictureFile',

  "updateEmail": '$serverurl/api/auth/update-email',
  "updatePhone": '$serverurl/api/auth/update-phone',
  "updatePassword": '$serverurl/api/auth/update-password',
  "verifyPassword": '$serverurl/api/auth/check-password',
  "getSetting": '$serverurl/api/setting/show',
  "updateSetting": '$serverurl/api/setting/update',
};
