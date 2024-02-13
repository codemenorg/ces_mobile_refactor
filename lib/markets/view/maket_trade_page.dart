import 'package:api/api.dart';
import 'package:app_ui/app_ui.dart';
import 'package:ces/l10n/l10n.dart';
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
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.marketAppBarTitle)),
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
              return buildContent(state.marketDetail.data!.marketTrades!);
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
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.blue),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))))),
                    onPressed: () {},
                    child: Text(
                      'Buy',
                      textAlign: TextAlign.center,
                      style: UITextStyle.subtitle1.copyWith(
                        color: AppColors.black,
                        fontSize: 16,
                        height: 0,
                      ),
                    )),
              ),
              const SizedBox(
                width: AppSpacing.lg,
              ),
              SizedBox(
                width: 160,
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.red),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))))),
                    onPressed: () {},
                    child: Text(
                      'Sell',
                      textAlign: TextAlign.center,
                      style: UITextStyle.subtitle1.copyWith(
                        color: AppColors.black,
                        fontSize: 16,
                        height: 0,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(List<MarketTrade> marketTrades) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Big text on the left
          const Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Big Text on the Left',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              // Four texts on the right
              Expanded(
                child: Row(
                  children: [
                    // First and Second Texts side by side
                    Expanded(
                      child: Column(
                        children: [
                          Center(child: Text('Text 1')),
                          Center(child: Text('Text 2')),
                        ],
                      ),
                    ),
                    // Spacer to create space between the two pairs
                    SizedBox(width: 16),
                    // Third and Fourth Texts on a new line
                    Expanded(
                      child: Column(
                        children: [
                          Center(child: Text('Text 3')),
                          Center(child: Text('Text 4')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSpacing.xlg,
          ),
          // Candle Chart
          Expanded(
            child: Container(
              // Replace this with your candle chart widget
              color: Colors.blue,
            ),
          ),
          // TabBar with Order Book and Market Trade
          const Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Order Book'),
                      Tab(text: 'Market Trade'),
                    ],
                  ),
                  // Content for each tab
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Order Book content
                        // Market Trade content
                        Center(
                          child: Text('Market Trade Content'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
