// ignore_for_file: lines_longer_than_80_chars, join_return_with_assignment

import 'package:app_ui/app_ui.dart';
import 'package:ces/trade/cubit/trade_cubit.dart';
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
  String selectedOption = 'Limit';
  String dropdownAmountValue = 'Amount';
  bool validation = false;
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController stopController = TextEditingController();
  TextEditingController limitController = TextEditingController();
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.green,
                            ),
                            child: Text(
                              'Buy',
                              style: UITextStyle.subtitle1
                                  .copyWith(color: AppColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            width: 80,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.red,
                            ),
                            child: Text(
                              'sell',
                              style: UITextStyle.subtitle1
                                  .copyWith(color: AppColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: AppSpacing.lg,
                      ),
                      // Form with dropdown and text field
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: .5),
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: AppColors.disabledSurface,
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5,
                          ),
                          isExpanded: true,
                          isDense: true,
                          elevation: 0,
                          value: selectedOption,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedOption = newValue!;
                            });
                          },
                          underline: Container(),
                          items: <String>['Limit', 'Market', 'Stop-Limit']
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: AppSpacing.lg,
                      ),
                      if (selectedOption == 'Limit')
                        Form(
                          child: Column(
                            children: [
                              // price
                              TextFormField(
                                autovalidateMode: validation
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Price Can't be empty";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primaryContainer,
                                controller: priceController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                                decoration: InputDecoration(
                                  fillColor: AppColors.white,
                                  labelText: 'Price ()',
                                  errorStyle: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.red,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: AppSpacing.lg,
                              ),
                              // amount
                              TextFormField(
                                autovalidateMode: validation
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Amount Can't be empty";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primaryContainer,
                                controller: amountController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                                decoration: InputDecoration(
                                  fillColor: AppColors.white,
                                  labelText: 'Amount ()',
                                  errorStyle: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.red,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: AppSpacing.lg,
                              ),
                              //total
                              TextFormField(
                                autovalidateMode: validation
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Total Can't be empty";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primaryContainer,
                                controller: totalController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                                decoration: InputDecoration(
                                  fillColor: AppColors.white,
                                  labelText: 'Total ()',
                                  errorStyle: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.red,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (selectedOption == 'Market')
                        Form(
                          child: Column(
                            children: [
                              // price
                              AbsorbPointer(
                                child: TextFormField(
                                  autovalidateMode: validation
                                      ? AutovalidateMode.always
                                      : AutovalidateMode.disabled,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Price Can't be empty";
                                    }
                                    return null;
                                  },
                                  cursorColor: AppColors.primaryContainer,
                                  controller: priceController,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blue,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: AppColors.grey,
                                    labelText: 'Price ()',
                                    errorStyle: const TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.red,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: AppColors.black.withOpacity(.5),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: AppColors.black.withOpacity(.5),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: AppColors.black.withOpacity(.5),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5,
                                        color: AppColors.black.withOpacity(.5),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: AppSpacing.lg,
                              ),
                              // amount
                              TextFormField(
                                autovalidateMode: validation
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Amount Can't be empty";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primaryContainer,
                                controller: amountController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                                decoration: InputDecoration(
                                  fillColor: AppColors.white,
                                  labelText: 'Amount ()',
                                  errorStyle: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.red,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      if (selectedOption == 'Stop-Limit')
                        Form(
                          child: Column(
                            children: [
                              // stop
                              TextFormField(
                                autovalidateMode: validation
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Stop Can't be empty";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primaryContainer,
                                controller: stopController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                                decoration: InputDecoration(
                                  fillColor: AppColors.white,
                                  labelText: 'Stop ()',
                                  errorStyle: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.red,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: AppSpacing.lg,
                              ),
                              // limit
                              TextFormField(
                                autovalidateMode: validation
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Limit Can't be empty";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primaryContainer,
                                controller: limitController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                                decoration: InputDecoration(
                                  fillColor: AppColors.white,
                                  labelText: 'Limit ()',
                                  errorStyle: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.red,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: AppSpacing.lg,
                              ),
                              // amount
                              TextFormField(
                                autovalidateMode: validation
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Amount Can't be empty";
                                  }
                                  return null;
                                },
                                cursorColor: AppColors.primaryContainer,
                                controller: amountController,
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blue,
                                ),
                                decoration: InputDecoration(
                                  fillColor: AppColors.white,
                                  labelText: 'Amount ()',
                                  errorStyle: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.red,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: AppColors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: AppSpacing.lg,
                              ),
                              // total
                              CustomFormField(
                                validation: validation,
                                controller: totalController,
                                validationText: '',
                                labelText: '',
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(
                        height: AppSpacing.lg,
                      ),
                      Container(
                        width: 80,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppColors.green,
                        ),
                        child: Text(
                          'Buy',
                          style: UITextStyle.subtitle1
                              .copyWith(color: AppColors.white),
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

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    required this.validation,
    required this.controller,
    required this.validationText,
    required this.labelText,
    super.key,
  });

  final bool validation;
  final String validationText;
  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode:
          validation ? AutovalidateMode.always : AutovalidateMode.disabled,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationText;
        }
        return null;
      },
      cursorColor: AppColors.primaryContainer,
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle(
        letterSpacing: 1,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.blue,
      ),
      decoration: InputDecoration(
        fillColor: AppColors.white,
        labelText: labelText,
        errorStyle: const TextStyle(
          letterSpacing: 1,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.red,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.black.withOpacity(.5),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.black.withOpacity(.5),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.black.withOpacity(.5),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.black.withOpacity(.5),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
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
