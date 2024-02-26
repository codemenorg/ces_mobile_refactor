import 'package:api/api.dart';
import 'package:app_ui/app_ui.dart';
import 'package:ces/markets/markets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketsTradePage extends StatelessWidget {
  const MarketsTradePage({required this.marketId, super.key});
  static const route = '/market-detail';
  final String marketId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MarketTradeCubit(marketId: marketId),
      child: const MarketsTradeView(),
    );
  }
}

class MarketsTradeView extends StatelessWidget {
  const MarketsTradeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<MarketTradeCubit, MarketTradeState>(
          listener: (context, state) {
            if (state is MarketTradeLoadingError) {
              final snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state is MarketTradeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MarketTradeLoaded) {
              var item = state.marketDetail.data!.marketTrades!;
              return Scaffold(
                body: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    //appbar
                    SliverAppBar(
                      backgroundColor: AppColors.grey.shade400,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.canPop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ), // Left icon
                      leadingWidth: 40,
                      centerTitle: true,
                      title: const Row(
                        children: [
                          Icon(Icons.biotech),
                          Text('usd/btc'),
                          SizedBox(
                            width: AppSpacing.xs,
                          ),
                          Icon(Icons.menu),
                        ],
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.notifications), // Right icon
                          onPressed: () {
                            // Handle notification icon tap
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.star_border), // Right icon
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.file_upload_outlined,
                          ), // Right icon
                          onPressed: () {},
                        ),
                      ],
                      floating: true,
                      expandedHeight: 60,
                      pinned: true,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          // Big text on the left
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '0000000.00000',
                                        style: UITextStyle.headline4,
                                      ),
                                      const SizedBox(
                                        height: AppSpacing.sm,
                                      ),
                                      Text(
                                        '-24.55%',
                                        style: UITextStyle.subtitle2
                                            .copyWith(color: AppColors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                // Four texts on the right
                                Expanded(
                                  child: Row(
                                    children: [
                                      // First and Second Texts side by side
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '24h High',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                          color:
                                                              AppColors.grey),
                                                ),
                                                Text(
                                                  '000000000.00',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                          color:
                                                              AppColors.black),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: AppSpacing.md,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '24h vol',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                          color:
                                                              AppColors.grey),
                                                ),
                                                Text(
                                                  '000000000.00',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                          color:
                                                              AppColors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Spacer to create space between the two pairs
                                      const SizedBox(width: 16),
                                      // Third and Fourth Texts on a new line
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '24h Low',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                          color:
                                                              AppColors.grey),
                                                ),
                                                Text(
                                                  '000000000.00',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                          color:
                                                              AppColors.black),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: AppSpacing.md,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '24h vol',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                          color:
                                                              AppColors.grey),
                                                ),
                                                Text(
                                                  '000000000.00',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                          color:
                                                              AppColors.black),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppSpacing.xlg,
                          ),
                          // Candle Chart
                          Container(
                            height: 400,
                            // Replace this with your candle chart widget
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            height: AppSpacing.lg,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: Text('Something went wrong!'),
            );
          },
        ),
      ),
      bottomSheet: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: AppColors.modalBackground,
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.green),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Buy',
                    textAlign: TextAlign.center,
                    style: UITextStyle.subtitle1.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: AppSpacing.lg,
              ),
              SizedBox(
                width: 160,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.red),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Sell',
                    textAlign: TextAlign.center,
                    style: UITextStyle.subtitle1.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(List<MarketTrade> marketTrades) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [],
      ),
    );
  }
}
