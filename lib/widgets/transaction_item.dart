import 'package:flutter/material.dart';
import '../models/transaction.dart';

class RecentTransactionsSection extends StatefulWidget {
  final List<TransactionModel> transactions;

  const RecentTransactionsSection({super.key, required this.transactions});

  @override
  State<RecentTransactionsSection> createState() => _RecentTransactionsSectionState();
}

class _RecentTransactionsSectionState extends State<RecentTransactionsSection>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();

   
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _slideAnimations = widget.transactions.map((_) {
      return Tween<Offset>(
        begin: const Offset(0, 0.25),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
    }).toList();

    _fadeAnimations = widget.transactions.map((_) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
    }).toList();
    
    _controller.forward();
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.local_cafe;
      case 'Travel':
        return Icons.directions_bike;
      case 'Health':
        return Icons.fitness_center;
      case 'Income':
        return Icons.attach_money;
      default:
        return Icons.receipt_long;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Transactions",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        Column(
          children: List.generate(widget.transactions.length, (index) {
            final t = widget.transactions[index];
            final bool isIncome = t.amount.contains('+');

            return SlideTransition(
              position: _slideAnimations[index],
              child: FadeTransition(
                opacity: _fadeAnimations[index],
                child: Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(_getCategoryIcon(t.category), size: 26, color: Colors.black87),
                      const SizedBox(width: 18),

                      Expanded(
                        child: Text(
                          t.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      Text(
                        t.amount,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isIncome ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
