import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/core/utils/Time_Date.dart';
import 'package:tech_app/model/ServiceList%20_Model.dart';
import 'package:tech_app/provider/service_timer_provider.dart';

class IncomeCard extends ConsumerWidget {
  final String name;
  final String service;
  final String? issue;
  final String? schedule;
  final String assignmentStatus;
  final VoidCallback onClick;
  final int? payment;
  final List<Assignment> assignments;
  const IncomeCard({
    super.key,
    required this.name,
    required this.service,
    this.issue,
    this.schedule,
    required this.assignmentStatus,
    required this.onClick,
    this.assignments = const [],
    this.payment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(serviceTimerProvider);

    void logAssignments() {
      if (assignments.isEmpty) {
        debugPrint("❌ No assignments found");
        return;
      }

      debugPrint("========== ASSIGNMENTS DEBUG ==========");

      for (int i = 0; i < assignments.length; i++) {
        final a = assignments[i];

        debugPrint("""
🧾 Assignment #${i + 1}
---------------------------------
Technician ID : ${a.technicianId}
Status        : ${a.status}
Notes         : ${a.notes}
Work Duration : ${a.workDuration}
PaymentRaised : ${a.paymentRaised}
WorkStartedAt : ${a.workStartedAt}
UpdatedAt     : ${a.updatedAt}

Media         : ${a.media}
Used Parts    : ${a.usedParts.map((p) => '${p.productName} x${p.count} = ${p.total}').toList()}
---------------------------------
""");
      }

      debugPrint("========== END ASSIGNMENTS ==========");
    }

    logAssignments();
    String formatWorkDuration(int seconds) {
      final hours = seconds ~/ 3600;
      final minutes = (seconds % 3600) ~/ 60;
      return '${hours}h ${minutes}m';
    }

    String format(Duration d) =>
        "${d.inHours.toString().padLeft(2, '0')}:"
        "${(d.inMinutes % 60).toString().padLeft(2, '0')}:"
        "${(d.inSeconds % 60).toString().padLeft(2, '0')}";
    final assignment = assignments.isNotEmpty ? assignments.first : null;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onClick,
            child: Container(
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
                  Expanded(
                    child: Text(
                      issue ?? "-",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _infoRow(
                        image: Image.asset("assets/images/person.png"),
                        text: name,
                      ),
                    ),

                    if (assignmentStatus.toLowerCase() == 'in-progress')
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 16,
                            color: AppColors.primary_clr,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            format(timer.elapsed),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                _infoRow(
                  image: Image.asset("assets/images/expect.png"),
                  text: service,
                  iconBg: const Color.fromARGB(156, 169, 227, 212),
                ),
                const SizedBox(height: 5),
                if (payment != null) ...[
                  _infoRow(
                      image: Image.asset("assets/images/curuncy.png" ),
                    text: " BHD: ${payment.toString()}",
                  ),
                ],
                const SizedBox(height: 5),
                _infoRow(
                  icon: Icon(
                    Icons.date_range,
                    size: 18,
                    color: AppColors.scoundry_clr,
                  ),
                  text: " ${formatDateForUI(assignment!.updatedAt!)}",
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    if (assignment.status == "completed") ...[
                      _iconBox(
                        image: Image.asset("assets/images/clock.png"),
                        bgColor: const Color.fromARGB(156, 169, 227, 212),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          formatWorkDuration(assignment.workDuration),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: assignmentStatus == "pending"
                            ? AppColors.new_clr
                            : assignmentStatus == "rejected"
                            ? Colors.red
                            : AppColors.primary_clr,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        assignmentStatus.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // -------- REUSABLE ROW --------
  static Widget _infoRow({
    Image? image,
    Icon? icon,
    required String text,
    Color? iconBg,
  }) {
    return Row(
      children: [
        _iconBox(image: image, icon: icon, bgColor: iconBg),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  static Widget _iconBox({Image? image, Icon? icon, Color? bgColor}) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: bgColor ?? Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(child: image ?? icon ?? const SizedBox()),
    );
  }
}
