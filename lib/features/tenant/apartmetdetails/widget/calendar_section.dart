// import 'package:apartment_rental_system/features/tenant/apartmetdetails/controller/apartmentDetailsController.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// import 'package:get/get.dart';

// class CalendarSection extends StatelessWidget {
//   final ApartmentDetailsControllerTest controller;
//   const CalendarSection({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('التواريخ المتاحة', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
//             const SizedBox(height: 12),
//             Obx(() => TableCalendar(
//                   firstDay: DateTime.now(),
//                   lastDay: DateTime.now().add(const Duration(days: 365)),
//                   focusedDay: controller.focusedDay.value,
//                   calendarFormat: controller.calendarFormat.value,
//                   onFormatChanged: (f) => controller.calendarFormat.value = f,
//                   onPageChanged: (d) => controller.focusedDay.value = d,
//                   calendarBuilders: CalendarBuilders(
//                     defaultBuilder: (ctx, day, focused) {
//                       final isBooked = controller.isDateBooked(day);
//                       return Container(
//                         margin: const EdgeInsets.all(2),
//                         decoration: BoxDecoration(
//                           color: isBooked ? Colors.red.shade50 : Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: isBooked ? Colors.red : Colors.grey.shade200, width: isBooked ? 2 : 1),
//                         ),
//                         child: Center(
//                           child: Text('${day.day}', style: TextStyle(color: isBooked ? Colors.red.shade700 : Colors.black)),
//                         ),
//                       );
//                     },
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
