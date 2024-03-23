import 'package:bakery_app/core/constants/global_variables.dart';
import 'package:bakery_app/core/utils/is_today_check.dart';
import 'package:bakery_app/core/utils/show_snackbar.dart';
import 'package:bakery_app/core/utils/user_login_params.dart';
import 'package:bakery_app/features/data/models/user.dart';
import 'package:bakery_app/features/presentation/pages/admin/screens/admin_page.dart';
import 'package:bakery_app/features/presentation/pages/dough/screens/dough_list_page.dart';
import 'package:bakery_app/features/presentation/pages/production/screens/production_page.dart';
import 'package:bakery_app/features/presentation/pages/sell_assistance/screens/sell_assistance_page.dart';
import 'package:bakery_app/features/presentation/pages/service/screens/service_lists_page.dart';
import 'package:bakery_app/features/presentation/widgets/custom_button.dart';
import 'package:bakery_app/features/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/auth-page";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _signinFormKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: GlobalVariables.secondaryColor),
        elevation: 0,
        //  backgroundColor: const Color.fromARGB(115, 233, 233, 233),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            isAdminCheck(state.user!.token!);
            _determineHomePage(state.user!);
          }

          if (state is AuthFailure) {
            showSnackBar(context, state.error!);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            // color: const Color.fromARGB(115, 233, 233, 233),
            child: Form(
              key: _signinFormKey,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        height: 200,
                        child: Lottie.asset('assets/bakery.json',
                            repeat: false, animate: true)),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _userNameController,
                      hintText: 'Kullancı Adı',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Şifre',
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      text: 'Giriş Yap',
                      onTap: () {
                        if (_signinFormKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthLoginRequested(
                                  userLoginParams: UserLoginParams(
                                    userName: _userNameController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                ),
                              );
                        }
                      },
                      color: GlobalVariables.secondaryColor,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _determineHomePage(UserModel user) {
    switch (user.operationClaim) {
      case 1:
        _navigateToPage(DoughListPage.routeName, user);
      case 2:
        _navigateToPage(ProductionPage.routeName, {0: user, 1: null});
      case 3:
        _navigateToPage(ProductionPage.routeName, {0: user, 1: null});
      case 4:
        _navigateToPage(ServiceListPage.routeName, user);
      case 5:
        _navigateToPage(SellAssistancePage.routeName, user);
      case 6:
        _navigateToPage(AdminPage.routeName, user);
      default:
        _navigateToPage(LoginPage.routeName, null);
    }
  }

  _navigateToPage(String routeName, dynamic args) {
    args == null
        ? Navigator.pushNamedAndRemoveUntil(
            context, routeName, (route) => false)
        : Navigator.pushNamedAndRemoveUntil(
            context, routeName, arguments: args, (route) => false);
  }
}
