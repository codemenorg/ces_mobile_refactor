import 'package:app_ui/app_ui.dart';
import 'package:ces/wallet/cubit/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});
  static const route = '/wallet';

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletCubit(),
      child: const WalletView(),
    );
  }
}

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        children: [
          Container(
            // height: 160,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: AppColors.primaryContainer,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance (BTC)',
                      style: UITextStyle.subtitle1,
                    ),
                    Text(
                      '200.00',
                      style: UITextStyle.headline2,
                    ),
                    const SizedBox(
                      height: AppSpacing.md,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: AppColors.yellow),
                          ),
                          child: Text(
                            'Deposit',
                            style: UITextStyle.button.copyWith(),
                          ),
                        ),
                        const SizedBox(
                          width: AppSpacing.md,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 15,
                            right: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: AppColors.yellow),
                          ),
                          child: Text(
                            'Withdraw',
                            style: UITextStyle.button.copyWith(),
                          ),
                        ),
                      ],
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
            height: AppSpacing.xs,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(5),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Image.network(
                        'https://i.pinimg.com/originals/9c/14/52/9c1452dcf07b020b8ded12827c07b449.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        width: AppSpacing.lg,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('USD'),
                          Text('USDT'),
                        ],
                      ),
                      const Spacer(),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('0.00'),
                          Text(r'~~$0.00'),
                        ],
                      ),
                      const SizedBox(
                        width: AppSpacing.lg,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
