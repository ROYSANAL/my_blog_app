import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog_app/core/res/project_images.dart';
import 'package:my_blog_app/core/widgets/simple_loader_dialog.dart';
import 'package:my_blog_app/core/widgets/simple_snack_bar.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/presentation/features/auth/bloc/login/login_bloc.dart';
import 'package:my_blog_app/presentation/features/auth/pages/login_page.dart';
import 'package:my_blog_app/presentation/features/blog/widget/blog_list_item.dart';
import 'package:my_blog_app/presentation/features/profile/bloc/profile_bloc.dart';
import 'package:my_blog_app/presentation/features/profile/widget/data_row.dart';

class ProfilePage extends StatefulWidget {
  final UserModel user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    Text(
                      "Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                      textAlign: TextAlign.start,
                    ),
                    Spacer()
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 55,
                    child: Image.asset(ProjectImages.man),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is DataAvailable) {
                        final user = state.user;
                        return Column(
                          children: [
                            DataRowWidget(
                                label: "Name",
                                icon: Icons.person_outline_outlined,
                                data: user.name),
                            DataRowWidget(
                                label: "Email",
                                icon: Icons.mail_outline,
                                data: user.email),
                            DataRowWidget(
                                label: "uid",
                                icon: Icons.lock_outline,
                                data: user.uid),
                            DataRowWidget(
                                label: "joined",
                                icon: Icons.calendar_today,
                                data: CustomDate(user.dateJoined)
                                    .toFormattedString()),
                            DataRowWidget(
                                label: "Blogs",
                                icon: Icons.numbers,
                                data: user.blogsPosted.toString()),
                          ],
                        );
                      } else if (state is UserError) {
                        return Center(
                          child: Text("Date unavailable : ${state.error}"),
                        );
                      } else {
                        return const Center(
                          child: Text("Date unavailable"),
                        );
                      }
                    },
                  ),
                ),
                BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state is LogoutSuccessful) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => LoginBloc(),
                            child: const LoginPage(),
                          ),
                        ),
                        (route) => false,
                      );
                    } else if (state is LogoutError) {
                      Navigator.of(context).pop();
                      SimpleSnackBar.show(context, state.error);
                    } else if (state is LoggingOut) {
                      SimpleLoaderDialog.show(context, "Logging you out");
                    }
                  },
                  builder: (context, state) {
                    return OutlinedButton(
                        onPressed: state is LoggingOut
                            ? null
                            : () {
                                context
                                    .read<ProfileBloc>()
                                    .add(LogOutButtonClicked());
                              },
                        style: const ButtonStyle(
                            side: MaterialStatePropertyAll(
                                BorderSide(color: Colors.red))),
                        child: const Wrap(
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              color: Colors.red,
                            ),
                            Text(
                              "logout",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
