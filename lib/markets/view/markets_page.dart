import 'package:api/api.dart';
import 'package:app_ui/app_ui.dart';
import 'package:ces/l10n/l10n.dart';
import 'package:ces/markets/cubit/markets_cubit.dart';
import 'package:ces/markets/view/maket_trade_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketsPage extends StatelessWidget {
  const MarketsPage({super.key});
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MarketsCubit(),
      child: const MarketsView(),
    );
  }
}

class MarketsView extends StatelessWidget {
  const MarketsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.marketAppBarTitle)),
      body: SafeArea(
        child: BlocConsumer<MarketsCubit, MarketsState>(
          listener: (context, state) {
            if (state is MarketsLoadingError) {
              final snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state is MarketsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MarketsLoaded) {
              return buildPostListView(state.market.data);
            }

            return const Center(
              child: Text('Something went wrong!'),
            );
          },
        ),
      ),
    );
  }

  Widget buildPostListView(List<Datum> markets) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 222, 230, 235)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pair / Vol',
                style: UITextStyle.subtitle2.copyWith(),
              ),
              const Spacer(),
              Text(
                'Price',
                style: UITextStyle.subtitle2.copyWith(),
              ),
              const SizedBox(
                width: AppSpacing.lg,
              ),
              Text(
                '24h Change',
                style: UITextStyle.subtitle2.copyWith(),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Column(
              children: [
                SizedBox(
                  height: AppSpacing.sm,
                ),
                Divider(),
                SizedBox(
                  height: AppSpacing.sm,
                ),
              ],
            ),
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: markets.length,
            itemBuilder: (context, index) {
              final market = markets[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MarketsTradePage.route,
                    arguments: MarketTrades(
                      marketId: market.id,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          market.name,
                          style: UITextStyle.subtitle2
                              .copyWith(color: AppColors.black),
                        ),
                        Text(
                          market.baseVolume,
                          style: UITextStyle.subtitle2
                              .copyWith(color: AppColors.black),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      formatNum(market.price),
                      style: UITextStyle.subtitle2
                          .copyWith(color: AppColors.black),
                    ),
                    const SizedBox(
                      width: AppSpacing.xxlg,
                    ),
                    Container(
                      width: 60,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.blue,
                      ),
                      child: Text(
                        '${formatString(market.dailyChange)}%',
                        // market.id,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //format price
  String formatNum(String value) {
    // Convert the double to a string
    String stringValue = value.toString();

    // Split the string into parts before and after the decimal point
    List<String> parts = stringValue.split('.');

    // Take the full number of digits before the decimal point
    String result = parts[0];

    // If there is a decimal part, take up to 8 digits
    if (parts.length > 1) {
      String decimalPart = parts[1].substring(0, 8);

      // Check if all digits in the decimal part are 0
      if (int.parse(decimalPart) != 0) {
        result += '.' + decimalPart;
      }
    }

    return result;
  }

  //format changes
  String formatString(String numberString) {
    double number = double.parse(numberString);
    String formattedNumber = number.toStringAsFixed(2);
    formattedNumber =
        formattedNumber.replaceAll(RegExp(r'(\.0+|(?<=\.\d)0+)$'), '');
    return formattedNumber;
  }
}
