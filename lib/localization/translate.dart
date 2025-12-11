import 'package:get/get.dart';

class Translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    "ar": {
      /// ------- virfiy password screen (settings) ------- ///
      'auth_password': 'كلمة المرور',
      'auth_password_msg': 'نحتاج كلمة المرور لحسابك للاستمرار.',
      'enter_password': 'أدخل كلمة المرور',
      'password_label': 'كلمة المرور',
      'send_btn': 'إرسال',
      'password_verified_success': 'تم التحقق من كلمة المرور بنجاح',
      'wrong_password': 'كلمة المرور خاطئة',
      'unexpected_error': 'حدث خطأ غير متوقع',
      // ------- edit email screen (settings) ------- ///
      'edit_email': 'تعديل البريد الإلكتروني',
      'edit_email_desc':
          'الآن يمكنك تغيير بريدك الإلكتروني، سنرسل رمز التحقق (OTP) للبريد الإلكتروني المُدخل.',
      'enter_new_email': 'أدخل البريد الإلكتروني الجديد',
      'new_email_label': 'البريد الإلكتروني الجديد',
      'save_btn': 'حفظ',
      // ------- language selection screen (settings) ------- ///
      'select_language': 'اختر اللغة',
      'English': 'الإنجليزية',
      'العربية': 'العربية',
      // ------- edit password screen (settings) ------- ///
      'edit_password': 'تعديل كلمة المرور',
      'change_password_desc': 'الآن يمكنك تغيير كلمة المرور الخاصة بك.',
      'new_password_hint': 'أدخل كلمة المرور الجديدة',
      'new_password_label': 'كلمة المرور الجديدة',
      'confirm_password_hint': 'أدخل تأكيد كلمة المرور',
      'confirm_password_label': 'تأكيد كلمة المرور',
      'password_mismatch': 'كلمة المرور وتأكيدها غير متطابقين',
      'password_updated_success': 'تم تحديث كلمة المرور بنجاح',
      'save': 'حفظ',
      // ------- edit phone screen (settings) ------- ///
      'edit_phone': 'تعديل الهاتف',
      'edit_phone_desc': 'الآن يمكنك تغيير رقم الهاتف الخاص بك.',
      'new_phone_hint': 'أدخل رقم الهاتف الجديد',
      'new_phone_label': 'رقم الهاتف الجديد',
      'phone_updated_success': 'تم تحديث رقم الهاتف بنجاح',

      /// ------- edit profile screen (settings) ------- ///
      'national_id': 'الهوية الوطنية',
      'upload_national_id': 'رفع صورة الهوية الوطنية',
      'edit_profile': 'تعديل الملف الشخصي',
      'new_first_name_hint': 'أدخل الاسم الأول الجديد',
      'new_first_name_label': 'الاسم الأول الجديد',
      'new_last_name_hint': 'أدخل الاسم الأخير الجديد',
      'new_last_name_label': 'الاسم الأخير الجديد',
      'dob_label': 'تاريخ الميلاد',

      'profile_updated_success': 'تم تحديث البيانات بنجاح',
      'no_changes_to_save': 'لا يوجد أي تغيير ليتم حفظه',

      /// ------- edit theme screen (settings) ------- ///
      'select_theme': 'اختر الوضع',
      'light_mode': 'الوضع الفاتح',
      'dark_mode': 'الوضع الداكن',
      // ------ settings screen ------- ///
      'settings': 'الإعدادات',
      'profile': 'الملف الشخصي',
      'edit_profile': 'تعديل البيانات الشخصية',
      'change_phone': 'تغيير رقم الهاتف',
      'change_email': 'تغيير البريد الإلكتروني',
      'security': 'الأمان',
      'change_password': 'تغيير كلمة المرور',
      'two_step_verification': 'التحقق بخطوتين',
      'app': 'التطبيق',
      'language': 'اللغة',
      'dark_mode': 'الوضع الليلي',
      'notifications': 'الإشعارات',
      'general': 'عام',
      'help_center': 'مركز المساعدة',
      'privacy_policy': 'سياسة الخصوصية',
      'logout': 'تسجيل خروج',
      // ---- Api Service -----///
      'no_internet': '📴 لا يوجد اتصال بالإنترنت',
      'timeout': '⏳ انتهت مدة الاتصال، حاول مجددًا',
      'token_not_found': '🔐 التوكن غير موجود',
      'unexpected_error': '❌ خطأ غير متوقع',
      // --- snack bar --- ///
      'Success': 'نجاح',
      'Error': 'خطأ',
      'Warning': 'تحذير',
    },
    "en": {
      /// ------- virfiy password screen (settings) ------- ///
      'auth_password': 'Auth Password',
      'auth_password_msg': 'We need your account password to continue.',
      'enter_password': 'Enter your Password',
      'password_label': 'Password',
      'send_btn': 'Send',
      'password_verified_success': 'Password verified successfully',
      'wrong_password': 'Wrong password',
      'unexpected_error': 'Unexpected error occurred',
      // ------- edit email screen (settings) ------- ///
      'edit_email': 'Edit Email',
      'edit_email_desc':
          'Now you can change your email address, we will send OTP for the entered email.',
      'enter_new_email': 'Enter your New Email',
      'email_updated_success': 'Email updated successfully',
      'new_email_label': 'New Email',
      'save_btn': 'Save',
      // ------- language selection screen (settings) ------- ///
      'select_language': 'Select Language',
      'English': 'English',
      'العربية': 'Arabic',
      // ------- edit password screen (settings) ------- ///
      'edit_password': 'Edit Password',
      'change_password_desc': 'Now you can change your password.',
      'new_password_hint': 'Enter your new password',
      'new_password_label': 'New Password',
      'confirm_password_hint': 'Enter your password confirmation',
      'confirm_password_label': 'Password Confirmation',
      'password_mismatch': 'Password and confirmation do not match',
      'password_updated_success': 'Password updated successfully',
      'save': 'Save',
      // ------- edit phone screen (settings) ------- ///
      'edit_phone': 'Edit Phone',
      'edit_phone_desc': 'Now you can change your phone number.',
      'new_phone_hint': 'Enter your new phone number',
      'new_phone_label': 'New Phone',
      'phone_updated_success': 'Phone updated successfully',

      /// ------- edit profile screen (settings) ------- ///
      'national_id': 'National ID',
      'upload_national_id': 'Upload National ID',
      'edit_profile': 'Edit Profile',
      'new_first_name_hint': 'Enter your new first name',
      'new_first_name_label': 'New First Name',
      'new_last_name_hint': 'Enter your new last name',
      'new_last_name_label': 'New Last Name',
      'dob_label': 'Date of Birth',

      'profile_updated_success': 'Profile updated successfully',
      'no_changes_to_save': 'No changes to save',

      /// ------- edit theme screen (settings) ------- ///
      'select_theme': 'Select Theme',
      'light_mode': 'Light Mode',
      'dark_mode': 'Dark Mode',
      // ------ settings screen ------- ///
      'settings': 'Settings',
      'profile': 'Profile',
      'edit_profile': 'Edit Profile',
      'change_phone': 'Change Phone',
      'change_email': 'Change Email',
      'security': 'Security',
      'change_password': 'Change Password',
      'two_step_verification': 'Two-step Verification',
      'app': 'App',
      'language': 'Language',
      'dark_mode': 'Dark Mode',
      'notifications': 'Notifications',
      'general': 'General',
      'help_center': 'Help Center',
      'privacy_policy': 'Privacy Policy',
      'logout': 'Logout',
      // ---- Api Service -----///
      'no_internet': 'No Internet connection',
      'timeout': 'Connection timed out, please try again',
      'token_not_found': 'Token not found',
      'unexpected_error': 'Unexpected error occurred',

      // --- snack bar  --- ///
      'Success': 'Success',
      'Error': 'Error',
      'Warning': 'Warning',
    },
  };
}
