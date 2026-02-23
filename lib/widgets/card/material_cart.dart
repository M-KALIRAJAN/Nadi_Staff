import 'package:flutter/material.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/l10n/app_localizations.dart';

class MaterialCart extends StatelessWidget {
  final String productName;
  final int count;
  final int price;

  const MaterialCart({
    super.key,
    required this.productName,
    required this.count,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(12),
      height: 87,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(217, 217, 217, 1),
      ),
      child: Row(
        children: [
       
          Container(
            height: 47,
            width: 47,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: AppColors.primary_clr,
            ),
          ),

          const SizedBox(width: 12),

          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                productName,
                style:
                     TextStyle(fontSize: 14, fontWeight: FontWeight.w600,color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  text: AppLocalizations.of(context)!.countLabel, 
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "$count", 
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                     TextSpan(
                      text: AppLocalizations.of(context)!.priceLabel,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: "$price", 
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
