 
 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_app/model/OurSpareParts_Model.dart';
import 'package:tech_app/services/OurSpareParts_Service.dart';

final oursparepartsprovider = FutureProvider<OurSpareParts>((ref) async {
  print("🟡 Provider called");

  final result = await OursparepartsService().fetchourspareparts();

  print("🟢 Provider success: ${result.data.length} items");

  return result;
});
