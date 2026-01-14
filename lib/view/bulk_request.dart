import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_app/core/constants/app_colors.dart';
import 'package:tech_app/core/utils/snackbar_helper.dart';
import 'package:tech_app/model/Inventory_Material_Model.dart';
import 'package:tech_app/routes/route_name.dart';
import 'package:tech_app/services/MaterialRequest_service.dart';
import 'package:tech_app/services/ProductList.dart';
import 'package:tech_app/widgets/inputs/app_dropdown.dart';
import 'package:tech_app/widgets/inputs/app_text_field.dart';
import 'package:tech_app/widgets/inputs/primary_button.dart';

class BulkRequest extends StatefulWidget {
  const BulkRequest({super.key});

  @override
  State<BulkRequest> createState() => _BulkRequestState();
}

class _BulkRequestState extends State<BulkRequest> {

  final Productlist _productlist = Productlist();
  bool isLoading = false;
  List<Product> products = []; // master product list

  final MaterialrequestService _materialrequestService =
      MaterialrequestService();

List<MaterialSelection> materialSelections = [
  MaterialSelection(quantityController: TextEditingController()),
];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final result = await _productlist.fetchproductlist();
    setState(() {
      products = result;
    });
  }
Future<void> submitrequest() async {
  try {
    setState(() => isLoading = true);

    final List<Map<String, dynamic>> requests = [];

    for (final item in materialSelections) {
      if (item.product == null ||
          item.quantityController.text.isEmpty) {
        throw "Please fill all materials";
      }

      requests.add({
        "productId": item.product!.id,
        "quantity": int.parse(item.quantityController.text),
      });
    }

    final payload = {
      "requests": requests,
    };

    await _materialrequestService.fetchmaterialrequest(
      payload: payload,
    );

    SnackbarHelper.show(
      context,
      backgroundColor: AppColors.scoundry_clr,
      message: "Material requests submitted successfully",
    );
     context.push(RouteName.inventory_list);
  } catch (e) {
    SnackbarHelper.show(
      context,
      backgroundColor: Colors.red,
      message: e.toString(),
    );
  } finally {
    setState(() => isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              ...materialSelections.asMap().entries.map(
                (entry) => materialCard(entry.key),
              ),

              PrimaryButton(
                radius: 12,
                color: AppColors.primary_clr,
                height: 55,
                Width: double.infinity,
                onPressed: () {
  setState(() {
    materialSelections.add(
      MaterialSelection(
        quantityController: TextEditingController(),
      ),
    );
  });
},

                text: "Add New Material",
                 icon: Icon(Icons.add ,size: 25,color: Colors.white,),
              ),
              const SizedBox(height: 10,),
               PrimaryButton(
                radius: 12,
                color: AppColors.scoundry_clr,
                height: 55,
                Width: double.infinity,
                onPressed: () {
                   submitrequest();
                },
                text: "Submit Request",
                
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget materialCard(int index) {
     final selection = materialSelections[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.primary_clr,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Material ${index + 1}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                if (materialSelections.length > 1)
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        materialSelections.removeAt(index); // ✅ remove card
                      });
                    },
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Material Name"),
                const SizedBox(height: 8),

                AppDropdown(
                  label: "Select Product",
                  items: products.map((e) => e.productName).toList(),
                  value: selection.product?.productName,
                  onChanged: (value) {
                    final product = products.firstWhere(
                      (e) => e.productName == value,
                    );
                     setState(() {
              selection.product = product;
            });
                   
                  },
                  validator: (value) =>
                      value == null ? "Please select product" : null,
                ),

                const SizedBox(height: 16),
                const Text("Quantity Needed"),
                const SizedBox(height: 8),

                AppTextField(
                  label: "e.g 25",
                     controller: selection.quantityController,
                    keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter quantity";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
}

class MaterialSelection {
  Product? product;
  TextEditingController quantityController;

  MaterialSelection({
    this.product,
    required this.quantityController,
  });
}

