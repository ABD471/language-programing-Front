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
      "field_required": "هذا الحقل مطلوب",
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
      // Location Keys
      'detecting_location': 'جاري تحديد الموقع...',
      'location_service_disabled': 'الموقع غير مفعل',
      'location_permission_denied': 'تم رفض الإذن',
      'location_permission_forever': 'الإذن مرفوض دائمًا',
      'unknown_location': 'موقع غير معروف',
      'location_error': 'خطأ في تحديد الموقع',
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
      "error_title": "خطأ",
      "profile_and_id_required": "يجب اختيار صورتي البروفايل والهوية",

      'Success': 'نجاح',
      'Error': 'خطأ',
      'Warning': 'تحذير',
      // ---- register Account --///
      "create_account": "إنشاء حساب",
      "phone": "رقم الهاتف",
      "email": "البريد الإلكتروني",
      "password": "كلمة المرور",
      "confirm_password": "تأكيد كلمة المرور",
      "phone_hint": "أدخل رقم الهاتف",
      "email_hint": "أدخل بريدك الإلكتروني",
      "password_hint": "أدخل كلمة المرور",
      "confirm_password_hint": "أعد إدخال كلمة المرور",
      "signup": "تسجيل",
      "login": "تسجيل الدخول",
      "already_have_account": "هل لديك حساب بالفعل؟",
      // --- forgetpassword --- //
      "forgot_password": "نسيت كلمة المرور؟",
      "forgot_password_description":
          "أدخل البريد الإلكتروني أو رقم الهاتف لاستعادة كلمة المرور.",
      "email_or_phone": "البريد الإلكتروني أو الهاتف",
      "send": "إرسال",
      // controller Login //
      "dialog_success_title": "نجاح",
      "dialog_success_message_login":
          "تم إرسال رمز التحقق إلى بريدك الإلكتروني. يرجى التحقق لإكمال تسجيل الدخول.",

      "dialog_error_title": "خطأ",
      "dialog_invalid_phone_or_password":
          "رقم الهاتف أو كلمة المرور غير صحيحة.",
      "dialog_email_not_verified":
          "بريدك الإلكتروني غير مُفعل. يرجى تفعيله قبل تسجيل الدخول.",
      "dialog_account_not_approved":
          "حسابك غير مُعتمد بعد من قبل الإدارة. يرجى الانتظار والمحاولة لاحقاً.",

      "dialog_unexpected_title": "خطأ غير متوقع",
      "dialog_unexpected_code": "رمز الخطأ:",

      "dialog_exception_title": "حدث خطأ",
      "dialog_exception_message": "حدث خطأ أثناء العملية:",

      "dialog_confirm": "موافق",
      // login screen //
      "login_welcome":
          "مرحبًا بعودتك! يسعدنا رؤيتك مرة أخرى، الرجاء تسجيل الدخول للمتابعة.",

      "Login": "تسجيل الدخول",
      "phone": "رقم الهاتف",
      "phone_hint": "أدخل رقم الهاتف",
      "password": "كلمة المرور",
      "password_hint": "أدخل كلمة المرور",
      "forgot_password": "نسيت كلمة المرور؟",
      "dont_have_account": "ليس لديك حساب؟",
      "create_new_account": "إنشاء حساب جديد",
      "login_button": "تسجيل الدخول",
      // Register Personal Info
      'create_profile': 'إنشاء الملف الشخصي',
      "chats_title": "المحادثات",
      "no_chats": "لا توجد محادثات حالياً",
      "yesterday": "أمس",
      "user": "المستخدم",
      'first_name': 'الاسم الأول',
      'first_name_hint': 'أدخل الاسم الأول',
      'last_name': 'الاسم الأخير',
      'last_name_hint': 'أدخل الاسم الأخير',
      'dob': 'تاريخ الميلاد',
      'national_id': 'الهوية الوطنية',
      'upload_national_id': 'رفع صورة الهوية',
      'upload_profile_image': 'رفع صورة الملف الشخصي',
      'save_profile': 'حفظ البيانات',
      // controller registerAcount////
      "success": "نجاح",
      "otp_resend": "تم إرسال رمز التحقق مرة أخرى إلى بريدك الإلكتروني.",
      "account_created_success_otp_sent":
          "تم إنشاء الحساب بنجاح. تم إرسال رمز التحقق إلى بريدك الإلكتروني.",

      "phone_and_email_exist": "رقم الهاتف والبريد الإلكتروني مسجلان بالفعل.",
      "email_exist": "هذا البريد الإلكتروني مسجل بالفعل.",
      "phone_exist": "رقم الهاتف هذا مسجل بالفعل.",
      "phone_invalid_format": "صيغة رقم الهاتف غير صالحة.",
      "password_min_8": "يجب أن تتكون كلمة المرور من 8 أحرف على الأقل.",
      // controller forgetpassword//
      "otp_sent_password_reset":
          "تم إرسال رمز التحقق لإعادة تعيين كلمة المرور.",
      "user_not_found": "لا يوجد مستخدم مسجل بهذا الرقم.",
      "phone_not_exist": "رقم الهاتف غير موجود في النظام.",

      "new_password_title": "تغيير كلمة المرور",
      "new_password_description": "الرجاء إدخال كلمة المرور الجديدة لتحديثها.",
      // screen new PAssword ///
      "new_password": "كلمة المرور الجديدة",
      "new_password_hint": "أدخل كلمة المرور الجديدة",
      "new_password_empty": "يرجى إدخال كلمة المرور",
      "new_password_short": "كلمة المرور قصيرة جدًا",

      "confirm_password": "تأكيد كلمة المرور",
      "confirm_password_hint": "أدخل تأكيد كلمة المرور",
      "confirm_password_empty": "يرجى تأكيد كلمة المرور",
      "password_not_match": "كلمتا المرور غير متطابقتين",
      "online": "متصل",
      "offline": "غير متصل",
      "type_message_hint": "اكتب رسالتك...",
      "save_new_password": "تحديث كلمة المرور",
      "add_profile_photo": "إضافة صورة للملف الشخصي",
      // controller newpassword //
      "newpass_change_title": "تم التحديث",
      "newpass_change_message": "تم تغيير كلمة المرور بنجاح.",

      "newpass_validation_error": "البيانات المدخلة غير صالحة.",

      "newpass_unexpected_message":
          "استجابة غير متوقعة من الخادم. الكود: %{code}",
      // controller verfiy otp email //
      "otp_verified_title": "تم التحقق من الرمز",
      "otp_verified_message": "تم التحقق بنجاح من رمز التفعيل",
      "otp_wrong_or_expired": "OTP غير صحيح أو منتهي الصلاحية",
      "account_not_verified": "حسابك غير مفعل بعد",
      "otp_resend_success": "تم إرسال رمز التحقق من جديد",
      "please_wait_resend": "انتظر قليلاً قبل إعادة الإرسال",
      "enter_all_digits": "أدخل جميع أرقام التحقق",

      //screen verfiy otp email //
      "verify_otp_title": "رمز التحقق",
      "otp_screen_title": "تأكيد الحساب",
      "otp_screen_subtitle": "أدخل رمز التحقق المرسل إلى رقم هاتفك",
      "verify_button": "تأكيد",
      "resend_otp": "إعادة إرسال",
      "resend_available": "يمكنك إعادة الإرسال الآن",
      "resend_after": "أعد الإرسال بعد",
      "change_phone_number": "تغيير رقم الهاتف",

      // scree onboarding //
      'skip': 'تخطي',
      'next': 'التالي',
      'start_now': 'ابدأ الآن',

      // Onboarding texts
      'onboard_title_1': 'ابحث عن شقتك بسهولة',
      'onboard_desc_1': 'اكتشف أفضل الشقق المتاحة بالقرب منك وبأسعار مناسبة',

      'onboard_title_2': 'احجز بثوانٍ',
      'onboard_desc_2': 'عملية حجز سريعة وآمنة بدون أي تعقيد',

      'onboard_title_3': 'إدارة كاملة',
      'onboard_desc_3': 'تابع حجوزاتك ودفعاتك من مكان واحد',
      "empty": "فارغ",
      "format": "يجب ان يكون مثل 0911111111",
      "passwordmin": "يجب ان تكون اكبر من 8 احرف ",
      "passwordmax": "يجب ان تكون اصفر من 25 حرف ",

      // -------------------------------------------------------------------------------------------------------------------------------//
      // -------------------------------------------------------------------------------------------------------------------------------//
      // -------------------------------------rentel---------------------------------------------------------------------//
      // -------------------------------------------------------------------------------------------------------------------------------//
      // -------------------------------------------------------------------------------------------------------------------------------//
      // -------------------------------------------------------------------------------------------------------------------------------//
      //   ----------------------add Aparment ------------------------//
      // العناوين الرئيسية
      'add_apartment': 'إضافة شقة جديدة',
      'edit_apartment': 'تعديل بيانات الشقة',

      // خطوات الـ Stepper
      'basics': 'الأساسيات',
      'details': 'التفاصيل',
      'images': 'الصور',

      // أسماء الحقول (Labels)
      'title_label': 'عنوان الإعلان',
      'desc_label': 'وصف الشقة',
      'rooms': 'الغرف',
      'bathrooms': 'الحمامات',
      'area': 'المساحة (م²)',
      'price': 'السعر شهرياً',

      // أزرار التحكم
      'next': 'المتابعة',
      'previous': 'السابق',
      'submit': 'إرسال البيانات',
      'save_changes': 'حفظ التعديلات',
      'add_images_btn': 'إضافة صور من الاستوديو',
      'choose_extra_images': 'اختيار صور إضافية',

      // الرسائل والتنبيهات
      'no_images_selected': 'لم يتم اختيار صور بعد',
      'current_images_server': 'الصور الحالية (على السيرفر):',
      'add_new_images': 'إضافة صور جديدة:',
      'uploading_msg': 'جاري رفع البيانات والصور...',
      'updating_msg': 'جاري تحديث البيانات...',
      'success_add': 'تمت إضافة العقار بنجاح',
      'success_update': 'تم تحديث البيانات بنجاح',
      'error_msg': 'حدث خطأ ما، يرجى المحاولة لاحقاً',
      'fill_required': 'يرجى ملء الحقول الأساسية وإضافة صورة واحدة على الأقل',
      'success_title': 'عملية ناجحة',
      'filter': 'تصفية',
      'search_hint': 'ابحث عن مدينة أو منطقة...',
      'no_results': 'لم نجد أي شقق تطابق بحثك',
      'reset_filters': 'إعادة ضبط الفلاتر',
      'error': 'خطأ',
      'warning': 'تنبيه',

      // رسائل جلب البيانات (Fetch)
      'fetch_failed': 'عذراً، فشل جلب بيانات الشقق من السيرفر',

      // رسائل الحذف (Delete)
      'delete_success': 'تم حذف الشقة من القائمة بنجاح',
      'delete_failed': 'حدث خطأ أثناء محاولة الحذف، يرجى المحاولة لاحقاً',

      // رسائل الإضافة والتعديل (Add & Edit)
      'update_success_msg': 'تم تحديث بيانات الشقة بنجاح',
      'update_failed_msg': 'فشل تحديث البيانات، تأكد من الاتصال',
      'connection_error': 'لا يوجد اتصال بالإنترنت أو السيرفر غير متاح',
      //   ----------------------add Aparment ------------------------//
      'my_apartments_title': 'عقاراتي المعروضة',
      'add_new': 'إضافة شقة',
      'no_apartments_msg': 'لا يوجد لديك شقق معروضة حالياً',
      'no_title': 'بدون عنوان',
      'confirm_delete_title': 'تأكيد الحذف',
      'confirm_delete_msg': 'هل أنت متأكد من حذف هذه الشقة نهائياً؟',
      'yes': 'نعم، احذف',
      'cancel': 'إلغاء',

      'location': 'الموقع',

      'select_city': 'اختر المدينة',
      'tap_on_map_hint': 'انقر على الخريطة لتحديد مكان الشقة بدقة',
      'booking_requests': 'طلبات الحجز',
      'new_requests': 'الجديدة',
      'confirmed_requests': 'المقبولة',
      'cancelled_requests': 'الملغية',
      'no_bookings_found': 'لا توجد حجوزات في هذه القائمة',
      'accept_booking': 'تأكيد الحجز',
      'cancel_booking': 'رفض الطلب',
      ""
              'confirm_accept_msg':
          'هل أنت متأكد من رغبتك في قبول هذا الطلب؟',
      'confirm_cancel_msg':
          'هل أنت متأكد من رغبتك في رفض هذا الحجز؟ لا يمكن التراجع عن هذا الإجراء.',
      'yes_confirm': 'نعم، تأكيد',
      'yes_reject': 'نعم، رفض',
      "reject": "رفض",
      "notifications_empty_hint":
          "ستظهر هنا التنبيهات المتعلقة بحسابك وعقاراتك بمجرد وصولها",
      'booking_accepted': 'تم قبول الحجز بنجاح',
      'booking_rejected': 'تم رفض الطلب',
      "owner_role": "مؤجر",
      "tenant_role": "مستأجر",
      "select_role": "اختر الدور",
      "role_required_error": "يرجى اختيار نوع الحساب",
      "check_in": "تسجيل الوصول",
      "check_out": "تسجيل المغادرة",
      "duration": "المدة",
      "nights": "ليالي",
      'notifications_title': 'مركز الإشعارات',
      'no_notifications': 'لا توجد إشعارات حالياً',
      'error_fetching_notifications': 'عذراً، تعذر جلب الإشعارات',
      'error_deleting_notification': 'حدث خطأ أثناء حذف الإشعار',
      'error_title': 'تنبيه',
      'delete_confirm': 'هل أنت متأكد من الحذف؟',
      'mark_as_read': 'تم التحديد كمقروء',
      'swipe_to_delete': 'اسحب للحذف',
      'just_now': 'الآن',

      'price_unit': 'دولار',

      'image_format_info': 'JPG, PNG (بحد أقصى 5 ميجابايت)',

      'no_address': 'الموقع غير محدد',
      'nav_my_apartments': 'عقاراتي',
      'nav_requests': 'الطلبات',
      'nav_chats': 'المحادثات',
      'nav_profile': 'حسابي',
      "no_internet_title": "لا يوجد اتصال بالإنترنت",
      "no_internet_msg": "يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.",
      "retry": "إعادة المحاولة",
      "app_name": "بيت الأحلام",
      "splash_subtitle": "ابحث، احجز، وعيش أحلامك",

      'error_marking_notification_read': 'فشل تحديث حالة الإشعار',
      'search_hint_detailed': 'ابحث عن مدينة، منطقة أو ميزة...',
      'no_title': 'بدون عنوان',
      'currency': 'ل.س',
      'per_night': 'ليلة',
      'unknown_location': 'موقع غير معروف',
      'no_results_found': 'لا توجد نتائج مطابقة لبحثك',
      'all': 'الكل',
      "welcome_user": " مرحباً، @name 👋",
      "search_next_apartment": "ابحث عن شقتك القادمة",
      "your_location": "موقعك",
      "nav_explore": "اكتشف",
      "nav_bookings": "حجوزاتي",
      'from_date': 'من',
      'to_date': 'إلى',
      'apartment_details': 'تفاصيل الشقة',
      'price': 'السعر',
      'currency': 'ل.س',
      'bedrooms': 'غرف النوم',
      'bathrooms': 'الحمامات',
      'area': 'المساحة',
      'sqm': 'م²',
      'cancel_booking': 'إلغاء الحجز',
      'edit_booking': 'تعديل الحجز',
      'my_bookings': 'حجوزاتي',
      'pending_tab': 'قيد الانتظار',
      'completed_tab': 'مكتملة',
      'cancelled_tab': 'ملغاة',
      "rate": "تقييم",
      "view_details": "عرض التفاصيل",
      "pull_to_refresh": "اسحب للتحديث",
      "edit_booking_date": "تعديل تاريخ الحجز",
      "start_date": "تاريخ البداية",
      "end_date": "تاريخ النهاية",
      "status_cancelled": "ملغاة",
      "status_completed": "مكتملة",
      "status_pending": "بانتظار الموافقة ",
      "current_tab": "الحالية",
      "previous_tab": "السابقة",
    },
    "en": {
      "current_tab": "Current",
      "previous_tab": "Previous",
      "status_cancelled": "Cancelled",
      "status_completed": "Completed",
      "status_pending": "Pending",
      "edit_booking_date": "Edit Booking Date",
      "start_date": "Start Date",
      "end_date": " End Date",
      "pull_to_refresh": "Pull down to refresh",
      "rate": "Rate ",
      "view_details": "View Details",
      'my_bookings': 'My Bookings',
      'pending_tab': 'Pending',
      'completed_tab': 'Completed',
      'cancelled_tab': 'Cancelled',
      'from_date': 'From',
      'to_date': 'To',
      'apartment_details': 'Apartment Details',
      'price': 'Price',
      'currency': 'SYP',
      'bedrooms': 'Bedrooms',
      'bathrooms': 'Bathrooms',
      'area': 'Area',
      'sqm': 'm²',
      'cancel_booking': 'Cancel Booking',
      'edit_booking': 'Edit Booking',
      "nav_explore": "Explore",
      "nav_bookings": "My Bookings",
      "welcome_user": "Welcome, @name 👋",
      "search_next_apartment": "Find your next apartment",
      "your_location": "Your location",
      'all': 'All',
      'no_results_found': 'No results found for your search',
      'no_title': 'No Title',
      'currency': 'SYP',
      'per_night': 'night',
      'unknown_location': 'Unknown Location',
      'search_hint_detailed': 'Search for city, area or feature...',
      'error_marking_notification_read': 'Failed to update notification status',
      "splash_subtitle": "Search, Book, Live Your Dream",
      "app_name": "Dream House",
      "no_internet_title": "Oops, No Connection!",
      "no_internet_msg": "Please check your internet connection and try again.",
      "retry": "Retry",

      /// ------- virfiy password screen (settings) ------- ///
      'auth_password': 'Auth Password',
      'auth_password_msg': 'We need your account password to continue.',
      'enter_password': 'Enter your Password',
      'password_label': 'Password',
      'send_btn': 'Send',
      'password_verified_success': 'Password verified successfully',
      'wrong_password': 'Wrong password',
      'unexpected_error': 'Unexpected error occurred',
      "role_required_error": "Please select account type",
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
      // Location Keys
      'detecting_location': 'Detecting location...',
      'location_service_disabled': 'Location service disabled',
      'location_permission_denied': 'Permission denied',
      'location_permission_forever': 'Permission denied forever',
      'unknown_location': 'Unknown location',
      'location_error': 'Error detecting location',
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
      'filter': 'Filter',
      'search_hint': 'Search for city or area...',
      'no_results': 'No apartments match your search',
      'reset_filters': 'Reset Filters',
      'timeout': 'Connection timed out, please try again',
      'token_not_found': 'Token not found',
      'unexpected_error': 'Unexpected error occurred',
      "online": "Online",
      "offline": "Offline",
      "type_message_hint": "Type your message...",
      // --- snack bar  --- ///
      'Success': 'Success',
      "error_title": "Error",
      "profile_and_id_required":
          "You must select both the profile picture and the ID image",

      'Error': 'Error',
      'Warning': 'Warning',
      // --- register Account ----///
      "create_account": "Create Account",
      "phone": "Phone Number",
      "email": "Email",
      "password": "Password",
      "yesterday": "Yesterday",
      "user": "User",
      "no_chats": "No chats available",
      "confirm_password": "Confirm Password",

      "phone_hint": "Enter phone number",
      "email_hint": "Enter your email",
      "password_hint": "Enter your password",
      "confirm_password_hint": "Re-enter your password",

      "signup": "Sign Up",
      "login": "Login",
      "already_have_account": "Already have an account?",
      // --- forgetPAssword --//
      "forgot_password": "Forgot Password?",
      "forgot_password_description":
          "Enter your email or phone number to reset your password.",
      "email_or_phone": "Email or Phone",
      "send": "Send",
      // controller login //
      "dialog_success_title": "Success",
      "dialog_success_message_login":
          "A verification code has been sent to your email. Please verify to complete login.",

      "dialog_error_title": "Error",
      "dialog_invalid_phone_or_password": "Invalid phone or password.",
      "dialog_email_not_verified":
          "Your email is not verified. Please verify before logging in.",
      "dialog_account_not_approved":
          "Your account is not approved yet by admin. Please wait and try again later.",

      "dialog_unexpected_title": "Unexpected Error",
      "notifications_empty_hint":
          "Updates about your account and properties will appear here",
      "dialog_unexpected_code": "Error Code:",

      "dialog_exception_title": "An Error Occurred",
      "dialog_exception_message": "An error occurred during the process:",

      "dialog_confirm": "OK",

      // login screen //
      "Login": "Login",
      "phone": "Phone Number",
      "phone_hint": "Enter phone number",
      "password": "Password",
      "password_hint": "Enter your password",
      "forgot_password": "Forgot Password?",
      "dont_have_account": "Don't have an account?",
      "create_new_account": "Create new account",
      "select_role": "Select Role",
      "tenant_role": "Tenant",
      "owner_role": "Rental",
      "login_button": "Login",
      "login_welcome":
          "Welcome back! We're happy to see you again. Please log in to continue.",
      // Register Personal Info
      'create_profile': 'Create Profile',
      'first_name': 'First Name',
      'first_name_hint': 'Enter first name',
      'last_name': 'Last Name',
      'last_name_hint': 'Enter last name',
      'dob': 'Date of Birth',
      "add_profile_photo": "Add Profile Photo",
      'national_id': 'National ID',
      'upload_national_id': 'Upload National ID',
      'upload_profile_image': 'Upload Profile Image',
      'save_profile': 'Save Profile',
      // controller registerAccount //
      "success": "Success",
      "otp_resend": "A verification code has been resent to your email.",
      "account_created_success_otp_sent":
          "Account created successfully. A verification code has been sent to your email.",

      "phone_and_email_exist": "Phone number and email are already registered.",
      "email_exist": "This email is already registered.",
      "phone_exist": "This phone number is already registered.",
      "phone_invalid_format": "Invalid phone number format.",
      "password_min_8": "Password must be at least 8 characters.",
      // controller forgetpassword//
      "otp_sent_password_reset":
          "A verification code has been sent to reset your password.",
      "user_not_found": "No user found with this phone number.",
      "phone_not_exist": "This phone number does not exist in our system.",
      // screen new PAssword ///
      "new_password_title": "Change Password",
      "new_password_description":
          "Please enter your new password to update it.",

      "new_password": "New Password",
      "new_password_hint": "Enter new password",
      "new_password_empty": "Please enter the new password",
      "new_password_short": "Password is too short",

      "confirm_password": "Confirm Password",
      "confirm_password_hint": "Enter password confirmation",
      "confirm_password_empty": "Please confirm the password",
      "password_not_match": "Passwords do not match",

      "save_new_password": "Save Password",
      // controller newpassword //
      "newpass_change_title": "Password Updated",
      "newpass_change_message": "Your password has been updated successfully.",

      "newpass_validation_error": "The provided data is invalid.",

      "newpass_unexpected_message": "Unexpected server response. Code: %{code}",
      // controller verfiy otp email //
      "otp_verified_title": "OTP Verified",
      "otp_verified_message":
          "The verification code has been successfully confirmed.",
      "otp_wrong_or_expired": "Invalid or expired OTP",
      "account_not_verified": "Your account is not verified yet",
      "otp_resend_success": "OTP has been resent successfully",
      "please_wait_resend": "Please wait before resending",
      "enter_all_digits": "Enter all OTP digits",
      // Screen  verify otp email //
      "verify_otp_title": "Verification Code",
      "otp_screen_title": "Account Verification",
      "otp_screen_subtitle": "Enter the verification code sent to your phone",
      "verify_button": "Verify",
      "resend_otp": "Resend",
      "resend_available": "You can resend now",
      "resend_after": "Resend after",
      "change_phone_number": "Change phone number",
      // screen onboarding //
      'skip': 'Skip',
      'next': 'Next',
      'start_now': 'Start Now',

      'onboard_title_1': 'Find your apartment easily',
      'onboard_desc_1':
          'Discover the best apartments near you at affordable prices',

      'onboard_title_2': 'Book in seconds',
      'onboard_desc_2': 'Fast and secure booking process with no complications',

      'onboard_title_3': 'Full management',
      'onboard_desc_3': 'Manage your bookings and payments in one place',
      // valdited //
      "empty": "empty",
      "format": "should be example 0911111111",
      "passwordmin": " should be greter than 8 char",
      "passwordmax": "should be less than 25 char ",

      // ---------------------------------------------------------------------------------------------------------------//
      // ---------------------------------------------------------------------------------------------------------------//
      // ---------------------------------------------------------------------------------------------------------------//
      // ---------------------------                   rentel app                   ----------------------------------------------------------//
      // ---------------------------------------------------------------------------------------------------------------//
      // ---------------------------------------------------------------------------------------------------------------//
      // ---------------------------------------------------------------------------------------------------------------//
      // ---------------------------------------------------------------------------------------------------------------//
      // ---------------add aparment ------------------------//
      'add_apartment': 'Add New Apartment',
      'edit_apartment': 'Edit Apartment Details',
      'basics': 'Basics',
      'details': 'Details',
      'images': 'Images',
      'title_label': 'Listing Title',
      'desc_label': 'Description',
      'rooms': 'Bedrooms',
      'bathrooms': 'Bathrooms',
      'area': 'Area (m²)',
      "field_required": "This field is required",
      'price': 'Monthly Price',
      'next': 'Continue',
      'previous': 'Back',
      'submit': 'Submit Data',
      'save_changes': 'Save Changes',
      'add_images_btn': 'Add Images from Gallery',
      'choose_extra_images': 'Pick Extra Images',
      'no_images_selected': 'No images selected yet',
      'current_images_server': 'Current Images (on server):',
      'add_new_images': 'Add New Images:',
      'uploading_msg': 'Uploading data and images...',
      'updating_msg': 'Updating data...',
      'success_add': 'Apartment added successfully',
      'success_update': 'Data updated successfully',
      'error_msg': 'Something went wrong, please try again',
      'fill_required': 'Please fill required fields and add at least one image',
      // General
      'success_title': 'Success',
      'error': 'Error',
      'warning': 'Warning',

      // Fetching Data
      'fetch_failed': 'Sorry, failed to fetch apartments from server',

      // Deletion
      'delete_success': 'Apartment deleted successfully',
      'delete_failed': 'Error occurred while deleting, please try again',

      // Add & Edit Actions
      'update_success_msg': 'Apartment details updated successfully',
      'update_failed_msg': 'Failed to update details, please check connection',

      'connection_error': 'No internet connection or server is unreachable',
      'my_apartments_title': 'My Listed Properties',
      'add_new': 'Add Apartment',
      'no_apartments_msg': 'You have no listed apartments yet',
      'no_title': 'No Title',
      'confirm_delete_title': 'Confirm Delete',
      'confirm_delete_msg':
          'Are you sure you want to delete this apartment permanently?',
      'yes': 'Yes, Delete',
      'cancel': 'Cancel',
      'tap_on_map_hint': 'Tap on the map to set exact location',
      'select_city': 'Select City', 'location': 'Location',
      'booking_requests': 'Booking Requests',
      'new_requests': 'New',
      'confirmed_requests': 'Confirmed',
      'cancelled_requests': 'Cancelled',
      'no_bookings_found': 'No bookings found in this list',
      'accept_booking': 'Confirm Booking',
      'cancel_booking': 'Reject Request',
      'confirm_accept_msg': 'Are you sure you want to accept this request?',
      'confirm_cancel_msg':
          'Are you sure you want to reject this booking? This action cannot be undone.',
      'yes_confirm': 'Yes, Confirm',
      'yes_reject': 'Yes, Reject',

      'booking_accepted': 'Booking accepted successfully',
      'booking_rejected': 'Request has been rejected',
      "reject": "Reject",
      "check_in": "Check-in",
      "check_out": "Check-out",
      "duration": "Duration",
      "nights": "nights",
      'notifications_title': 'Notification Center',
      'no_notifications': 'No notifications yet',
      'error_fetching_notifications': 'Sorry, could not fetch notifications',
      'error_deleting_notification':
          'An error occurred while deleting the notification',
      "chats_title": "Chats",
      'delete_confirm': 'Are you sure you want to delete?',
      'mark_as_read': 'Marked as read',
      'swipe_to_delete': 'Swipe to delete',
      'just_now': 'Just now',

      'price_unit': 'USD',

      'update': 'Update',

      'image_format_info': 'JPG, PNG (Max 2MB)',

      'no_address': 'No Address',
      'nav_my_apartments': 'My Properties',
      'nav_requests': 'Requests',
      'nav_chats': 'Chats',
      'nav_profile': 'Profile',
    },
  };
}
