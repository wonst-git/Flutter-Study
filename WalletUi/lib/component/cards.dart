import 'package:flutter/material.dart';
import 'package:toonflix/model/currency_data.dart';

class CurrencyCard extends StatelessWidget {
  final CurrencyData currencyData;
  final int index;

  const CurrencyCard({super.key, required this.currencyData, required this.index});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -20.0 * index),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: index.isOdd ? Colors.white : const Color(0xFF1F2123),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currencyData.name,
                    style: TextStyle(
                      color: index.isOdd ? const Color(0xFF1F2123) : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currencyData.amount,
                        style: TextStyle(
                          color: index.isOdd ? const Color(0xFF1F2123) : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        currencyData.code,
                        style: TextStyle(
                          color: (index.isOdd ? const Color(0xFF1F2123) : Colors.white).withOpacity(0.8),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.scale(
                scale: 3,
                child: Transform.translate(
                  offset: const Offset(-2, 6),
                  child: Icon(
                    currencyData.icon,
                    color: index.isOdd ? const Color(0xFF1F2123) : Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
