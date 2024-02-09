import 'package:api/api.dart';
import 'package:ces/l10n/l10n.dart';
import 'package:ces/markets/cubit/markets_cubit.dart';
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
        Expanded(
          child: ListView.builder(
            itemCount: markets.length,
            itemBuilder: (context, index) {
              final market = markets[index];
          
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        market.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        market.baseVolume,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    market.price,
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
                      market.dailyChange,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
