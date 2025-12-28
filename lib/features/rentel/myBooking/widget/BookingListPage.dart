import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:apartment_rental_system/features/rentel/myBooking/controller/incomingBookingController.dart';
import 'package:apartment_rental_system/features/rentel/myBooking/widget/bookingRequestCard.dart';

class BookingListPage<T extends BaseBookingController> extends StatefulWidget {
  const BookingListPage({super.key});

  @override
  State<BookingListPage<T>> createState() => _BookingListPageState<T>();
}

class _BookingListPageState<T extends BaseBookingController>
    extends State<BookingListPage<T>>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final controller = Get.find<T>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 20.h) {
      controller.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() {
      if (controller.isLoading.value && controller.list.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.list.isEmpty) {
        return _buildEmptyState();
      }

      return _buildBookingList();
    });
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      displacement: 12.h,
      edgeOffset: 12.h,
      onRefresh: () => controller.fetchData(isRefresh: true),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 60.h,
            child: Center(
              child: Text(
                "no_bookings_found".tr,
                style: TextStyle(fontSize: 15.sp, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingList() {
    return RefreshIndicator(
      displacement: 12.h,
      edgeOffset: 12.h,
      onRefresh: () => controller.fetchData(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        padding: EdgeInsets.only(top: kToolbarHeight + 15.h, bottom: 5.h),
        itemCount:
            controller.list.length + (controller.isLoadMore.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < controller.list.length) {
            return BookingRequestCard(booking: controller.list[index]);
          }
          return _buildLoadMoreIndicator();
        },
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
