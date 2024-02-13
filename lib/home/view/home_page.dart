import 'package:app_ui/app_ui.dart';
import 'package:ces/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const route = '/Home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: ListView(
        shrinkWrap: true,
        children: [
          // Slider at the top
          const SizedBox(
            height: 150,
            child: Placeholder(), // Replace with your slider widget
          ),
          const SizedBox(
            height: AppSpacing.lg,
          ),
          // Horizontal list with items
          SizedBox(
            height: 120,
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              separatorBuilder: (context, index) => const SizedBox(
                width: AppSpacing.xxlg,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Replace with your item count
              itemBuilder: (context, index) {
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Crypto Name'),
                    Text(r'Price: $100'),
                    Text('24h Change: +5%'),
                  ],
                );
              },
            ),
          ),
          // Custom header row
          Container(
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                Text(
                  'Pair',
                  textAlign: TextAlign.start,
                ),
                Spacer(),
                Text(
                  'Price',
                ),
                Spacer(),
                Text(
                  '24h Change',
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          // List with data
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            itemCount: 50, // Replace with your item count
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Crypto Pair $index',
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const Spacer(),
                    const Expanded(
                      child: Text(
                        r'$100',
                      ),
                    ),
                    const Spacer(),
                    const Expanded(
                      child: Text(
                        '+5%',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
