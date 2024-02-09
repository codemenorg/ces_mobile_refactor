import 'package:api/api.dart';
import 'package:ces/counter/counter.dart';
import 'package:ces/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/markets_cubit.dart';

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
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
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
              return buildPostListView(state.markets);
            }

            return const Center(
              child: Text('Something went wrong!'),
            );
          },
        ),
      ),
    );
  }

  Widget buildPostListView(List<Market> markets) {
    return Column(
      children: [
        Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: Color.fromARGB(255, 222, 230, 235)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pair / Vol',
                      style: TextStyle(color: Colors.black),
                    ),
                    Spacer(),
                    Text(
                      'Price',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      'Change',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
        ListView.builder(
          itemCount: markets.length,
          itemBuilder: (context, index) {
            Market market = markets[index];
        
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      market.name.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      market.baseVolume.toString(),
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  market.price.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                Container(
                  width: 60,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.blue,
                  ),
                  child: Text(
                    market.dailyChange.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.displayLarge);
  }
}
