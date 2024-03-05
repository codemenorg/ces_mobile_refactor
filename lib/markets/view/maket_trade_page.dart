import 'package:api/api.dart';
import 'package:app_ui/app_ui.dart';
import 'package:ces/markets/markets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../trade/widgets/trade_drawer.dart';

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

class MarketsTradeView extends StatefulWidget {
  const MarketsTradeView({super.key});

  @override
  State<MarketsTradeView> createState() => _MarketsTradeViewState();
}

class _MarketsTradeViewState extends State<MarketsTradeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer(DrawerContent drawer) {
    _scaffoldKey.currentState?.openDrawer();
  }

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
                drawer: const Drawer(
                  child: DrawerContent(),
                ),
                key: _scaffoldKey,
                body: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      //AppBar
                      Container(
                        height: 60,
                        padding: const EdgeInsets.all(10),
                        color: AppColors.grey.shade300,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back_outlined,
                              weight: 500,
                            ),
                            const SizedBox(
                              width: AppSpacing.md,
                            ),
                            Container(
                              height: 15,
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    width: 2,
                                    color: AppColors.grey.shade400,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: AppSpacing.md,
                            ),
                            InkWell(
                              onTap: () {
                                Future.delayed(
                                    const Duration(microseconds: 200), () {
                                  _openDrawer(const DrawerContent());
                                });
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.currency_pound_outlined),
                                  Text(
                                    'USD/BTC',
                                    style: UITextStyle.subtitle1
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    width: AppSpacing.sm,
                                  ),
                                  Image.asset(
                                    'assets/icons/menu.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.notifications_none,
                              color: AppColors.grey,
                              size: 30,
                            ),
                            const SizedBox(
                              width: AppSpacing.md,
                            ),
                            const Icon(
                              Icons.star_border,
                              color: AppColors.grey,
                              size: 30,
                            ),
                            const SizedBox(
                              width: AppSpacing.md,
                            ),
                            const Icon(
                              Icons.file_upload_outlined,
                              color: AppColors.grey,
                              size: 30,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height -
                            80, // Adjusted height
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
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
                                  Expanded(
                                    child: Row(
                                      children: [
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
                                                      color: AppColors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    '000000000.00',
                                                    style: UITextStyle.caption
                                                        .copyWith(
                                                      color: AppColors.black,
                                                    ),
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
                                                      color: AppColors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    '000000000.00',
                                                    style: UITextStyle.caption
                                                        .copyWith(
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '24h Low',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  '000000000.00',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                    color: AppColors.black,
                                                  ),
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
                                                    color: AppColors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  '000000000.00',
                                                  style: UITextStyle.caption
                                                      .copyWith(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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
                            Container(
                              height: 400,
                              color: Colors.blue,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color: AppColors.grey.shade300,
                                ),
                              ),
                            ),
                            DefaultTabController(
                              length: 2,
                              child: Column(
                                children: [
                                  TabBar(
                                    tabs: const [
                                      Tab(text: 'Order Book'),
                                      Tab(text: 'Market Trade'),
                                    ],
                                    labelColor: AppColors.black,
                                    unselectedLabelColor: AppColors.grey,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height - 80,
                                    child: TabBarView(
                                      children: [
                                        // Order Book Tab
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: 29,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                  'Order Book Item $index'),
                                            );
                                          },
                                        ),

                                        // Market Trade Tab
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: 29,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                  'Market Trade Item $index'),
                                            );
                                          },
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
                    ],
                  ),
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
              Container(
                width: MediaQuery.of(context).size.width / 2.3,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: AppColors.green),
                child: Text(
                  'Buy',
                  textAlign: TextAlign.center,
                  style: UITextStyle.subtitle1.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                width: AppSpacing.lg,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.3,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: AppColors.red),
                child: Text(
                  'Sell',
                  textAlign: TextAlign.center,
                  style: UITextStyle.subtitle1.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w600),
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
