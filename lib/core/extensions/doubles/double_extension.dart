import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toJson() => toString();

  String toFormattedInteger() => NumberFormat("###,###,##0", "pt_BR").format(round());

  String toFormattedCurrency() => NumberFormat("###,###,##0.00", "pt_BR").format(this);

  String toFormattedPercentage() => '${NumberFormat("###,###,##0.00", "pt_BR").format(this)}%';
}
