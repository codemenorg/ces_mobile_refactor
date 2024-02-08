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
    return ListView.builder(
      itemCount: markets.length,
      itemBuilder: (context, index) {
        Market market = markets[index];

        return ListTile(
          title: Text(market.name.toString()),
          subtitle: Text(market.price.toString()),
        );
      },
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
