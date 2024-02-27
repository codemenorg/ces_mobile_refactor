import 'package:app_ui/app_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ces/wallet/cubit/wallets_cubit.dart';
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
      create: (_) => WalletsCubit(),
      child: const WalletView(),
    );
  }
}

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WalletsCubit, WalletsState>(
        listener: (context, state) {
          if (state is WalletsLoadingError) {
            final snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is WalletsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WalletsLoaded) {
            var item = state.walletList.data!.wallet;
            return ListView(
              // padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                Container(
                  // height: 160,
                  padding: const EdgeInsets.all(10),
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
                          Row(
                            children: [
                              Text(
                                'Total Balance ',
                                style: UITextStyle.subtitle1,
                              ),
                              Text(
                                '(${item!.first.wallet!.currencySymbol})',
                                style: UITextStyle.caption,
                              ),
                            ],
                          ),
                          Text(
                            item.first.wallet!.balance.toString(),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
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
                  itemCount: item.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    var walletItem = item[index].wallet;
                    return Card(
                      margin: const EdgeInsets.all(5),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              key: UniqueKey(),
                              imageUrl: walletItem!.icon!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppColors.yellow,
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.white,
                                child: const Icon(
                                  Icons.error,
                                  color: AppColors.red,
                                  size: 10,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: AppSpacing.lg,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(walletItem.currencySymbol.toString()),
                                Text(walletItem.name.toString()),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(walletItem.balance.toString()),
                                Text(walletItem.onOrder.toString()),
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
