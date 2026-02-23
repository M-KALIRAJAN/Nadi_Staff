 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_app/services/chats_lists.dart';


final fetchchatslistprovider = FutureProvider((ref) async {
    final result = await ChatsList().fetchchatlist();
    return result;
});