// ignore_for_file: lines_longer_than_80_chars, join_return_with_assignment

import 'package:app_ui/app_ui.dart';
import 'package:ces/trade/cubit/trade_cubit.dart';
import 'package:ces/trade/widgets/custom_form_field.dart';
import 'package:ces/trade/widgets/trade_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  final GlobalKey _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerContent(),
      appBar: AppBar(),
      body: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side - List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Price',
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
                            items: ['Amount', 'Total'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
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
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 10,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  _buildItemInfo('18.99'),
                                  const Spacer(),
                                  if (dropdownAmountValue == 'Amount')
                                    _buildItemInfo('10')
                                  else
                                    _buildItemInfo('20'),
                                ],
                              );
                            },
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 16),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
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
                          decoration:
                              BoxDecoration(color: AppColors.grey.shade300),
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
                                          if (value == null || value.isEmpty) {
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
                                          if (value == null || value.isEmpty) {
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
                              //total
                              SizedBox(
                                height: 40,
                                child: CustomFormField(
                                  validation: validation,
                                  controller: amountController,
                                  labelText: 'Total ()',
                                  validationCallBack: (value) {
                                    if (value == null || value.isEmpty) {
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
                                      if (value == null || value.isEmpty) {
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
                                          if (value == null || value.isEmpty) {
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
                                          if (value == null || value.isEmpty) {
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
                                          if (value == null || value.isEmpty) {
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
                                          if (value == null || value.isEmpty) {
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
                              // total
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
                                        labelText: 'Total ()',
                                        validationCallBack: (value) {
                                          if (value == null || value.isEmpty) {
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
                            ],
                          ),
                        ),

                      const SizedBox(
                        height: AppSpacing.sm,
                      ),
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
          const Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Open Order')],
            ),
          ),
        ],
      ),
    );
  }

  // order book
  Widget _buildItemInfo(String text) {
    return SizedBox(
      child: Text(
        text,
        maxLines: 2,
      ),
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
