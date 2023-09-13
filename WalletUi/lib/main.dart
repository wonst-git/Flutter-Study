import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toonflix/component/buttons.dart';
import 'package:toonflix/component/cards.dart';
import 'package:toonflix/model/currency_data.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var statusHeight = MediaQuery.of(context).viewPadding.top;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    List<CurrencyData> currencies = [
      CurrencyData(name: 'Euro', code: 'EUR', amount: '6 428', icon: Icons.euro_rounded),
      CurrencyData(name: 'Bitcoin', code: 'BTC', amount: '9 785', icon: Icons.currency_bitcoin_rounded),
      CurrencyData(name: 'Dollar', code: 'USD', amount: '428', icon: Icons.attach_money_rounded),
      CurrencyData(name: 'Dollar', code: 'USD', amount: '428', icon: Icons.attach_money_rounded),
    ];

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, statusHeight + 4, 20, 0),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 36,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Hey, Selena',
                              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Welcome back',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Total Balance',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      '\$5 194 482',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Button(
                            text: 'Transfer',
                            textColor: Colors.black,
                            backgroundColor: Color(0xFFF1B33B),
                          ),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          flex: 1,
                          child: Button(
                            text: 'Request',
                            textColor: Colors.white,
                            backgroundColor: Color(0xFF1F2123),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Wallets',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return CurrencyCard(currencyData: currencies[index], index: index);
                  },
                  childCount: currencies.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
