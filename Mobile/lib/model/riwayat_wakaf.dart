import 'package:flutter_cash_waqf/model/wakaf.dart';
import 'package:flutter_cash_waqf/model/wakaf_abadi.dart';
import 'package:flutter_cash_waqf/model/wakaf_berjangka.dart';

class RiwayatWakaf {
  static List<Wakaf> createList(List<dynamic> data) {
    List<Wakaf> _listRiwayatWakaf = [];
    data.forEach((riwayatWakaf) => {
          if (riwayatWakaf['jenis'] == 'Abadi')
            _listRiwayatWakaf.add(WakafAbadi.createFromJson(riwayatWakaf))
          else
            _listRiwayatWakaf.add(WakafBerjangka.createFromJson(riwayatWakaf))
        });
    return _listRiwayatWakaf;
  }

  static List<Wakaf> createListWithoutProgram(List<dynamic> data) {
    List<Wakaf> _listRiwayatWakaf = [];
    data.forEach((riwayatWakaf) => {
          if (riwayatWakaf['jenis'] == 'Abadi')
            _listRiwayatWakaf.add(WakafAbadi.createWithoutProgram(riwayatWakaf))
          else
            _listRiwayatWakaf
                .add(WakafBerjangka.createWithoutProgram(riwayatWakaf))
        });
    return _listRiwayatWakaf;
  }
}
