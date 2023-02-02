import 'package:blue_print_pos/receipt/collection_style.dart';
import 'package:blue_print_pos/receipt/receipt_image.dart';
import 'package:blue_print_pos/receipt/receipt_pixel_space.dart';
import 'package:blue_print_pos/receipt/receipt_text_key_value.dart';

import 'receipt_alignment.dart';
import 'receipt_line.dart';
import 'receipt_text.dart';
import 'receipt_text_left_right.dart';
import 'receipt_text_size_type.dart';
import 'receipt_text_style.dart';
import 'receipt_text_style_type.dart';

class ReceiptSectionText {
  ReceiptSectionText() : _data = <String>[];

  ReceiptSectionText._(this._data);

  final List<String> _data;

  int get contentLength => _data.length;

  /// Build a page from html, [CollectionStyle.all] is defined CSS inside html
  /// [_data] will collect all generated tag from model [ReceiptText],
  /// [ReceiptTextLeftRight] and [ReceiptLine]
  String getContent([int start = 0, int? end]) {
    final String data =
        _data.isNotEmpty ? _data.sublist(start, end).join() : '';
    return '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RECEIPT</title>
</head>

${CollectionStyle.all}

<body>
  <div class="receipt">
    <div class="container">
      <!-- testing part -->
      
      $data
      
    </div>
  </div>
</body>
</html>
    ''';
  }

  ReceiptSectionText getSection([int start = 0, int? end]) {
    if (_data.isEmpty) {
      return ReceiptSectionText();
    }
    return ReceiptSectionText._(_data.sublist(start, end));
  }

  /// Handler tag of text (p or b) and put inside body html
  /// This will generate single line text left, center or right
  /// [text] value of text will print
  /// [alignment] to set alignment of text
  /// [style] define normal or bold
  /// [size] to set size of text small, medium, large or extra large
  void addText(
    String text, {
    ReceiptAlignment alignment = ReceiptAlignment.center,
    ReceiptTextStyleType style = ReceiptTextStyleType.normal,
    ReceiptTextSizeType size = ReceiptTextSizeType.medium,
  }) {
    final ReceiptText receiptText = ReceiptText(
      text,
      textStyle: ReceiptTextStyle(
        type: style,
        size: size,
      ),
      alignment: alignment,
    );
    _data.add(receiptText.html);
  }

  /// Handler tag of text (span or b) and put inside body html
  /// This will generate left right text with two value input from parameter
  /// [leftText] and [rightText]
  void addLeftRightText(
    String leftText,
    String rightText, {
    ReceiptTextStyleType leftStyle = ReceiptTextStyleType.normal,
    ReceiptTextStyleType rightStyle = ReceiptTextStyleType.normal,
    ReceiptTextSizeType leftSize = ReceiptTextSizeType.medium,
    ReceiptTextSizeType rightSize = ReceiptTextSizeType.medium,
  }) {
    final ReceiptTextLeftRight leftRightText = ReceiptTextLeftRight(
      leftText,
      rightText,
      leftTextStyle: ReceiptTextStyle(
        type: leftStyle,
        useSpan: true,
        size: leftSize,
      ),
      rightTextStyle: ReceiptTextStyle(
        type: leftStyle,
        useSpan: true,
        size: rightSize,
      ),
    );
    _data.add(leftRightText.html);
  }

  void addKeyValueText(List<ReceiptTextKeyValue> listKeyValueText) {
    final List<String> listTable = listKeyValueText.map((ReceiptTextKeyValue e) => e.html).toList();
    final String table = listTable.sublist(0,listTable.length).join('');
    final String html = '''
    <table>
        $table
      </table>      
  ''';
    _data.add(html);
  }

  /// Add new line as empty or dashed line.
  /// [count] is how much line
  /// if [useDashed] true line will print as dashed line
  void addSpacer({int count = 1, bool useDashed = false}) {
    final ReceiptLine line = ReceiptLine(count: count, useDashed: useDashed);
    _data.add(line.html);
  }

  void addSpacerPx([int pixels = 1]) {
    final ReceiptPixelSpace space = ReceiptPixelSpace(pixels: pixels);
    _data.add(space.html);
  }

  void addImage(
    String base64, {
    int width = 120,
    ReceiptAlignment alignment = ReceiptAlignment.center,
  }) {
    final ReceiptImage image = ReceiptImage(
      base64,
      width: width,
      alignment: alignment,
    );
    _data.add(image.html);
  }
}
