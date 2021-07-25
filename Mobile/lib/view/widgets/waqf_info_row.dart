import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/utilities/extensions.dart';

class WaqfProgramInfoRow extends StatelessWidget {
  final ProgramWakaf _programWakaf;

  WaqfProgramInfoRow(this._programWakaf);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Kategori",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            Text(
              _programWakaf.kategori!.nama!,
              style: TextStyle(
                color: Constant.bwiGreenColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Wakaf Abadi Terkumpul",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            Text(
              _programWakaf.wakafAbadiTerkumpul!.toRupiahFormat(),
              style: TextStyle(
                color: Constant.bwiGreenColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Wakaf Berjangka Terkumpul",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            Text(
              _programWakaf.wakafBerjangkaTerkumpul!.toRupiahFormat(),
              style: TextStyle(
                color: Constant.bwiGreenColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ],
    );
  }
}
