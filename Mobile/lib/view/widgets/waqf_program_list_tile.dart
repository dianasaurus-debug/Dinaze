import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/model/program_wakaf.dart';

class WaqfProgramListTile extends StatelessWidget {
  final ProgramWakaf _programWakaf;

  WaqfProgramListTile(this._programWakaf);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: GestureDetector(
          onTap: () => AwesomeDialog(
                context: context,
                dialogType: DialogType.NO_HEADER,
                animType: AnimType.BOTTOMSLIDE,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                buttonsBorderRadius: BorderRadius.circular(5),
                body: Image.network(
                  _programWakaf.gambar!,
                ),
                btnCancelOnPress: () {},
                btnCancelText: "Tutup",
              ).show(),
          child: Image.network(_programWakaf.gambar!)),
      title: Text(
        _programWakaf.judul!,
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }
}
