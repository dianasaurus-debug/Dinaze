import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/utilities/extensions.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';

class PaymentMethodListTile extends StatelessWidget {
  final String _paymentMethod;
  final String _paymentCode;
  final String _paymentStatus;

  PaymentMethodListTile(
      this._paymentMethod, this._paymentCode, this._paymentStatus);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        'images/$_paymentMethod.png',
        height: 50,
        width: 50,
      ),
      title: (_paymentMethod == 'qris')
          ? GestureDetector(
              child: Text(
                "Tampilkan Kode QR",
                style: TextStyle(
                  color: bwiGreenColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => AwesomeDialog(
                context: context,
                dialogType: DialogType.NO_HEADER,
                animType: AnimType.BOTTOMSLIDE,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                autoHide: Duration(seconds: 10),
                buttonsBorderRadius: BorderRadius.circular(5),
                body: Image.network(
                  _paymentCode,
                ),
                btnCancelOnPress: () {},
                btnCancelText: "Tutup",
              ).show(),
            )
          : Text(_paymentCode),
      subtitle: Text(_paymentStatus.toPaymentStatusDisplay()),
      trailing: (_paymentMethod == 'qris')
          ? IconButton(
              icon: Icon(Icons.file_download),
              color: Colors.black,
              tooltip: "Unduh Kode QR",
              padding: EdgeInsets.zero,
              onPressed: () async {
                try {
                  final _imageId = await ImageDownloader.downloadImage(
                    _paymentCode,
                    destination: AndroidDestinationType.directoryDownloads,
                  );
                  printInfo(info: _imageId.toString());
                } catch (e) {
                  printError(info: e.toString());
                }
              },
            )
          : IconButton(
              icon: Icon(Icons.copy),
              color: Colors.black,
              tooltip: "Salin Kode Pembayaran",
              padding: EdgeInsets.zero,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _paymentCode))
                    .then((value) {
                  Get.snackbar(
                    "Berhasil",
                    "Berhasil menyalin kode pembayaran",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    isDismissible: true,
                    duration: Duration(seconds: 2),
                    borderRadius: 10.0,
                    padding: EdgeInsets.all(15.0),
                    snackPosition: SnackPosition.TOP,
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  );
                });
              },
            ),
    );
  }
}
