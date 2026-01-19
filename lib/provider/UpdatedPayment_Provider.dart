 import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tech_app/services/UpdatePayment_Service.dart';

final updatePaymentServiceProvider =
    Provider<UpdatepaymentService>((ref) {
  return UpdatepaymentService();
});
