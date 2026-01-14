import 'package:flutter/material.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/widgets/inputs/primary_button.dart';

class SparePartUsed extends StatefulWidget {
  const SparePartUsed({super.key});

  @override
  State<SparePartUsed> createState() => _SparePartUsedState();
}

class _SparePartUsedState extends State<SparePartUsed> {
  bool isSparePartsUsed = false;
  bool is_Selectedsaprepart = false;

  final List<Map<String, dynamic>> spareParts = [
    {'name': 'Oil Filter', 'price': 75.88, 'checked': false},
    {'name': 'Air Plug Set', 'price': 45.88, 'checked': false},
    {'name': 'Cabin Air Filter', 'price': 15.30, 'checked': false},
    {'name': 'Spark Plug Set', 'price': 35.00, 'checked': false},
  ];

  final List<Map<String, dynamic>> paymentlist = [
    {"name": "spark", 'price': 35.00},
    {"name": "spark", 'price': 35.00},
    {"name": "Total", 'price': 35.00},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MAIN CHECKBOX
              Row(
                children: [
                  Checkbox(
                    value: isSparePartsUsed,
                    activeColor: AppColors.scoundry_clr,
                    onChanged: (value) {
                      setState(() {
                        isSparePartsUsed = value!;
                      });
                    },
                  ),
                  const Text(
                    "Spare Parts Used",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// AVAILABLE PARTS
              _availablePartsCard(),
              const SizedBox(height: 20),

              Text(
                "Selected parts",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // SELECTED SPARE PART CARD
              Container(
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: is_Selectedsaprepart,
                      activeColor: AppColors.scoundry_clr,
                      onChanged: (value) {
                        setState(() {
                          is_Selectedsaprepart = value!;
                        });
                      },
                    ),

                    const SizedBox(width: 8),

                    // IMAGE BOX
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.build_outlined),
                    ),

                    const SizedBox(width: 12),

                    // NAME & PRICE
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Spare Parts",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "BHD 89",
                          style: TextStyle(
                            color: AppColors.scoundry_clr,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // DELETE BUTTON
                    Container(
                      height: double.infinity,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.scoundry_clr,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // PAYMENT SUMMARY
              
              _paymentSummaryCard(),

               const SizedBox(height: 25),
               PrimaryButton(
                Width: double.infinity,
                height: 50,
                radius: 12, 
                color: AppColors.scoundry_clr,
                 onPressed: (){

                 },
                  text: "Prceed to Payment")
            ],
          ),
        ),
      ),
    );
  }

  // AVAILABLE PARTS CARD
  Widget _availablePartsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          _cardHeader("Available Parts", AppColors.primary_clr),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: spareParts.length,
            itemBuilder: (context, index) {
              final item = spareParts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Checkbox(
                      value: item['checked'],
                      activeColor: AppColors.scoundry_clr,
                      onChanged: !isSparePartsUsed
                          ? null
                          : (value) {
                              setState(() {
                                item['checked'] = value!;
                              });
                            },
                    ),
                    Expanded(child: Text(item['name'])),
                    Text(
                      'BHD ${item['price'].toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // PAYMENT SUMMARY CARD
  Widget _paymentSummaryCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          _cardHeader("Payment Summary", AppColors.lightgray_clr),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemCount: paymentlist.length,
            itemBuilder: (context, index) {
              final payments = paymentlist[index];
              final bool isTotal = payments['name'] == "Total";
              return Container(
                decoration: BoxDecoration(
                  color: isTotal
                      ? AppColors.lightgray_clr.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),

                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(payments['name']),
                    Text(
                      "BHD ${payments['price']}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isTotal ? AppColors.primary_clr : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  //  CARD HEADER
  Widget _cardHeader(String title, Color bgColor) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
