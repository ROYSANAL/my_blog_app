import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_blog_app/core/res/svgs.dart';
import 'package:my_blog_app/core/widgets/show_password_text_field.dart';
import 'package:my_blog_app/core/widgets/simple_snack_bar.dart';
import 'package:my_blog_app/domain/remote/models/auth/login_form.dart';
import 'package:my_blog_app/presentation/features/auth/bloc/register/register_bloc.dart';
import 'package:my_blog_app/presentation/features/auth/pages/register_page.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/create_blog/create_blog_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/my_blogs/my_blogs_bloc.dart';
import 'package:my_blog_app/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:my_blog_app/presentation/main/main_screen.dart';

import '../bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginError) {
                  SimpleSnackBar.show(context, state.error);
                } else if (state is LoggedInSuccessfully) {
                  email.clear();
                  password.clear();
                  SimpleSnackBar.show(context, "logged in");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) =>
                                          MyBlogsBloc(state.user.uid),
                                    ),
                                    BlocProvider(
                                      create: (context) => CreateBlogBloc(),
                                    ),
                                    BlocProvider(
                                      create: (context) =>
                                          ProfileBloc(state.user.uid),
                                    ),
                                  ],
                                  child: MainScreen(
                                    user: state.user,
                                  ))),
                      (route) => false);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      Svgs.login,
                      height: 300,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Log In",
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
                      height: 24,
                    ),
                    ShowPasswordTextField(
                        hint: "Enter your Password", controller: password),
                    const SizedBox(
                      height: 20,
                    ),
                    state is LoginFormError
                        ? Text(
                            state.error,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                        disabledColor: Colors.grey,
                        onPressed: state is LoginLoading
                            ? null
                            : () {
                                final form = LoginForm(
                                  email: email.value.text.trim(),
                                  password: password.value.text.trim(),
                                );
                                context
                                    .read<LoginBloc>()
                                    .add(LoginButtonClicked(form));
                              },
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: Colors.deepOrangeAccent,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: const Text(
                          "Login",
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
                        const Text("Don't have an account ?"),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => RegisterBloc(),
                                  child: const RegisterPage(),
                                ),
                              ));
                            },
                            child: const Text(
                              "Sign Up",
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
