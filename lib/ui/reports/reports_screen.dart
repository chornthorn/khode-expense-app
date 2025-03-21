import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/themes/app_colors.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'This Month';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Categories'),
            Tab(text: 'Trends'),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildPeriodSelector(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildCategoriesTab(),
                _buildTrendsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    final periods = [
      'This Week',
      'This Month',
      'Last 3 Months',
      'Last 6 Months',
      'This Year',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Period:'),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: _selectedPeriod,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedPeriod = newValue;
                });
              }
            },
            items:
                periods.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            underline: Container(),
            icon: const Icon(Icons.arrow_drop_down, color: AppColors.cyclamen),
            borderRadius: BorderRadius.circular(12),
            dropdownColor: AppColors.cardBackground,
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverviewCards(),
          const SizedBox(height: 24),
          _buildSectionHeader('Income vs Expenses'),
          const SizedBox(height: 16),
          _buildIncomeExpenseChart(),
          const SizedBox(height: 24),
          _buildSectionHeader('Top Spending Categories'),
          const SizedBox(height: 16),
          _buildTopCategories(),
          const SizedBox(height: 24),
          _buildSectionHeader('Daily Spending'),
          const SizedBox(height: 16),
          _buildDailySpendingChart(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    // Sample category spending data
    final categories = [
      {
        'name': 'Food & Groceries',
        'percentage': 0.25,
        'amount': 12400,
        'icon': Icons.restaurant,
        'color': Colors.orange,
      },
      {
        'name': 'Housing',
        'percentage': 0.30,
        'amount': 15000,
        'icon': Icons.home,
        'color': Colors.indigo,
      },
      {
        'name': 'Transportation',
        'percentage': 0.06,
        'amount': 3200,
        'icon': Icons.directions_car,
        'color': Colors.blue,
      },
      {
        'name': 'Utilities',
        'percentage': 0.03,
        'amount': 1739,
        'icon': Icons.bolt,
        'color': Colors.amber,
      },
      {
        'name': 'Entertainment',
        'percentage': 0.10,
        'amount': 4800,
        'icon': Icons.movie,
        'color': AppColors.cyclamen,
      },
      {
        'name': 'Shopping',
        'percentage': 0.05,
        'amount': 2500,
        'icon': Icons.shopping_bag,
        'color': Colors.green,
      },
      {
        'name': 'Health',
        'percentage': 0.02,
        'amount': 1200,
        'icon': Icons.local_hospital,
        'color': Colors.red,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryPieChart(),
          const SizedBox(height: 24),
          _buildSectionHeader('Spending by Category'),
          const SizedBox(height: 16),
          ...categories.map((category) => _buildCategoryItem(category)),
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Monthly Spending Trend'),
          const SizedBox(height: 16),
          _buildMonthlyTrendChart(),
          const SizedBox(height: 24),
          _buildSectionHeader('Year-to-Year Comparison'),
          const SizedBox(height: 16),
          _buildYearComparisonChart(),
          const SizedBox(height: 24),
          _buildSectionHeader('Spending Insights'),
          const SizedBox(height: 16),
          _buildInsightsCards(),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Total Income',
            amount: '\$42,500',
            icon: Icons.arrow_downward,
            color: Colors.green,
            trend: '+8.2%',
            isTrendPositive: true,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            title: 'Total Expenses',
            amount: '\$28,350',
            icon: Icons.arrow_upward,
            color: Colors.redAccent,
            trend: '-3.5%',
            isTrendPositive: false,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color color,
    required String trend,
    required bool isTrendPositive,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 16),
            Text(amount, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  isTrendPositive ? Icons.trending_up : Icons.trending_down,
                  color: isTrendPositive ? Colors.green : Colors.redAccent,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  trend,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isTrendPositive ? Colors.green : Colors.redAccent,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'vs last period',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: Theme.of(context).textTheme.titleLarge);
  }

  Widget _buildIncomeExpenseChart() {
    return Card(
      child: Container(
        width: double.infinity,
        height: 260,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildLegendItem('Income', Colors.green),
                const SizedBox(width: 16),
                _buildLegendItem('Expenses', Colors.redAccent),
                const SizedBox(width: 16),
                _buildLegendItem('Savings', AppColors.cyclamen),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final titles = ['Income', 'Expenses', 'Savings'];
                          return value.toInt() < titles.length
                              ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  titles[value.toInt()],
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )
                              : const Text('');
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 42500,
                          color: Colors.green,
                          width: 40,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 28350,
                          color: Colors.redAccent,
                          width: 40,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 14150,
                          color: AppColors.cyclamen,
                          width: 40,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ],
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(8),
                      // tooltipBgColor: AppColors.cardBackground.withOpacity(0.8),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final formatter = NumberFormat.currency(symbol: '\$');
                        return BarTooltipItem(
                          formatter.format(rod.toY),
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCategories() {
    // Sample categories
    final categories = [
      {
        'name': 'Housing',
        'amount': '\$15,000',
        'percentage': '53%',
        'icon': Icons.home,
        'color': Colors.indigo,
      },
      {
        'name': 'Food & Groceries',
        'amount': '\$12,400',
        'percentage': '44%',
        'icon': Icons.restaurant,
        'color': Colors.orange,
      },
      {
        'name': 'Entertainment',
        'amount': '\$4,800',
        'percentage': '17%',
        'icon': Icons.movie,
        'color': AppColors.cyclamen,
      },
    ];

    return Column(
      children:
          categories.map((category) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (category['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    color: category['color'] as Color,
                  ),
                ),
                title: Text(category['name'] as String),
                subtitle: Text(
                  'of total expenses',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      category['amount'] as String,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      category['percentage'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildDailySpendingChart() {
    // Daily spending data for the last 7 days
    final List<FlSpot> spots = [
      FlSpot(0, 2100),
      FlSpot(1, 1800),
      FlSpot(2, 3200),
      FlSpot(3, 2400),
      FlSpot(4, 2900),
      FlSpot(5, 1500),
      FlSpot(6, 3600),
    ];

    return Card(
      child: Container(
        width: double.infinity,
        height: 280,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Last 7 Days', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1000,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(color: AppColors.divider, strokeWidth: 1);
                    },
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                          final int index = value.toInt();
                          if (index >= 0 && index < days.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                days[index],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1000,
                        getTitlesWidget: (value, meta) {
                          if (value % 1000 == 0) {
                            return Text(
                              '\$${(value ~/ 1000)}k',
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: AppColors.cyclamen,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.cyclamen.withOpacity(0.2),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(8),
                      // tooltipBgColor: AppColors.cardBackground.withOpacity(0.8),
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          final formatter = NumberFormat.currency(symbol: '\$');
                          return LineTooltipItem(
                            formatter.format(spot.y),
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPieChart() {
    // Category spending data
    final data = [
      {'name': 'Food', 'value': 0.25, 'color': Colors.orange},
      {'name': 'Housing', 'value': 0.30, 'color': Colors.indigo},
      {'name': 'Transport', 'value': 0.15, 'color': Colors.blue},
      {'name': 'Others', 'value': 0.30, 'color': AppColors.cyclamen},
    ];

    return Card(
      child: Container(
        width: double.infinity,
        height: 290,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Expense Distribution',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 60,
                  sections:
                      data.map((item) {
                        return PieChartSectionData(
                          color: item['color'] as Color,
                          value: item['value'] as double,
                          title:
                              '${((item['value'] as double) * 100).toInt()}%',
                          titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          radius: 80,
                        );
                      }).toList(),
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      // Add touch interaction if needed
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  data.map((item) {
                    return _buildLegendItem(
                      item['name'] as String,
                      item['color'] as Color,
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    final percentage = category['percentage'] as double;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (category['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    color: category['color'] as Color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category['name'] as String,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${category['amount']} (${(percentage * 100).toInt()}%)',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: AppColors.divider,
              valueColor: AlwaysStoppedAnimation<Color>(
                category['color'] as Color,
              ),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyTrendChart() {
    // Monthly spending data for the last 6 months
    final List<FlSpot> spots = [
      FlSpot(0, 24500),
      FlSpot(1, 28300),
      FlSpot(2, 26000),
      FlSpot(3, 29800),
      FlSpot(4, 31200),
      FlSpot(5, 28350),
    ];

    const months = ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return Card(
      child: Container(
        width: double.infinity,
        height: 280,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly expenses trend',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 5000,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(color: AppColors.divider, strokeWidth: 1);
                    },
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final int index = value.toInt();
                          if (index >= 0 && index < months.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                months[index],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10000,
                        getTitlesWidget: (value, meta) {
                          if (value % 10000 == 0) {
                            return Text(
                              '\$${(value ~/ 1000)}k',
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  minY: 20000,
                  maxY: 35000,
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: AppColors.cyclamen,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.cyclamen.withOpacity(0.3),
                            AppColors.cyclamen.withOpacity(0.05),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(8),
                      // tooltipBgColor: AppColors.cardBackground.withOpacity(0.8),
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          final formatter = NumberFormat.currency(symbol: '\$');
                          return LineTooltipItem(
                            formatter.format(spot.y),
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearComparisonChart() {
    // Data for this year and last year by quarter
    final quarters = ['Q1', 'Q2', 'Q3', 'Q4'];

    return Card(
      child: Container(
        width: double.infinity,
        height: 280,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Year-over-year comparison',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Row(
                  children: [
                    _buildLegendItem('2023', Colors.grey.withOpacity(0.5)),
                    const SizedBox(width: 16),
                    _buildLegendItem('2024', AppColors.cyclamen),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(8),
                      // tooltipBgColor: AppColors.cardBackground.withOpacity(0.8),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final String year = rodIndex == 0 ? '2023' : '2024';
                        final formatter = NumberFormat.currency(symbol: '\$');
                        return BarTooltipItem(
                          '$year: ${formatter.format(rod.toY)}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return value >= 0 && value < quarters.length
                              ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  quarters[value.toInt()],
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              )
                              : const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 20000,
                        getTitlesWidget: (value, meta) {
                          if (value % 20000 == 0) {
                            return Text(
                              '\$${(value ~/ 1000)}k',
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 20000,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(color: AppColors.divider, strokeWidth: 1);
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 75000,
                          color: Colors.grey.withOpacity(0.5),
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        BarChartRodData(
                          toY: 80000,
                          color: AppColors.cyclamen,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 82000,
                          color: Colors.grey.withOpacity(0.5),
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        BarChartRodData(
                          toY: 86000,
                          color: AppColors.cyclamen,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 69000,
                          color: Colors.grey.withOpacity(0.5),
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        BarChartRodData(
                          toY: 76000,
                          color: AppColors.cyclamen,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: 92000,
                          color: Colors.grey.withOpacity(0.5),
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        BarChartRodData(
                          toY: 84000,
                          color: AppColors.cyclamen,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
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
    );
  }

  Widget _buildInsightsCards() {
    return Column(
      children: [
        _buildInsightCard(
          icon: Icons.trending_down,
          title: 'Spending decreased',
          description: 'Your spending decreased by 15% compared to last month.',
          color: Colors.green,
        ),
        const SizedBox(height: 12),
        _buildInsightCard(
          icon: Icons.warning_outlined,
          title: 'Entertainment spending',
          description: 'Entertainment expenses increased by 30% this month.',
          color: Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildInsightCard(
          icon: Icons.sentiment_satisfied_alt,
          title: 'Saving goal progress',
          description: 'You\'ve saved 70% of your monthly target.',
          color: AppColors.cyclamen,
        ),
      ],
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: color),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
