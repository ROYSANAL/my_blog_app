import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_blog_app/core/widgets/show_password_text_field.dart';
import 'package:my_blog_app/core/widgets/simple_snack_bar.dart';
import 'package:my_blog_app/domain/remote/models/auth/sign_up_form.dart';
import 'package:my_blog_app/presentation/features/auth/bloc/register/register_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/create_blog/create_blog_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/my_blogs/my_blogs_bloc.dart';
import 'package:my_blog_app/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:my_blog_app/presentation/main/main_screen.dart';

import '../../../../core/res/svgs.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController email;
  late TextEditingController name;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    name = TextEditingController();
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterError) {
                  SimpleSnackBar.show(context, state.error);
                } else if (state is RegisteredSuccessFully) {
                  SimpleSnackBar.show(context, "Registered Successfully");
                  email.clear();
                  password.clear();
                  name.clear();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) =>
                                          MyBlogsBloc(state.userModel.uid),
                                    ),
                                    BlocProvider(
                                      create: (context) => CreateBlogBloc(),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          ProfileBloc(state.userModel.uid),
                                    ),
                                  ],
                                  child: MainScreen(
                                    user: state.userModel,
                                  ))),
                      (route) => false);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      Svgs.signup,
                      height: 250,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 32),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: email,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline),
                          hintText: "Enter your Email",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: name,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline),
                          hintText: "Enter your Name",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ShowPasswordTextField(
                        hint: "Enter your Password", controller: password),
                    const SizedBox(
                      height: 20,
                    ),
                    state is RegisterFormError
                        ? Text(
                            state.error,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox.shrink(), // show only when error
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                        disabledColor: Colors.grey,
                        onPressed:
                            state is RegisterLoading //disable when loading
                                ? null
                                : () {
                                    final form = SignUpForm(
                                      email: email.value.text.trim(),
                                      name: name.value.text.trim(),
                                      password: password.value.text.trim(),
                                    );
                                    context
                                        .read<RegisterBloc>()
                                        .add(RegisterButtonClicked(form));
                                  },
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: Colors.deepOrangeAccent,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "OR",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(child: Divider())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account ?"),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // back to login
                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.w600),
                            )),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
