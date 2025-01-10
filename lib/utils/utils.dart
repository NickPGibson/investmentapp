

import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:intl/intl.dart';

String toSterling(Decimal value) => "£${DecimalFormatter(NumberFormat.decimalPattern('en-GB')).format(value)}";
