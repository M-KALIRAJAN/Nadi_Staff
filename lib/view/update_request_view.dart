import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/provider/service_list_provider.dart';
import 'package:tech_app/provider/service_timer_provider.dart';
import 'package:tech_app/services/Update_Service.dart';
import 'package:tech_app/widgets/inputs/app_text_field.dart';
import 'package:tech_app/widgets/inputs/primary_button.dart';
import 'package:tech_app/widgets/media_upload.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateRequestView extends ConsumerStatefulWidget {
  final String serviceRequestId;
  final String userServiceId;
  const UpdateRequestView({
    super.key,
    required this.serviceRequestId,
    required this.userServiceId,
  });

  @override
  ConsumerState<UpdateRequestView> createState() => _UpdateRequestViewState();
}

class _UpdateRequestViewState extends ConsumerState<UpdateRequestView> {
  Set<int> selectedIndexes = {
    0,
    1,
  }; // Accepted & In Progress selected by default
  Timer? _timer;
  bool isOnHold = false;
  int _elapsedSeconds = 0;
  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];
  final UpdateService _updateService = UpdateService();
  final statustext = TextEditingController();
  final List<Map<String, dynamic>> status = [
    {"title": "Accepted"},
    {"title": "In Progress"},
    {"title": "OnHold"},
    {"title": "completed"},
  ];
  bool get isCompletedSelected => selectedIndexes.contains(3);
  @override
  void initState() {
    super.initState();
    selectedIndexes = {0, 1}; // Always selected
    // 🔥 START GLOBAL TIMER
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(serviceTimerProvider.notifier).start();
    });
  }

  void toggleOnHold() {
    final notifier = ref.read(serviceTimerProvider.notifier);
    final timerState = ref.read(serviceTimerProvider);

    if (timerState.isRunning) {
      notifier.pause();
      setState(() => isOnHold = true);
    } else {
      notifier.start();
      setState(() => isOnHold = false);
    }
  }

  //  CALL API ONLY WHEN GOING ON HOLD (outside setState)
  // if (goingOnHold) {
  //   try {
  //     await _updateService.fetchonhold(
  //       userServiceId: widget.userServiceId,
  //     );
  //   } catch (e) {
  //     debugPrint("OnHold API error: $e");
  //   }
  // }

  @override
  void dispose() {
    statustext.dispose();
    super.dispose();
  }

  String formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inHours)}:${two(d.inMinutes % 60)}:${two(d.inSeconds % 60)}";
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImages.add(image);
      });
    }
  }

  Future<void> SaveUpdates() async {
    try {
      final files = selectedImages.map((xfile) => File(xfile.path)).toList();

      final result = await _updateService.fetchupdatedservice(
        images: files,
        userServiceId: widget.userServiceId,
        serviceStatus: statustext.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Update saved successfully"),
          backgroundColor: AppColors.scoundry_clr,
        ),
      );
      context.pop();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(serviceTimerProvider);
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(223, 221, 221, 1),
              ),
              child: Center(
                child: Text(
                  widget.serviceRequestId,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Timer"),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: AppColors.scoundry_clr,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatDuration(timerState.elapsed),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isOnHold ? Colors.green : Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: toggleOnHold,
                    child: Text(
                      isOnHold ? "Start" : "On Hold",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            const Text("Updated Status"),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 4,
              ),
              itemCount: status.length,

              itemBuilder: (context, index) {
                final statusItem = status[index];
                final bool isSelected = selectedIndexes.contains(index);

                return InkWell(
                  onTap: () {
                    //  Accepted (0) & In Progress (1) → DO NOTHING
                    if (index == 0 || index == 1) return;

                    setState(() {
                      if (isSelected) {
                        selectedIndexes.remove(index);
                      } else {
                        selectedIndexes.add(index);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.scoundry_clr : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColors.scoundry_clr,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        statusItem['title'],
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.scoundry_clr,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),
            const Text("Add Notes"),
            const SizedBox(height: 15),
            AppTextField(
              maxLines: 3,
              controller: statustext,
              label: "description",
            ),
            const SizedBox(height: 15),
            const Text("Media Upload"),
            const SizedBox(height: 25),
            // UPLOAD BUTTON
            MediaUploadWidget(
              images: selectedImages,
              onAddTap: () {
                showImagePickerSheet(context);
              },
              onRemoveTap: (index) {
                setState(() {
                  selectedImages.removeAt(index);
                });
              },
            ),

            const SizedBox(height: 25),

            // PrimaryButton(
            //   radius: 15,
            //   Width: double.infinity,
            //   height: 55,
            //   color: AppColors.scoundry_clr,
            //   onPressed: () {
            //     // context.push(RouteName.sparepart_used);
            //     SaveUpdates();
            //   },
            //   text: "Save Updates",
            // ),
            isCompletedSelected
                ? PrimaryButton(
                    radius: 15,
                    Width: double.infinity,
                    height: 55,
                    color: AppColors.scoundry_clr,
                    onPressed: SaveUpdates,
                    text: "Save Updates",
                  )
                : PrimaryButton(
                    radius: 15,
                    Width: double.infinity,
                    height: 55,
                    color: Colors.grey,
                    onPressed: null, // disabled
                    text: "Save Updates",
                  ),
          ],
        ),
      ),
    );
  }

  void showImagePickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
