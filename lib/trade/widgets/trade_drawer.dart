import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class DrawerContent extends StatefulWidget {
  const DrawerContent({super.key});

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> tradeList = [
    {'pair': 'BTC', 'price': 45000.0, 'change': 3.5},
    {'pair': 'USD', 'price': 1.0, 'change': -0.5},
    {'pair': 'ETH', 'price': 3500.0, 'change': 1.2},
    {'pair': 'LTC', 'price': 400.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 600.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 800.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 500.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 100.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 150.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 200.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 300.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 400.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 500.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 800.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 900.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 9000.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 90000.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 900000.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 9000009.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 9000009.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 90000099.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 900000999999.0, 'change': -0.8},
    {'pair': 'LTC', 'price': 90000099999900.0, 'change': -1.90},
  ];
  final ScrollController _scrollController = ScrollController();

  String selectedChoice = 'BTC'; // Default selected option
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset((1.0 - _animationController.value) * -300, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width *
                0.6, // Set the desired width
            child: Drawer(
              backgroundColor: AppColors.white,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppSpacing.lg),
                shrinkWrap: true,
                children: [
                  Text(
                    'Spot',
                    style: UITextStyle.headline4,
                  ),
                  const SizedBox(
                    height: AppSpacing.lg,
                  ),

                  // searchbox
                  SizedBox(
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
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          letterSpacing: 1,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                        fillColor: AppColors.white,
                        errorStyle: TextStyle(
                          letterSpacing: 1,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.red,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            color: AppColors.transparent,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            color: AppColors.transparent,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            color: AppColors.transparent,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0,
                            color: AppColors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: AppSpacing.md,
                  ),

                  // Horizontal choice chip list
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: tradeList.map((trade) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedChoice = trade['pair'].toString();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: selectedChoice == trade['pair']
                                    ? const Border(
                                        bottom: BorderSide(
                                          color: AppColors.yellow,
                                          width: 2,
                                        ),
                                      )
                                    : const Border(),
                              ),
                              child: Text(
                                trade['pair'].toString(),
                                style: UITextStyle.subtitle1.copyWith(
                                  color: selectedChoice == trade['pair']
                                      ? AppColors.black
                                      : AppColors.grey.shade600,
                                  fontWeight: selectedChoice == trade['pair']
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                            // ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Divider between horizontal list and trade list
                  const Divider(
                    color: Colors.black,
                    height: 20,
                    thickness: 0.2,
                    indent: 0,
                    endIndent: 0,
                  ),

                  // Header for the trade list
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Pair',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '/',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Change',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Custom list of trades2
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height * .68, // Full height
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        // You can add custom logic here if needed
                        return false;
                      },
                      child: Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        interactive: true,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: AppSpacing.lg,
                          ),
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: tradeList.length,
                          itemBuilder: (context, index) {
                            final trade = tradeList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 1,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 8,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(trade['pair'].toString()),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(trade['price'].toString()),
                                        Text(trade['change'].toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
