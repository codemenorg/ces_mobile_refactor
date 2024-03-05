import 'package:app_ui/app_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ces/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/view/bottom_nav_bar.dart';
import '../../profile/view/profile_page.dart';

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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> images = [
    'http://ces.codemen.org/img/single-blog-img1.8b2e1843.jpg',
    'http://ces.codemen.org/img/single-blog-img1.8b2e1843.jpg',
    'http://ces.codemen.org/img/single-blog-img1.8b2e1843.jpg',
    'http://ces.codemen.org/img/single-blog-img1.8b2e1843.jpg',
    // Add more image URLs as needed
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadingError) {
            final snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomeLoaded) {
            final list = state.home.data;
            return Scaffold(
              body: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColors.white,
                    leading: Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        bottom: 10,
                        top: 10,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.surface2,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            NavigationScreen.route,
                            arguments: const ProfilePage(),
                          );
                        },
                        child: const Icon(Icons.person_2_outlined),
                      ),
                    ), // Left icon
                    leadingWidth: 40,
                    centerTitle: true,
                    title: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          cursorColor: AppColors.primaryContainer,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            letterSpacing: 1,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            hintText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            hintStyle: const TextStyle(
                              letterSpacing: 1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey,
                            ),
                            // fillColor: AppColors.background,
                            errorStyle: const TextStyle(
                              letterSpacing: 1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.red,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                color: AppColors.black.withOpacity(.5),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ), // Centered search bar
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.notifications), // Right icon
                        onPressed: () {
                          // Handle notification icon tap
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.qr_code_scanner), // Right icon
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
                        // Slider at the top
                        Stack(
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                autoPlay: true,
                                height: 200,
                                autoPlayInterval: const Duration(seconds: 2),
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                              items: images
                                  .asMap()
                                  .entries
                                  .map((MapEntry<int, String> entry) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Image.network(
                                      entry.value,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.grey),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '${_current + 1} ',
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      '/ ${images.length}',
                                      style: const TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                            padding: const EdgeInsets.all(10),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: AppSpacing.xxlg,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                list.length, // Replace with your item count
                            itemBuilder: (context, index) {
                              final topData = list[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(topData.name),
                                  Text(formatNum(topData.price)),
                                  Text(
                                    '24h Change: ${formatString(topData.dailyChange)}',
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        Container(
                          height: 10,
                          decoration:
                              BoxDecoration(color: AppColors.grey.shade200),
                        ),
                        const SizedBox(
                          height: AppSpacing.md,
                        ),
                        //option
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/icons/deposit.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Deposit',
                                    style: UITextStyle.subtitle1,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/icons/buy.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Buy Crypto',
                                    style: UITextStyle.subtitle1,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/icons/p2p.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'P2P',
                                    style: UITextStyle.subtitle1,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/icons/earn.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Earn',
                                    style: UITextStyle.subtitle1,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/icons/margin.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  Text(
                                    'Margin',
                                    style: UITextStyle.subtitle1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: AppSpacing.md,
                        ),
                        //other option
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Epic Airdrop',
                                            style: UITextStyle.headline6
                                                .copyWith(fontSize: 16),
                                          ),
                                          Text(
                                            'come and grab',
                                            style: UITextStyle.caption.copyWith(
                                              color: AppColors.grey,
                                            ),
                                          ),
                                          Text(
                                            'your rewards',
                                            style: UITextStyle.caption.copyWith(
                                              color: AppColors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Image.asset(
                                        'assets/icons/epic_airdrop.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: AppSpacing.xs,
                              ),
                              Flexible(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Refer Friends',
                                            style: UITextStyle.headline6
                                                .copyWith(fontSize: 16),
                                          ),
                                          Text(
                                            'Up to 60%',
                                            style: UITextStyle.caption.copyWith(
                                              color: AppColors.grey,
                                            ),
                                          ),
                                          Text(
                                            'commission',
                                            style: UITextStyle.caption.copyWith(
                                              color: AppColors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Image.asset(
                                        'assets/icons/refer.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: AppSpacing.lg,
                        ),
                        Container(
                          height: 10,
                          decoration:
                              BoxDecoration(color: AppColors.grey.shade200),
                        ),

                        const SizedBox(
                          height: AppSpacing.md,
                        ),
                        // Custom header row
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pair / Vol',
                                style: UITextStyle.subtitle2
                                    .copyWith(color: AppColors.grey.shade400),
                              ),
                              const Spacer(),
                              Text(
                                'Price',
                                style: UITextStyle.subtitle2
                                    .copyWith(color: AppColors.grey.shade400),
                              ),
                              const SizedBox(
                                width: AppSpacing.xxlg,
                              ),
                              Text(
                                'Change',
                                style: UITextStyle.subtitle2
                                    .copyWith(color: AppColors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                        // List with data
                        ListView.separated(
                          separatorBuilder: (context, index) => Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: .05),
                                ),
                              ),
                            ],
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          // padding: const EdgeInsets.all(AppSpacing.md),
                          itemCount:
                              list.length, // Replace with your item count
                          itemBuilder: (context, index) {
                            final listData = list[index];
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                // margin: const EdgeInsets.all(AppSpacing.sm),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listData.name,
                                          style: UITextStyle.subtitle2
                                              .copyWith(color: AppColors.black),
                                        ),
                                        Text(
                                          listData.baseVolume,
                                          style: UITextStyle.subtitle2
                                              .copyWith(color: AppColors.black),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      formatNum(listData.price),
                                      style: UITextStyle.subtitle2
                                          .copyWith(color: AppColors.black),
                                    ),
                                    const SizedBox(
                                      width: AppSpacing.lg,
                                    ),
                                    Container(
                                      width: 70,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        color: double.parse(
                                                  listData.dailyChange,
                                                ) <
                                                0
                                            ? AppColors.red
                                            : AppColors.green,
                                      ),
                                      child: Text(
                                        '${formatAmountAndAbbreviate(listData.dailyChange)}%',
                                        // market.id,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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

  String? formatAmountAndAbbreviate(String? stringValue) {
    // Convert the string to a double
    double? value = double.tryParse(stringValue!) ?? 0;

    if (value.abs() < 1e-10) {
      return "0";
    }

    if (value >= 1000000) {
      double? result = value / 1000000;
      return '${result.toStringAsFixed(2)}M';
    } else if (value >= 1000) {
      double? result = value / 1000;
      return '${result.toStringAsFixed(2)}K';
    } else {
      // Use toStringAsFixed to format the number with the desired precision
      return value
          .toStringAsFixed(3)
          .replaceAll(RegExp(r"(\.0+|(?<=\.\d)0+)$"), "");
    }
  }
}
