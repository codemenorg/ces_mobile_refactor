import 'package:app_ui/app_ui.dart';
import 'package:ces/l10n/l10n.dart';
import 'package:ces/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const route = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      // appBar: AppBar(title: Text(l10n.profileAppBarTitle)),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadingError) {
            final snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            final userInfo = state.profile.data!.getProfileById!;
            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                //Profile view
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: AppColors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  userInfo.image!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 3,
                                bottom: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: AppColors.white),
                                  child: Center(
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: userInfo.status == 'ACTIVE'
                                            ? AppColors.green
                                            : AppColors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: AppSpacing.md,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userInfo.firstName!} ${userInfo.lastName!}',
                                style: UITextStyle.headline4,
                              ),
                              const SizedBox(
                                height: AppSpacing.xxxs,
                              ),
                              Text(
                                userInfo.email!,
                                style: UITextStyle.subtitle1,
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: AppSpacing.lg,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: AppColors.yellow,
                        ),
                        child: Text(
                          'KYC Verification',
                          style: UITextStyle.subtitle1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSpacing.xlg,
                ),
                Text(
                  'Preference',
                  style: UITextStyle.subtitle1,
                ),
                const SizedBox(
                  height: AppSpacing.lg,
                ),
                Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: AppColors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(Icons.currency_exchange),
                        const SizedBox(
                          width: AppSpacing.lg,
                        ),
                        Text(
                          'BTC/USD',
                          style: UITextStyle.subtitle1,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.md,
                ),
                Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: AppColors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(Icons.lock),
                        const SizedBox(
                          width: AppSpacing.lg,
                        ),
                        Text(
                          'Google 2FA',
                          style: UITextStyle.subtitle1,
                        ),
                        const Spacer(),
                        const Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.md,
                ),
                Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: AppColors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(Icons.password),
                        const SizedBox(
                          width: AppSpacing.lg,
                        ),
                        Text(
                          'Change Password',
                          style: UITextStyle.subtitle1,
                        ),
                        const Spacer(),
                        const Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.md,
                ),
                Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: AppColors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(Icons.history),
                        const SizedBox(
                          width: AppSpacing.lg,
                        ),
                        Text(
                          'Recent Activities',
                          style: UITextStyle.subtitle1,
                        ),
                        const Spacer(),
                        const Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.md,
                ),
                Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: AppColors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(Icons.logout),
                        const SizedBox(
                          width: AppSpacing.lg,
                        ),
                        Text(
                          'Log Out',
                          style: UITextStyle.subtitle1,
                        ),
                        const Spacer(),
                        const Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text('Something went wrong!'),
          );
        },
      ),
    );
  }
}
