 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_app/services/InventoryMaterial_List_Service.dart';

final inventorylistprovider = FutureProvider((ref)async{
  final result = InventorymaterialListService().InventoryList();
  return result ;
});