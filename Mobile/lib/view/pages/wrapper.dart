import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/login_check/login_check_cubit.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:get/get.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    context.read<LoginCheckCubit>().loginCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginCheckCubit, LoginCheckState>(
        listener: (_, state) {
          if (state is LoggedInState) Get.offAllNamed('/main-page');
          if (state is NotLoggedInState) Get.offAllNamed('/boarding');
          if (state is TokenExpiredState) Get.offAllNamed('/boarding');
        },
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/bwi-logo-1.png',
                width: Get.width * 0.6,
              ),
              Loading(),
            ],
          ),
        ),
      ),
    );
  }
}
