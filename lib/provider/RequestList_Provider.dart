import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_app/services/RequestList_Service.dart';

final requestlistprovider = FutureProvider((ref)async{
   final result = await RequestlistService().fetchrequestlist();
   return result;
});