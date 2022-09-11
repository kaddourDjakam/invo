import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory/Model/pdfModels/invoiceModel.dart';
import 'package:flutter/services.dart';
import 'package:inventory/Model/providerModel.dart';
import 'package:inventory/View/PicInPicViews/submitOrderView.dart';
import 'package:inventory/ViewModel/apisViewModel.dart';
import 'package:inventory/ViewModel/submitOrderViewModel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class PdfInvoiceApi extends ChangeNotifier {
  Future<File> generate(Invoice invoice, String debt, BuildContext context,
      totalPaid, String oldDebt) async {
    SubmitOrderViewModel _submitOrderView =
        Provider.of<SubmitOrderViewModel>(context, listen: false);

    String totalDebt =
        (double.parse(_submitOrderView.newDebts) - double.parse(debt))
            .toString();

    final pdf = Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              buildHeader(invoice),
              pw.SizedBox(height: 5 * PdfPageFormat.mm),
              buildTitle(),
              pw.SizedBox(height: 5 * PdfPageFormat.mm),
              buildInvoice(invoice),
              pw.SizedBox(height: 5 * PdfPageFormat.mm),
              pw.Divider(height: 0.5),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              buildTotal(invoice, debt, oldDebt, totalPaid, totalDebt),
              pw.SizedBox(height: 5 * PdfPageFormat.mm),
              buildFooter(),
            ]),
      ),
    );

    return saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

////////////////////////////////////////////////////////////////////////////////////
  Future<File> saveDocument({
    String name,
    Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    print(dir);
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  ///////////////////////////////////////////////////////////////////////////////////
  pw.Widget buildTitle() => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Text(
            'INVOICE',
            style: pw.TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      );

  pw.Widget buildHeader(Invoice invoice) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          buildCustomer(invoice.supplier),
          pw.SizedBox(height: 15 * PdfPageFormat.mm),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              buildCustomer(invoice.customer),
              buildInvoiceInfo(invoice.info),
            ],
          )
        ],
      );

  pw.Widget buildCustomer(ProviderModel customer) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(customer.name,
              style: pw.TextStyle(fontWeight: FontWeight.bold, fontSize: 8)),
          pw.Row(children: [
            pw.Text("Tel: ",
                style: pw.TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                  color: PdfColors.grey700,
                )),
            pw.Text(customer.phoneNum,
                style: pw.TextStyle(
                  fontSize: 8,
                  color: PdfColors.grey700,
                )),
          ])
        ],
      );

  pw.Widget buildInvoiceInfo(InvoiceInfo info) {
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
    ];
    final data = <String>[
      info.number.padLeft(6, '0'),
      info.date,
    ];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(
            title: title, value: value, width: 35 * PdfPageFormat.mm);
      }),
    );
  }

  static buildText({
    String title,
    String value,
    double width = double.infinity,
    pw.TextStyle titleStyle,
  }) {
    final style =
        titleStyle ?? pw.TextStyle(fontWeight: FontWeight.bold, fontSize: 8);

    return pw.Container(
      margin: pw.EdgeInsets.only(top: 5),
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: pw.TextStyle(fontSize: 8)),
        ],
      ),
    );
  }

  pw.Widget buildInvoice(Invoice invoice) {
    print(invoice.items);
    final headers = ['Product', 'Price', 'Unit', 'Peice', 'Quantity', 'Total'];
    final data = invoice.items.map((item) {
      return [
        item.productName,
        "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(item.priceSell))} DA",
        ' ${item.units}',
        '${item.peices}',
        '${item.quantity}',
        '${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(item.totalunitPrice))} DA',
      ];
    }).toList();

    return pw.Table.fromTextArray(
      cellStyle: pw.TextStyle(fontSize: 5),
      headers: headers,
      data: data,
      border: null,
      headerStyle: pw.TextStyle(fontWeight: FontWeight.bold, fontSize: 5),
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 15,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
      },
    );
  }

  pw.Widget buildTotal(Invoice invoice, String debt, String oldDebt,
      String totalPaid, String totalDebt) {
    final netTotal = invoice.items
        .map((item) => double.parse(item.priceSell) * int.parse(item.quantity))
        .reduce((item1, item2) => item1 + item2);

    return pw.Container(
      width: 200,
      alignment: pw.Alignment.centerRight,
      child: pw.Row(
        children: [
          pw.Spacer(flex: 3),
          pw.Expanded(
            flex: 6,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value:
                      "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(netTotal)} DA",
                ),
                buildText(
                  title: 'Total Paid',
                  value:
                      "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(totalPaid))} DA",
                ),
                buildText(
                  title: 'Currently debts',
                  value:
                      "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(debt))} DA",
                ),
                buildText(
                  title: 'Old debts',
                  value:
                      "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(oldDebt) < 0 ? (double.parse(oldDebt) * -1) : double.parse(oldDebt))} DA",
                ),
                pw.Divider(),
                buildText(
                  title: 'Total debts',
                  value:
                      "${NumberFormat.simpleCurrency(name: '', decimalDigits: 2).format(double.parse(totalDebt) < 0 ? (double.parse(totalDebt) * -1) : double.parse(totalDebt))} DA",
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Container(height: 1, color: PdfColors.grey400),
                pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                pw.Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget buildFooter() => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Divider(),
          pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
          buildSimpleText(title: 'developed by ', value: "Djakam Kaddour"),
        ],
      );

  buildSimpleText({
    String title,
    String value,
  }) {
    final style = pw.TextStyle(fontWeight: FontWeight.bold, fontSize: 5);

    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(title, style: style),
        pw.SizedBox(width: 2 * PdfPageFormat.mm),
        pw.Text(value, style: style),
      ],
    );
  }
}
