import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_app/infrastructure/entities/user.dart';
import 'package:video_app/src/providers/authentication_provider.dart';
import '../../design_tools/tool_widgets/app_buttons.dart';
import '../../design_tools/tool_widgets/app_colors.dart';
import '../../design_tools/tool_widgets/spacing.dart';
import '../../design_tools/tool_widgets/tool_widgets.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  File? _image;
  String _name = "";
  String _email = "";
  String _password = "";

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                color: AppColors.white,
                child: Column(
                  children: [
                    //------------------------Bienvenido mensaje
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 16),
                          child: AppButtons().whiteButton(
                            icon: Icons.arrow_back,
                            context: context,
                            onPressed: () {
                              GoRouter.of(context).go('/loginPage');
                            },
                            fontSize: 5,
                            horizontalPadding: 4,
                            verticalPadding: 1,
                          ),
                        ),
                      ],
                    ),
                    // Contenido de la página
                    //----------------------------Zona del logo
                    AppWidgets.mainLogo(context, 75, 30),
                    //-------------------------------------

                    Row(
                      children: [
                        AppWidgets.mainText(context, "Register", 6),
                      ],
                    ),
                    //_--------------------------------------------Mensaje de registro o login
                    Spacing.vertical(2),

                    Row(
                      children: [
                        AppWidgets.smallText(context, "Create your account", 4),
                      ],
                    ),

                    //-------------------------------------------
                    Spacing.vertical(10),

                    Row(
                      children: [
                        AppWidgets.mainText(context, "Name ", 4),
                      ],
                    ),

                    //-------------------------------------------
                    Spacing.vertical(10),
                    Container(
                      //Container del Nombre
                      color: const Color.fromARGB(255, 235, 235, 235),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                        child: TextFormField(
                          onChanged: (value) {
                            _name = value;
                          },
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: AppColors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            labelText: "Name",
                            labelStyle: const TextStyle(),
                          ),
                        ),
                      ),
                    ),
                    //---------------------------------------
                    Spacing.vertical(10),

                    Row(
                      children: [
                        AppWidgets.mainText(context, "Email", 4),
                      ],
                    ),

                    //-------------------------------------------
                    Spacing.vertical(10),
                    Container(
                      //Container del Email
                      color: const Color.fromARGB(255, 235, 235, 235),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                        child: TextFormField(
                          onChanged: (value) {
                            _email = value;
                          },
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: AppColors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            labelText: "Email",
                            labelStyle: const TextStyle(),
                          ),
                        ),
                      ),
                    ),

                    Spacing.vertical(10),

                    Row(
                      children: [
                        AppWidgets.mainText(context, "Password", 4),
                      ],
                    ),

                    Spacing.vertical(10),
                    Container(
                      //Container del Password
                      color: const Color.fromARGB(255, 235, 235, 235),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                        child: TextFormField(
                          onChanged: (value) {
                            _password = value;
                          },
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: AppColors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            labelText: "Password",
                            labelStyle: const TextStyle(),
                          ),
                        ),
                      ),
                    ),

                    Spacing.vertical(10),

                    //---------------------------------------
                    Spacing.vertical(10),

                    Row(
                      children: [
                        AppWidgets.mainText(context, "Profile Picture", 4),
                      ],
                    ),

                    Spacing.vertical(10),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        color: const Color.fromARGB(255, 235, 235, 235),
                        width: MediaQuery.of(context).size.width * 0.9,
                        // height: 150,
                        child: Center(
                          child: _image == null
                              ? const Text("Tap to select an image")
                              : Image.file(_image!, fit: BoxFit.cover),
                        ),
                      ),
                    ),

                    Spacing.vertical(10),

                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.1, // Ajusta el ancho del checkbox
                          height: MediaQuery.of(context).size.width *
                              0.1, // Ajusta la altura del checkbox
                          child: Checkbox(
                            value:
                                true, // Cambia este valor para cambiar el estado del checkbox
                            onChanged: (bool? newValue) {
                              setState(() {});
                            },
                            activeColor: AppColors
                                .white, // Define el color de la marca de verificación
                            checkColor: AppColors
                                .red, // Define el color de fondo del checkbox
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              AppWidgets.smallText(
                                  context, "Accept terms and conditions.", 3),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              AppWidgets.smallText(context, "Click here", 3,
                                  color: AppColors.red)
                            ],
                          ),
                        )
                      ],
                    ),

                    //----------------------------------------------
                    Spacing.vertical(10),
                    AppButtons().blackButton(
                      context: context,
                      texto: "Register",
                      onPressed: () async {
                        final newUser = NewUser(
                            name: _name,
                            email: _email,
                            password: _password,
                            profilePhoto: _image!);

                        ref.watch(authProvider.notifier).registerUser(newUser);
                        // Aquí puedes implementar la lógica para registrar al usuario
                      },
                      primaryColor: AppColors.red.withOpacity(0.6),
                      textColor: AppColors.white,
                      fontSize: 4,
                      horizontalPadding: 34,
                      verticalPadding: 1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
