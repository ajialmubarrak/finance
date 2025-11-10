import 'package:flutter/material.dart';
import '../widgets/atm_card.dart';
import '../models/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
  const AtmCard(
    bankName: 'BRI',
    cardNumber: '**** 2345',
    balance: 'Rp12.500.000',
    color1: Color(0xFF00529B), 
    color2: Color(0xFFF58220), 
  ),
  const AtmCard(
    bankName: 'BNI',
    cardNumber: '**** 8765',
    balance: 'Rp5.350.000',
    color1: Color(0xFFF36F21), 
    color2: Color(0xFF006F62), 
  ),
  const AtmCard(
    bankName: 'MANDIRI',
    cardNumber: '**** 8765',
    balance: 'Rp5.670.000',
    color1: Color(0xFF002984), 
    color2: Color(0xFFFFC20E), 
  ),
  const AtmCard(
    bankName: 'BJB',
    cardNumber: '**** 8765',
    balance: 'Rp5.670.000',
    color1: Color(0xFF005BAA), 
    color2: Color(0xFFFFD200), 
  ),
];


    final transactions = [
      TransactionModel('Coffee Shop', '-Rp35.000', 'Food'),
      TransactionModel('Grab Ride', '-Rp25.000', 'Travel'),
      TransactionModel('Gym Membership', '-Rp150.000', 'Health'),
      TransactionModel('Movie Ticket', '-Rp60.000', 'Event'),
      TransactionModel('Salary', '+Rp5.000.000', 'Income'),
    ];

   return Scaffold(
  backgroundColor: const Color(0xFF6ECFFF), 
  
    
  
      

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hallo Son 👋',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, )
              ,
            ),
            
            const SizedBox(height: 12),

            SizedBox(
              height: 210,
              child: PageView.builder(
                controller: _pageController,
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  double scale = (index == _currentPage.round()) ? 1 : 0.9;
                  return Transform.scale(
                    scale: scale,
                    child: cards[index],
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              children: const [
                ModernActionButton(icon: Icons.credit_card, title: "Pay"),
                ModernActionButton(icon: Icons.savings, title: "Save"),
                ModernActionButton(icon: Icons.show_chart, title: "Invest"),
                ModernActionButton(icon: Icons.receipt_long, title: "Bills"),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return ModernTransactionItem(transaction: transactions[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}



class ModernActionButton extends StatelessWidget {
  final IconData icon;
  final String title;

  const ModernActionButton({
    required this.icon,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF48E2B8), 
                      Color(0xFF3BB9FF), 
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0D1B2A)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModernTransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const ModernTransactionItem({super.key, required this.transaction});

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.local_cafe;
      case 'Travel':
        return Icons.directions_bike;
      case 'Health':
        return Icons.fitness_center;
      case 'Event':
        return Icons.movie;
      case 'Income':
        return Icons.attach_money;
      default:
        return Icons.receipt_long;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isIncome = transaction.amount.contains('+');

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
         
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF48E2B8),
                  Color(0xFF3BB9FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(_getCategoryIcon(transaction.category), color: Colors.white, size: 22),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0D1B2A)),
                ),
                Text(
                  transaction.category,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          Text(
            transaction.amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isIncome ? Colors.green : const Color(0xFFE84545),
            ),
          ),
        ],
      ),
    );
  }
}

