import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/core/network/dio_client.dart';
import 'package:tech_app/core/utils/Time_Date.dart';
import 'package:tech_app/core/utils/snackbar_helper.dart';
import 'package:tech_app/provider/service_list_provider.dart';
import 'package:tech_app/services/AcceptRequest_Service.dart';
import 'package:tech_app/services/StartWork_Service.dart';
import 'package:tech_app/view/update_request_view.dart';
import 'package:tech_app/widgets/card/request_cart.dart';
import 'package:tech_app/widgets/inputs/primary_button.dart';
import 'package:tech_app/model/ServiceList _Model.dart';

class ServicerequestCart extends StatefulWidget {
  final Datum data; // 👈 Strong type

  const ServicerequestCart({super.key, required this.data});

  @override
  State<ServicerequestCart> createState() => _ServicerequestCartState();
}

class _ServicerequestCartState extends State<ServicerequestCart> {
  final AcceptrequestService _acceptrequestService = AcceptrequestService();
  final StartworkService _startwork = StartworkService();

  Future<void> acceptrequest({
    required String status,
    String? reason,
  }) async {
    try {
      final assignmentId = widget.data.id;
      final result = await _acceptrequestService.acceptrequest(
        assignmentId,
        status,
        reason,
      );

      SnackbarHelper.show(
        context,
        backgroundColor: AppColors.scoundry_clr,
        message: status == "accept" ? "Service Accepted" : "Service Rejected",
      );
  //              // 🔥 REFRESH SERVICE LIST API
  // ref.invalidate(serviceListProvider);
      context.pop(); // close screen if needed
    } catch (e) {
      SnackbarHelper.show(
        context,
        backgroundColor: Colors.red,
        message: e.toString(),
      );
    }
  }

  // ✅ Start Work
  Future<void> startwork() async {
    final userServiceId = widget.data.id;
    try {
      final result = await _startwork.fetchstartwork(userServiceId);
      SnackbarHelper.show(
        context,
        backgroundColor: AppColors.scoundry_clr,
        message: "Start Work",
      );
      context.pop();
    } catch (e) {
      SnackbarHelper.show(
        context,
        backgroundColor: Colors.red,
        message: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // CUSTOMER & SERVICE DETAILS
              if (widget.data.assignmentStatus != "in-progress" &&
                  widget.data.assignmentStatus != "completed") ...[
                _buildCustomerDetails(),
                const SizedBox(height: 20),
                _buildServiceDetails(),
              ],

              const SizedBox(height: 10),

              // ACTION BUTTONS
              if (widget.data.assignmentStatus == "pending") ...[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: PrimaryButton(
                    radius: 13,
                    height: 50,
                    Width: double.infinity,
                    color: AppColors.scoundry_clr,
                    onPressed: () {
                      acceptrequest(status: "accept");
                    },
                    text: "Accept",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: PrimaryButton(
                    radius: 13,
                    height: 50,
                    Width: double.infinity,
                    color: Colors.red,
                    onPressed: () {
                      _showRejectReasonSheet(context);
                    },
                    text: "Reject",
                  ),
                ),
              ],
              if (widget.data.assignmentStatus == "accepted") ...[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: PrimaryButton(
                    radius: 13,
                    height: 50,
                    Width: double.infinity,
                    color: AppColors.scoundry_clr,
                    onPressed: startwork,
                    text: "Start Work",
                  ),
                ),
              ],

              // COMPLETED SERVICE
              if (widget.data.assignmentStatus == "completed") ...[
                RequestCart(
                   userServiceId: widget.data.id,
                  clientname: widget.data.userId.basicInfo.fullName,
                  serviceRequestID: widget.data.serviceRequestId,
                  servicetype: widget.data.serviceId.name,
                  assignmentStatus: widget.data.assignmentStatus,
                  scheduleService: widget.data.scheduleService
                      .toIso8601String(),
                  createdAt: widget.data.createdAt.toIso8601String(),
                  feedback: widget.data.feedback ?? '',
                  payment: widget.data.payment,
                  media: widget.data.media,
                  assignments:
                      widget.data.technicianUserService?.assignments ?? [],
                ),
              ],

              // IN-PROGRESS OR ON-HOLD
              if (widget.data.assignmentStatus == "in-progress" ||
                  widget.data.assignmentStatus == "on-hold") ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: UpdateRequestView(
                    serviceRequestId: widget.data.assignmentStatus,
                    userServiceId: widget.data.id,
                  ),
                ),
              ],

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerDetails() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.scoundry_clr,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 34,
                  width: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.person, color: AppColors.scoundry_clr),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Customer Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _infoRow("Name", widget.data.userId.basicInfo.fullName),
                const Divider(),
                _infoRow("Email", widget.data.userId.basicInfo.email),
                const Divider(),
                _infoRow(
                  "Phone",
                  "+973 ${widget.data.userId.basicInfo.mobileNumber}",
                ),
                const Divider(),
                _infoRow(
                  "Address",
                  "building ${widget.data.address.building}, floor ${widget.data.address.floor}, aptNo ${widget.data.address.aptNo}",
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Location",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Container(
                      height: 90,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(196, 189, 185, 185),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                _infoRow("Distance:", "7km"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetails() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.scoundry_clr,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 34,
                  width: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(Icons.person, color: AppColors.scoundry_clr),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Service Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _infoRow("Service Type", widget.data.serviceId.name),
                const Divider(),
                _infoRow("Description", widget.data.feedback ?? ""),
                const Divider(),
                _infoRow("View Media", "Tap to view", media: widget.data.media),
                const Divider(),
                _infoRow(
                  "Date Required",
                  formatDateForUI(widget.data.scheduleService),
                ),
                const Divider(),
                _infoRow("Time Window", "10:00AM - 12:00AM"),
                const Divider(),
                _infoRow(
                  "Date Created",
                  formatDateForUI(widget.data.createdAt),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {List<String>? media}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.lightgray_clr, fontSize: 12),
          ),
          Expanded(
            child: media != null && media.isNotEmpty
                ? InkWell(
                    onTap: () {
                      _showMediaDialog(context, media);
                    },
                    child: Text(
                      value,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : Text(
                    value,
                    textAlign: TextAlign.right,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Media Dialog
  void _showMediaDialog(BuildContext context, List<String> mediaList) {
    final images = mediaList
        .where(
          (media) =>
              media.endsWith(".jpg") ||
              media.endsWith(".png") ||
              media.endsWith(".jpeg") ||
              media.endsWith(".webp"),
        )
        .toList();

    final otherMedia = mediaList
        .where(
          (media) =>
              !media.endsWith(".jpg") &&
              !media.endsWith(".png") &&
              !media.endsWith(".jpeg") &&
              !media.endsWith(".webp"),
        )
        .toList();

    final PageController _pageController = PageController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Media Files",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                if (images.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            final imgUrl =
                                "${ImageBaseUrl.baseUrl}/${images[index].trim()}";
                            return CachedNetworkImage(
                              imageUrl: imgUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const SizedBox(
                                height: 100,
                                width: 100,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.broken_image, size: 50),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: images.length,
                        effect: const WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 6,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                if (otherMedia.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: otherMedia.length,
                      itemBuilder: (context, index) {
                        final media = otherMedia[index];
                        return ListTile(
                          leading: const Icon(Icons.play_circle_fill),
                          title: Text(media.split('/').last),
                          onTap: () {
                            // TODO: Handle video/audio playback
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Reject Reason Bottom Sheet
  void _showRejectReasonSheet(BuildContext context) {
    final TextEditingController reasonController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Reject Reason",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Why are you rejecting this request?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButton(
                    radius: 15,
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Cancel",
                    Width: 133,
                  ),
                  PrimaryButton(
                    radius: 15,
                    color: Colors.red,
                    onPressed: () {
                      final reason = reasonController.text.trim();
                      if (reason.isEmpty) {
                        SnackbarHelper.show(
                          context,
                          backgroundColor: Colors.red,
                          message: "Please enter a reason",
                        );
                        return;
                      }
                      debugPrint("reason $reason");
                      acceptrequest(
                        status: "reject",
                        reason: reason,
                      ); // pass reason only for reject
                      Navigator.pop(context);
                    },
                    text: "Save",
                    Width: 133,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
