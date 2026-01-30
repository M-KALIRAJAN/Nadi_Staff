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

class MaterialRequest extends StatefulWidget {
  const MaterialRequest({super.key});

  @override
  State<MaterialRequest> createState() => _MaterialRequestState();
}

class _MaterialRequestState extends State<MaterialRequest> {
  Product? selectedProduct;
  List<Product> products = [];
  bool isLoading = false;
  final Productlist _productlist = Productlist();
  final MaterialrequestService _materialrequestService =
      MaterialrequestService();
  final _quantity = TextEditingController();
  final _optionalissuse = TextEditingController();
  final _fromkey = GlobalKey<FormState>();
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
      final int quantity = int.parse(_quantity.text);
      setState(() {
        isLoading = true;
      });
      final payload = <String, dynamic>{
        "requests": [
          {"productId": selectedProduct!.id, "quantity": quantity},
        ],
      };

      final result = await _materialrequestService.fetchmaterialrequest(
        payload: payload,
      );
      setState(() {
        isLoading = false;
      });
      SnackbarHelper.show(
        context,
        backgroundColor: AppColors.scoundry_clr,
        message: "material requests submitted successfully",
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _fromkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Material Name", style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 15),
                  AppDropdown(
                    label: "Select Product",
                    items: products.map((e) => e.productName).toList(),
                    value: selectedProduct?.productName,
                    validator: (value) =>
                        value == null ? "Please select product" : null,
                    onChanged: (value) {
                      final Product = products.firstWhere(
                        (e) => e.productName == value,
                      );
                      setState(() {
                        selectedProduct = Product;
                      });
                    },
                  ),
                  const SizedBox(height: 25),

                  Text("Quantity Needed"),
                  const SizedBox(height: 15),
                  AppTextField(
                    label: "# e.g 25",
                    controller: _quantity,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter the quantity";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),

                  Text("Optional Notes"),
                  const SizedBox(height: 15),
                  AppTextField(
                    label: "if other issuse please mention here",
                    controller: _optionalissuse,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 35),

                  PrimaryButton(
                    radius: 12,
                    color: AppColors.primary_clr,
                    Width: double.infinity,
                    height: 50,
                    onPressed: () {
                      context.push(RouteName.bulk_request);
                    },
                    text: "Add Bulk Request",
                    icon: Icon(Icons.add, size: 25, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    radius: 12,
                    color: AppColors.scoundry_clr,
                    Width: double.infinity,
                    height: 50,
                    isLoading: isLoading,
                    onPressed: () {
                      if (_fromkey.currentState!.validate()) {
                        submitrequest();
                      }
                    },
                    text: "Submit Request",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
