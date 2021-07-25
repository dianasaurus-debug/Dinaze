import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/view/widgets/waqf_info_row.dart';
import 'package:get/get.dart';

class NewWaqfProgramCard extends StatelessWidget {
  final ProgramWakaf _programWakaf;
  static const double _borderRadius = 10.0;

  NewWaqfProgramCard(this._programWakaf);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: InkWell(
        onTap: () => Get.toNamed('/waqf-program', arguments: _programWakaf.id),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
                child: Image.network(
                  _programWakaf.gambar!,
                  // height: Get.height * 0.1,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: LinearProgressIndicator(
                        backgroundColor: Constant.bwiGreenColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _programWakaf.judul!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Divider(),
                    WaqfProgramInfoRow(_programWakaf),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaqfProgramCard extends StatelessWidget {
  final ProgramWakaf _programWakaf;
  final double _borderRadius = 10.0;

  WaqfProgramCard(this._programWakaf);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: InkWell(
        onTap: () => Get.toNamed('/waqf-program', arguments: _programWakaf.id),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                ),
                child: Image.network(
                  "${Constant.imageUrlApi}/${_programWakaf.gambar}",
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: LinearProgressIndicator(
                        backgroundColor: Constant.bwiGreenColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _programWakaf.judul!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(),
                    WaqfProgramInfoRow(_programWakaf),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
