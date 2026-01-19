// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:tech_app/core/constants/app_colors.dart';
// import 'package:tech_app/core/network/dio_client.dart';
// import 'package:tech_app/model/ServiceList%20_Model.dart';

// class RequestCart extends StatelessWidget {
//   final String clientname;
//   final String servicetype;
//   final String assignmentStatus;
//   final String scheduleService;
//   final String createdAt;
//   final String feedback;
//   final String serviceRequestID;
//   final int payment;
//   final List<Assignment> assignments;
//   const RequestCart({
//     super.key,
//     required this.clientname,
//     required this.servicetype,
//     required this.assignmentStatus,
//     required this.scheduleService,
//     required this.createdAt,
//     required this.feedback,
//     required this.serviceRequestID,
//     required this.assignments,
//     required this.payment,
//   });

//   // Widget _infoRow(String label, String value) {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(vertical: 6),
//   //     child: Row(
//   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //       children: [
//   //         Text(
//   //           label,
//   //           style: TextStyle(color: AppColors.lightgray_clr, fontSize: 12),
//   //         ),
//   //         Text(
//   //           value,
//   //           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   Widget _infospareRow(String lable, String value, String amount) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(lable),
//               Row(
//                 children: [Text("Qty:"), const SizedBox(width: 5), Text(value)],
//               ),
//             ],
//           ),
//           Text(amount),
//         ],
//       ),
//     );
//   }

//   String formatDate(String isoDate) {
//     final dateTime = DateTime.parse(isoDate);
//     return DateFormat('MMMM d, yyyy').format(dateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final requestMedia = assignments.expand((a) => a.media).toList();
//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 6,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 55,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: AppColors.primary_clr,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: 34,
//                       width: 34,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                       ),
//                       child: Icon(
//                         Icons.receipt_long,
//                         size: 18,
//                         color: AppColors.primary_clr,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: Text(
//                         "Request Information",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     _infoRow(context, "Request ID", serviceRequestID),
//                     const Divider(),
//                     _infoRow(context, "Service Type", servicetype),
//                     const Divider(),
//                     _infoRow(context, "Status", assignmentStatus),
//                     const Divider(),
//                     _infoRow(context, "Client Name", clientname),
//                     const Divider(),
//                     _infoRow(
//                       context,
//                       "Scheduled For",
//                       formatDate(scheduleService),
//                     ),
//                     const Divider(),
//                     _infoRow(context, "Created On", formatDate(createdAt)),
//                     const Divider(),
//                     _infoRow(
//                       context,
//                       " View Fixed Media",
//                       "Tap to view",
//                       media: requestMedia,
//                     ),
//                     const Divider(),
//                     // Description
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Description",
//                         style: TextStyle(
//                           color: AppColors.lightgray_clr,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(feedback, style: TextStyle(fontSize: 14)),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 20),
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: assignments.length,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             final assignment = assignments[index];

//             return Container(
//               margin: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 6,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // HEADER
//                   Container(
//                     height: 55,
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     decoration: BoxDecoration(
//                       color: AppColors.primary_clr,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 34,
//                           width: 34,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white,
//                           ),
//                           child: Icon(
//                             Icons.receipt_long,
//                             size: 18,
//                             color: AppColors.primary_clr,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         const Expanded(
//                           child: Text(
//                             "Spare Parts Used",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   //  CONDITIONAL UI
//                   if (assignment.usedParts.isEmpty)
//                     const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Center(
//                         child: Text(
//                           "No Spare Part Used",
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     )
//                   else
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         children: assignment.usedParts.map((part) {
//                           return _infospareRow(
//                             part.productName,
//                             part.count.toString(),
//                             "BHD ${part.price}",
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           },
//         ),

//         // Total Service Cost
//         Container(
//           margin: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 6,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 55,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 decoration: BoxDecoration(
//                   color: AppColors.primary_clr,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15),
//                   ),
//                 ),
//                 child: Row(
//                   children: [
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: Text(
//                         "Total Service Cost",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(15),
//                     bottomRight: Radius.circular(15),
//                   ),
//                   color: Colors.grey.shade300,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 20,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Total Amount:"),
//                       Text("BHD ${payment.toString()}"),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _infoRow(
//     BuildContext context,
//     String label,
//     String value, {
//     List<String>? media,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(color: AppColors.lightgray_clr, fontSize: 12),
//           ),
//           Expanded(
//             child: media != null && media.isNotEmpty
//                 ? InkWell(
//                     onTap: () {
//                       _showMediaDialog(context, media);
//                     },
//                     child: Text(
//                       value,
//                       textAlign: TextAlign.right,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.blue,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   )
//                 : Text(
//                     value,
//                     textAlign: TextAlign.right,
//                     maxLines: 5,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showMediaDialog(BuildContext context, List<String> mediaList) {
//     // Separate images and other media
//     final images = mediaList
//         .where(
//           (media) =>
//               media.endsWith(".jpg") ||
//               media.endsWith(".png") ||
//               media.endsWith(".jpeg") ||
//               media.endsWith(".webp"),
//         )
//         .toList();

//     final otherMedia = mediaList
//         .where(
//           (media) =>
//               !media.endsWith(".jpg") &&
//               !media.endsWith(".png") &&
//               !media.endsWith(".jpeg") &&
//               !media.endsWith(".webp"),
//         )
//         .toList();

//     final PageController _pageController = PageController();

//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Media Files",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 12),

//                 // Images carousel
//                 if (images.isNotEmpty)
//                   Column(
//                     children: [
//                       SizedBox(
//                         height: 200,
//                         child: PageView.builder(
//                           controller: _pageController,
//                           itemCount: images.length,
//                           itemBuilder: (context, index) {
//                             final imgUrl =
//                                 "${ImageBaseUrl.baseUrl}/${images[index].trim()}";
//                             return CachedNetworkImage(
//                               imageUrl: imgUrl,
//                               fit: BoxFit.cover,
//                               placeholder: (context, url) => const SizedBox(
//                                 height: 100,
//                                 width: 100,
//                                 child: Center(
//                                   child: CircularProgressIndicator(),
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) =>
//                                   const Icon(Icons.broken_image, size: 50),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       SmoothPageIndicator(
//                         controller: _pageController,
//                         count: images.length,
//                         effect: const WormEffect(
//                           dotHeight: 8,
//                           dotWidth: 8,
//                           spacing: 6,
//                           dotColor: Colors.grey,
//                           activeDotColor: Colors.blue,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                     ],
//                   ),

//                 // Other media (mp3, mp4)
//                 if (otherMedia.isNotEmpty)
//                   SizedBox(
//                     height: 200,
//                     child: ListView.builder(
//                       itemCount: otherMedia.length,
//                       itemBuilder: (context, index) {
//                         final media = otherMedia[index];
//                         return ListTile(
//                           leading: const Icon(Icons.play_circle_fill),
//                           title: Text(media.split('/').last),
//                           onTap: () {
//                             // TODO: Handle video/audio playback
//                           },
//                         );
//                       },
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/core/network/dio_client.dart';
import 'package:tech_app/model/ServiceList%20_Model.dart';

class RequestCart extends StatelessWidget {
  final String clientname;
  final String servicetype;
  final String assignmentStatus;
  final String scheduleService;
  final String createdAt;
  final String feedback;
  final String serviceRequestID;
  final int payment;
  final String userServiceId;
  final List<Assignment> assignments;
  final List<String> media;

  const RequestCart({
    super.key,
    required this.clientname,
    required this.servicetype,
    required this.assignmentStatus,
    required this.scheduleService,
    required this.createdAt,
    required this.feedback,
    required this.serviceRequestID,
    required this.assignments,
    required this.payment,
    required this.media,
      required this.userServiceId,
  });

  String formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate);
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }

  Widget _sectionHeader(String title, {IconData? icon}) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary_clr,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          if (icon != null)
            Container(
              height: 34,
              width: 34,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(icon, size: 18, color: AppColors.primary_clr),
            ),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: child,
    );
  }

  Widget _infoRow(
    BuildContext context,
    String label,
    String value, {
    List<String>? media,
  }) {
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
                      _showissuseMediaDialog(context, media);
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

  Widget _sparePartRow(String label, String qty, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label),
              Row(
                children: [Text("Qty:"), const SizedBox(width: 5), Text(qty)],
              ),
            ],
          ),
          Text(amount),
        ],
      ),
    );
  }

  void _showMediaDialog(BuildContext context, List<String> mediaList) {
    final images = mediaList
        .where(
          (m) =>
              m.endsWith(".jpg") ||
              m.endsWith(".png") ||
              m.endsWith(".jpeg") ||
              m.endsWith(".webp"),
        )
        .toList();

    final otherMedia = mediaList
        .where(
          (m) =>
              !m.endsWith(".jpg") &&
              !m.endsWith(".png") &&
              !m.endsWith(".jpeg") &&
              !m.endsWith(".webp"),
        )
        .toList();

    final PageController _pageController = PageController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
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
                    itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.play_circle_fill),
                      title: Text(otherMedia[index].split('/').last),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showissuseMediaDialog(BuildContext context, List<String> mediaList) {
    // Separate images and other media
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

                // Images carousel
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

                // Other media (mp3, mp4)
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

  String formatWorkDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    return '${hours}h ${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
      "ASSIGNMENTS JSON ********************8:\n${const JsonEncoder.withIndent('  ').convert(assignments.map((e) => e.toJson()).toList())}",
    );
    return Column(
      children: [
        // 1. Request Information
        _cardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader("Request Information", icon: Icons.receipt_long),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _infoRow(context, "Request ID", serviceRequestID),
                    const Divider(),
                    _infoRow(context, "Service Type", servicetype),
                    const Divider(),
                    _infoRow(context, "Status", assignmentStatus),
                    const Divider(),
                    _infoRow(context, "Client Name", clientname),
                    const Divider(),
                    _infoRow(
                      context,
                      "Scheduled For",
                      formatDate(scheduleService),
                    ),
                    const Divider(),
                    _infoRow(
                      context,
                      "View Media",
                      "Tap to view",
                      media: media,
                    ),
                    const Divider(),
                    _infoRow(context, "Created On", formatDate(createdAt)),
                    const Divider(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        style: TextStyle(
                          color: AppColors.lightgray_clr,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        feedback,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 2. Spare Parts Used
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: assignments.length,
          itemBuilder: (context, index) {
            final assignment = assignments[index];
            return _cardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader("Spare Parts Used", icon: Icons.build),
                  assignment.usedParts.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              "No Spare Part Used",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: assignment.usedParts
                                .map(
                                  (part) => _sparePartRow(
                                    part.productName,
                                    part.count.toString(),
                                    "BHD ${part.price}",
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                ],
              ),
            );
          },
        ),

        // 3. Completed Service
        // Completed Service Card
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: assignments.length,
          itemBuilder: (context, index) {
            final assignment = assignments[index];
            final assignmentMedia = assignment.media;

            return _cardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader("Completed Service", icon: Icons.check_circle),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _infoRow(
                          context,
                          "Time durartion :",
                          '${formatWorkDuration(assignment.workDuration)}',
                        ),

                        const Divider(),
                        _infoRow(
                          context,
                          "Description :",
                          '${(assignment.notes) ?? "_"}',
                        ),

                        const Divider(),
                        // View Fixed Media Row
                        if (assignmentMedia.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Fixed Media:",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              InkWell(
                                onTap: () =>
                                    _showMediaDialog(context, assignmentMedia),
                                child: const Text(
                                  "Tap to view",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        // 4. Total Service Cost
        _cardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader("Total Service Cost"),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Colors.grey.shade300,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Amount:"),
                      Text("BHD ${payment.toString()}"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
