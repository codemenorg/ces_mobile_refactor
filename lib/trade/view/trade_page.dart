// ignore_for_file: lines_longer_than_80_chars, join_return_with_assignment

import 'package:app_ui/app_ui.dart';
import 'package:ces/trade/cubit/trade_cubit.dart';
import 'package:ces/trade/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/trade_drawer.dart';

class TradePage extends StatefulWidget {
  const TradePage({super.key});
  static const route = '/trade';

  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TradeCubit(),
      child: const TradeView(),
    );
  }
}

class TradeView extends StatefulWidget {
  const TradeView({super.key});

  @override
  State<TradeView> createState() => _TradeViewState();
}

class _TradeViewState extends State<TradeView> {
  // double _sliderValue = 0;
  String dropdownAmountValue = 'Amount';
  bool validation = false;
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController stopController = TextEditingController();
  TextEditingController limitController = TextEditingController();
  bool colorShift = true;
  String buttonText = 'Buy';
  String dropDownText = 'Limit';
  String filterOrder = 'All Order';

  final GlobalKey _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double _value = 0;

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    void _openDrawer(DrawerContent drawer) {
      _scaffoldKey.currentState?.openDrawer();
    }

    return Scaffold(
      drawer: const Drawer(
        child: DrawerContent(),
      ),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.all(10),
              color: AppColors.grey.shade300,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Future.delayed(const Duration(microseconds: 200), () {
                        _openDrawer(const DrawerContent());
                      });
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/menu.png',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                          width: AppSpacing.md,
                        ),
                        Text(
                          'USD/BTC',
                          style: UITextStyle.headline6,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/icons/trend.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(
                    width: AppSpacing.xlg,
                  ),
                  InkWell(
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        transitionDuration: const Duration(microseconds: 5000),
                        barrierLabel:
                            MaterialLocalizations.of(context).dialogLabel,
                        barrierColor: AppColors.black.withOpacity(0.5),
                        pageBuilder: (context, _, __) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Featured',
                                          style: UITextStyle.headline6
                                              .copyWith(color: AppColors.black),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Icon(Icons.close)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: AppSpacing.lg,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TradeFeatured(
                                            image: 'assets/icons/deposit.png',
                                            text: 'Deposit',
                                            textStyle: UITextStyle.labelSmall
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          TradeFeatured(
                                            image: 'assets/icons/transfer.png',
                                            text: 'Transfer',
                                            textStyle: UITextStyle.labelSmall
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          TradeFeatured(
                                            image: 'assets/icons/options.png',
                                            text: 'Preference',
                                            textStyle: UITextStyle.labelSmall
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          TradeFeatured(
                                            image: 'assets/icons/power.png',
                                            text: 'Insurance Fund',
                                            textStyle: UITextStyle.labelSmall
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          TradeFeatured(
                                            image: 'assets/icons/analytics.png',
                                            text:
                                                'Interest Rate & Borrow Limit',
                                            textStyle: UITextStyle.labelSmall
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: AppSpacing.lg,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TradeFeatured(
                                            image: 'assets/icons/percent.png',
                                            text: 'Margin Parameters',
                                            textStyle: UITextStyle.labelSmall
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          TradeFeatured(
                                            image: 'assets/icons/guide.png',
                                            text: 'Beginners Guide',
                                            textStyle: UITextStyle.labelSmall
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          TradeFeatured(
                                            image: 'assets/icons/faq.png',
                                            text: 'FAQ',
                                            textStyle: UITextStyle.labelSmall
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors.grey),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: const Icon(
                                                  Icons.star_border_outlined,
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: AppSpacing.sm,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5.5,
                                                child: Text(
                                                  'Favourite',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: UITextStyle.labelSmall
                                                      .copyWith(
                                                          color:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors.grey),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: const Icon(
                                                  Icons
                                                      .notifications_none_outlined,
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: AppSpacing.sm,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5.5,
                                                child: Text(
                                                  'Ticker Alerts',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  style: UITextStyle.labelSmall
                                                      .copyWith(
                                                          color:
                                                              AppColors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        'assets/icons/more.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 700,
              child: ListView(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side - List
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Price',
                                      style: UITextStyle.caption
                                          .copyWith(color: AppColors.grey),
                                    ),
                                    const Spacer(),
                                    DropdownButton<String>(
                                      value: dropdownAmountValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownAmountValue = newValue!;
                                        });
                                      },
                                      underline:
                                          Container(), // This removes the underline
                                      items: ['Amount', 'Total']
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: UITextStyle.caption.copyWith(
                                                color: AppColors.grey),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: AppSpacing.xxs,
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: 7,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            _buildItemInfo(
                                              '18.99',
                                            ),
                                            const Spacer(),
                                            if (dropdownAmountValue == 'Amount')
                                              _buildItemInfo(
                                                '10',
                                              )
                                            else
                                              _buildItemInfo(
                                                '20',
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSpacing.sm,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '0.6535',
                                      style: UITextStyle.bodyText1.copyWith(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '10',
                                      style: UITextStyle.caption,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSpacing.sm,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: AppSpacing.xxs,
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: 7,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            _buildItemInfo(
                                              '18.99',
                                            ),
                                            const Spacer(),
                                            if (dropdownAmountValue == 'Amount')
                                              _buildItemInfo(
                                                '10',
                                              )
                                            else
                                              _buildItemInfo(
                                                '20',
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSpacing.md,
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 190,
                                          decoration: const BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    filterOrder = 'All Order';
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 16,
                                                    horizontal: 16,
                                                  ),
                                                  child: Text(
                                                    'All Order',
                                                    style: UITextStyle.headline6
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              const Divider(),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    filterOrder = 'Buy Order';
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 16,
                                                  ),
                                                  child: Text(
                                                    'Buy Order',
                                                    style: UITextStyle.headline6
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              const Divider(),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    filterOrder = 'Sell Order';
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 16,
                                                  ),
                                                  child: Text(
                                                    'Sell Order',
                                                    style: UITextStyle.headline6
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.grey.shade300,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (filterOrder == 'All Order')
                                          Row(
                                            children: [
                                              Text(
                                                filterOrder.substring(0, 4),
                                                style: const TextStyle(
                                                  color: AppColors.red,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                filterOrder.substring(
                                                  4,
                                                ),
                                                style: const TextStyle(
                                                  color: AppColors.green,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (filterOrder != 'All Order')
                                          Text(
                                            filterOrder.substring(0, 4),
                                            style: TextStyle(
                                              color: filterOrder == 'Sell Order'
                                                  ? AppColors.red
                                                  : AppColors.green,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        if (filterOrder == 'All Order')
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_drop_down,
                                              ),
                                            ],
                                          ),
                                        if (filterOrder == 'Sell Order')
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: AppColors.red,
                                              ),
                                            ],
                                          ),
                                        if (filterOrder == 'Buy Order')
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: AppColors.green,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Right side - Form
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Top buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            colorShift = true;
                                            buttonText = 'Buy';
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: colorShift
                                                ? AppColors.green
                                                : AppColors.grey.shade300,
                                          ),
                                          child: Text(
                                            'Buy',
                                            style: TextStyle(
                                              color: colorShift
                                                  ? AppColors.white
                                                  : AppColors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            colorShift = false;
                                            buttonText = 'Sell';
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: colorShift
                                                ? AppColors.grey.shade300
                                                : AppColors.red,
                                          ),
                                          child: Text(
                                            'Sell',
                                            style: TextStyle(
                                              color: colorShift
                                                  ? AppColors.black
                                                  : AppColors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: AppSpacing.sm,
                                ),
                                // Form with dropdown and text field
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 190,
                                          decoration: const BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    dropDownText = 'Limit';
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 16,
                                                    horizontal: 16,
                                                  ),
                                                  child: Text(
                                                    'Limit',
                                                    style: UITextStyle.headline6
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              const Divider(),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    dropDownText = 'Market';
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 16,
                                                  ),
                                                  child: Text(
                                                    'Market',
                                                    style: UITextStyle.headline6
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              const Divider(),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    dropDownText = 'Stop-Limit';
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 12,
                                                    horizontal: 16,
                                                  ),
                                                  child: Text(
                                                    'Stop-Limit',
                                                    style: UITextStyle.headline6
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.grey.shade300,
                                    ),
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Text(
                                          dropDownText,
                                          style: const TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: AppSpacing.sm,
                                ),
                                if (dropDownText == 'Limit')
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        // price
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xxs,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 40,
                                                child: CustomFormField(
                                                  validation: validation,
                                                  controller: priceController,
                                                  labelText: 'Price ()',
                                                  validationCallBack: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xxs,
                                            ),
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: AppSpacing.sm,
                                        ),
                                        //amount
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xxs,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 40,
                                                child: CustomFormField(
                                                  validation: validation,
                                                  controller: amountController,
                                                  labelText: 'Amount ()',
                                                  validationCallBack: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xxs,
                                            ),
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: AppSpacing.sm,
                                        ),

                                        const SizedBox(
                                          height: AppSpacing.sm,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Available',
                                              style: UITextStyle.labelSmall
                                                  .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationStyle:
                                                    TextDecorationStyle.dotted,
                                                color: AppColors.grey.shade400,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '--- USD',
                                              style:
                                                  UITextStyle.caption.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            trackHeight: 10,
                                            trackShape:
                                                const RoundedRectSliderTrackShape(),
                                            activeTrackColor: AppColors
                                                .primaryContainer
                                                .withOpacity(.2),
                                            inactiveTrackColor: AppColors.black,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                              enabledThumbRadius: 10,
                                              pressedElevation: 8,
                                            ),
                                            thumbColor:
                                                AppColors.primaryContainer,
                                            overlayShape:
                                                const RoundSliderOverlayShape(
                                              overlayRadius: 32,
                                            ),
                                            tickMarkShape:
                                                const RoundSliderTickMarkShape(),
                                            activeTickMarkColor:
                                                AppColors.primaryContainer,
                                            inactiveTickMarkColor:
                                                AppColors.white,
                                            valueIndicatorShape:
                                                const PaddleSliderValueIndicatorShape(),
                                            valueIndicatorTextStyle:
                                                const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          child: Slider(
                                            min: 0,
                                            max: 100,
                                            value: _value,
                                            divisions: 4,
                                            label: '${_value.round()}',
                                            onChanged: (value) {
                                              setState(() {
                                                _value = value;
                                              });
                                            },
                                          ),
                                        ),
                                        //total
                                        SizedBox(
                                          height: 40,
                                          child: CustomFormField(
                                            validation: validation,
                                            controller: amountController,
                                            labelText: 'Total ()',
                                            validationCallBack: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                if (dropDownText == 'Market')
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        // price
                                        AbsorbPointer(
                                          child: SizedBox(
                                            height: 40,
                                            child: CustomFormField(
                                              validation: validation,
                                              controller: priceController,
                                              labelText: 'Market',
                                              validationCallBack: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return;
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                          height: AppSpacing.xs,
                                        ),
                                        // amount
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xxs,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 40,
                                                child: CustomFormField(
                                                  validation: validation,
                                                  controller: amountController,
                                                  labelText: 'Amount ()',
                                                  validationCallBack: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xxs,
                                            ),
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: AppSpacing.sm,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Available',
                                              style: UITextStyle.labelSmall
                                                  .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationStyle:
                                                    TextDecorationStyle.dotted,
                                                color: AppColors.grey.shade400,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '--- USD',
                                              style:
                                                  UITextStyle.caption.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            trackHeight: 10,
                                            trackShape:
                                                const RoundedRectSliderTrackShape(),
                                            activeTrackColor: AppColors
                                                .primaryContainer
                                                .withOpacity(.2),
                                            inactiveTrackColor: AppColors.black,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                              enabledThumbRadius: 10,
                                              pressedElevation: 8,
                                            ),
                                            thumbColor:
                                                AppColors.primaryContainer,
                                            overlayShape:
                                                const RoundSliderOverlayShape(
                                              overlayRadius: 32,
                                            ),
                                            tickMarkShape:
                                                const RoundSliderTickMarkShape(),
                                            activeTickMarkColor:
                                                AppColors.primaryContainer,
                                            inactiveTickMarkColor:
                                                AppColors.white,
                                            valueIndicatorShape:
                                                const PaddleSliderValueIndicatorShape(),
                                            valueIndicatorTextStyle:
                                                const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          child: Slider(
                                            min: 0,
                                            max: 100,
                                            value: _value,
                                            divisions: 4,
                                            label: '${_value.round()}',
                                            onChanged: (value) {
                                              setState(() {
                                                _value = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                if (dropDownText == 'Stop-Limit')
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        // stop
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xxs,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 40,
                                                child: CustomFormField(
                                                  validation: validation,
                                                  controller: stopController,
                                                  labelText: 'Stop ()',
                                                  validationCallBack: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xxs,
                                            ),
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: AppSpacing.xs,
                                        ),
                                        // limit
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xxs,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 40,
                                                child: CustomFormField(
                                                  validation: validation,
                                                  controller: limitController,
                                                  labelText: 'Limit ()',
                                                  validationCallBack: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xs,
                                            ),
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: AppSpacing.xs,
                                        ),
                                        // amount
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xxs,
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                height: 40,
                                                child: CustomFormField(
                                                  validation: validation,
                                                  controller: totalController,
                                                  labelText: 'Amount ()',
                                                  validationCallBack: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: AppSpacing.xs,
                                            ),
                                            Container(
                                              height: 40,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: AppColors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: AppSpacing.sm,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Available',
                                              style: UITextStyle.labelSmall
                                                  .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationStyle:
                                                    TextDecorationStyle.dotted,
                                                color: AppColors.grey.shade400,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '--- USD',
                                              style:
                                                  UITextStyle.caption.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            trackHeight: 10,
                                            trackShape:
                                                const RoundedRectSliderTrackShape(),
                                            activeTrackColor: AppColors
                                                .primaryContainer
                                                .withOpacity(.2),
                                            inactiveTrackColor: AppColors.black,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                              enabledThumbRadius: 10,
                                              pressedElevation: 8,
                                            ),
                                            thumbColor:
                                                AppColors.primaryContainer,
                                            overlayShape:
                                                const RoundSliderOverlayShape(
                                              overlayRadius: 32,
                                            ),
                                            tickMarkShape:
                                                const RoundSliderTickMarkShape(),
                                            activeTickMarkColor:
                                                AppColors.primaryContainer,
                                            inactiveTickMarkColor:
                                                AppColors.white,
                                            valueIndicatorShape:
                                                const PaddleSliderValueIndicatorShape(),
                                            valueIndicatorTextStyle:
                                                const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          child: Slider(
                                            min: 0,
                                            max: 100,
                                            value: _value,
                                            divisions: 4,
                                            label: '${_value.round()}',
                                            onChanged: (value) {
                                              setState(() {
                                                _value = value;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: AppSpacing.xs,
                                        ),
                                        // total

                                        SizedBox(
                                          height: 40,
                                          child: CustomFormField(
                                            validation: validation,
                                            controller: totalController,
                                            labelText: 'Total ()',
                                            validationCallBack: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                const Spacer(),
                                Container(
                                  width: 80,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: buttonText == 'Buy'
                                        ? AppColors.green
                                        : AppColors.red,
                                  ),
                                  child: Text(
                                    buttonText == 'Buy' ? 'Buy' : 'Sell',
                                    style: UITextStyle.subtitle1.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacing.md,
                  ),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(color: AppColors.grey.shade300),
                  ),
                  ColoredBox(
                    color: AppColors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            'Open Order',
                            style: UITextStyle.bodyText2
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          InkWell(
                            child: Icon(
                              Icons.history,
                              color: AppColors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Center(child: Text('No Data')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // order book
  Widget _buildItemInfo(String text) {
    return SizedBox(
      child: Text(
        text,
        maxLines: 2,
        style: UITextStyle.caption,
      ),
    );
  }
}

class TradeFeatured extends StatelessWidget {
  const TradeFeatured({
    required this.image,
    required this.text,
    required this.textStyle,
    super.key,
  });
  final String image;
  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Image.asset(
            image,
            width: 20,
            height: 20,
          ),
        ),
        const SizedBox(
          height: AppSpacing.sm,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 5.5,
          child: Text(
            text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        )
      ],
    );
  }
}

//format price
String formatNum(String value) {
  // Convert the double to a string
  String stringValue = value;

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
  // ignore: omit_local_variable_types
  final double number = double.parse(numberString);
  // ignore: omit_local_variable_types
  String formattedNumber = number.toStringAsFixed(2);
  formattedNumber =
      formattedNumber.replaceAll(RegExp(r'(\.0+|(?<=\.\d)0+)$'), '');
  return formattedNumber;
}
