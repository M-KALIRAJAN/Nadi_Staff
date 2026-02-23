import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_app/provider/language_provider.dart';
import 'package:tech_app/services/RequestList_Service.dart';

final requestlistprovider = FutureProvider((ref)async{
   final local = ref.watch(languageProvider);
   final lang = local.languageCode;
   final result = await RequestlistService().fetchrequestlist(lang);
   return result;
});