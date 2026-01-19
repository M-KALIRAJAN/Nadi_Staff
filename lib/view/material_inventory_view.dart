import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/model/Inventory_Material_Model.dart';
import 'package:tech_app/routes/route_name.dart';
import 'package:tech_app/services/InventoryMaterial_List_Service.dart';
import 'package:tech_app/widgets/card/material_cart.dart';
import 'package:tech_app/widgets/card/shimmer_loader.dart';
import 'package:tech_app/widgets/header.dart';
import 'package:tech_app/widgets/inputs/primary_button.dart';

class MaterialInventoryView extends StatefulWidget {
  const MaterialInventoryView({super.key});

  @override
  State<MaterialInventoryView> createState() => _MaterialInventoryViewState();
}

class _MaterialInventoryViewState extends State<MaterialInventoryView> {
  final InventorymaterialListService _inventorymaterialList =
      InventorymaterialListService();

  InventoryMaterial? inventoryMaterial;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInventory();
  }

  Future<void> fetchInventory() async {
    try {
      final response = await _inventorymaterialList.InventoryList();
      setState(() {
        inventoryMaterial = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Header(title: "Material Inventory", showRefreshIcon: true),
            ),

            const Divider(),
            const SizedBox(height: 10),

            // LOADING STATE
            if (isLoading)
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return const ShimmerLoader(
                      height: 87,
                      width: double.infinity,
                    );
                  },
                ),
              )
            /// 🔹EMPTY STATE

            else if (inventoryMaterial == null ||
                inventoryMaterial!.data.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // center vertically
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // center horizontally
                    children: [
                      Image.asset(
                        "assets/images/inventory.png",
                        height: 100,
                        fit: BoxFit
                            .contain,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "No inventory found",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(13, 95, 72, 1),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: inventoryMaterial!.data.length,
                  itemBuilder: (context, index) {
                    final item = inventoryMaterial!.data[index];

                    final productName = item.productId.productName ;
                    final price = item.productId.price ;
                    final count = item.count;

                    return MaterialCart(
                      productName: productName,
                      count: count,
                      price: price,
                    );
                  },
                ),
              ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                radius: 10,
                color: AppColors.scoundry_clr,
                  isLoading: isLoading,
                onPressed: () {
                  context.push(RouteName.material_request);
                },
                Width: double.infinity,
                height: 50,
                text: "Request Material",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
