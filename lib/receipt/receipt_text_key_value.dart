import 'package:blue_print_pos/receipt/receipt.dart';

import 'receipt_text_style.dart';
import 'receipt_text_style_type.dart';

class ReceiptTextKeyValue{
  ReceiptTextKeyValue(
      this.keyText,
      this.valueText,{
        this.separatorText = ':',
        this.keyTextStyle  = const ReceiptTextStyle(
          type: ReceiptTextStyleType.normal,
          size: ReceiptTextSizeType.medium,
          useSpan: true,),
        this.separatorTextStyle  = const ReceiptTextStyle(
          type: ReceiptTextStyleType.normal,
          size: ReceiptTextSizeType.medium,
          useSpan: true,),
        this.valueTextStyle  = const ReceiptTextStyle(
          type: ReceiptTextStyleType.normal,
          size: ReceiptTextSizeType.medium,
          useSpan: true,

        ),});

  final String keyText;
  final String valueText;
  final String separatorText;
  final ReceiptTextStyle keyTextStyle;
  final ReceiptTextStyle separatorTextStyle;
  final ReceiptTextStyle valueTextStyle;


  String get separator =>  separatorText.isEmpty ? '' : '<td style="vertical-align:top"><${separatorTextStyle.textStyleHTML}  class="${separatorTextStyle.textSizeHtml}">$separatorText</${separatorTextStyle.textStyleHTML}></td>';

  String get html => '''    
        <tr>
          <td style="width:35%;vertical-align:top"><${keyTextStyle.textStyleHTML}  class="${keyTextStyle.textSizeHtml}">$keyText</${keyTextStyle.textStyleHTML}></td>
          $separator
          <td style="width:65%;vertical-align:top"><${valueTextStyle.textStyleHTML}  class="${valueTextStyle.textSizeHtml}">$valueText</${valueTextStyle.textStyleHTML}></td>
        </tr>             
  ''';
}