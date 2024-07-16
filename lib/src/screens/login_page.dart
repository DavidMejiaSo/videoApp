import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../design_tools/tool_widgets/app_buttons.dart';
import '../../design_tools/tool_widgets/app_colors.dart';
import '../../design_tools/tool_widgets/spacing.dart';
import '../../design_tools/tool_widgets/tool_widgets.dart';
import '../providers/authentication_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showSnackbar(BuildContext context, String message) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    //ref.listen(authProvider, (previous, next) {
    //  if (next.errorMessage.isEmpty) return;
    //  showSnackbar(context, next.errorMessage);
    ////});
    // Future<void> _launchInBrowser(Uri url) async {
    //   if (!await launchUrl(
    //     url,
    //     mode: LaunchMode.externalApplication,
    //   )) {
    //     throw Exception('Could not launch $url');
    //   }
    // }
    String email = '';
    String password = '';
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              color: AppColors.white,
              child: Column(
                children: [
                  //-----------------------------------------------------------
                  //----------------------------Zona del logo-------------------//
                  AppWidgets.mainLogo(context, 62, 40),

                  //------------------------Bienvenido mensaje------------------------//
                  AppWidgets.mainText(context, "VideoApp", 6),
                  //_------------Mensaje de registro o login-----//
                  Spacing.vertical(8),

                  AppWidgets.smallText(
                      context,
                      "Connect and share your videos with the community. Please log in or sign up to continue in our app.",
                      3,
                      textAlign: TextAlign.left),

                  //----------------------------------------------//
                  Spacing.vertical(11),

                  Row(
                    children: [
                      AppWidgets.mainText(context, "E-mail", 4),
                    ],
                  ),
                  //----------------------------------------Zona de ingreso de usuario
                  Spacing.vertical(20),
                  Container(
                    //Container de el Usuario
                    color: AppColors.grey.withOpacity(0.4),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: TextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          labelText: "E-mail",
                          labelStyle: TextStyle(
                            color: AppColors.black,
                          ),

                          // Nuevo campo para mostrar el mensaje de error
                        ),
                        // onChanged:
                        //     ref.read(LoginFormProvider.notifier).onEmailChange,
                      ),
                    ),
                  ),
                  //-----------------------------------------------
                  Spacing.vertical(20),
                  Row(
                    children: [
                      AppWidgets.mainText(context, "Password", 4),
                    ],
                  ),
                  //-------------------------------------------- zona de ingreso de contraseña
                  Spacing.vertical(20),
                  //Aquí va la password
                  Container(
                    //Container del TextFormField de la contraseña
                    color: AppColors.grey.withOpacity(0.4),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      // obscureText: ref.watch(obscure_text_login),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: AppColors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: AppColors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        labelText: "Password",
                        labelStyle: const TextStyle(
                          color: AppColors.black,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                            child: const Icon(
                              color: AppColors.black,
                              Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //------------------------------------------------------Zona de boton de registro
                  Spacing.vertical(20), //Boton SigIn
                  AppButtons().blackButton(
                    texto: "Login",
                    context: context,
                    onPressed: () async {
                      ref
                          .watch(authProvider.notifier)
                          .loginUser(email, password);
                    },
                    primaryColor: AppColors.red.withOpacity(0.4),
                    textColor: AppColors.white,
                    fontSize: 4,
                    horizontalPadding: 34,
                    verticalPadding: 1,
                  ),

                  //-------------------------------------------------------Boton de ingreso
                  Spacing.vertical(20),
                  GestureDetector(
                    onTap: () async {
                      GoRouter.of(context).go('/registerPage');
                      //print("EPA");
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppWidgets.smallText(context, "Create an account", 4),
                          Spacing.horizontal(1),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Tap here.",
                              style: TextStyle(
                                color: AppColors.red,
                                decoration: TextDecoration.none,
                                fontFamily: 'Syne',
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //----------------------------------------------------------- Botones de ingreso con Facebook y Google

                  //---------------------------------------------------------------------

                  //-----------------------------------------

                  //_------------------------------------------

                  Spacing.vertical(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
