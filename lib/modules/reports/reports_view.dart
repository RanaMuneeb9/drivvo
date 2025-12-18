import 'package:drivvo/modules/reports/reports_controller.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsView extends GetView<ReportsController> {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Obx(
        () => Column(
          children: [
            // Header with overlapping tab bar
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Teal header background
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Utils.appColor,
                        Utils.appColor.withValues(alpha: 0.9),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              controller.selectedName.value.tr,
                              style: Utils.getTextStyle(
                                baseSize: 24,
                                isBold: true,
                                color: Colors.white,
                                isUrdu: controller.isUrdu,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.tune,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Overlapping tab bar in white container
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: -22,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: _buildTabBar(),
                  ),
                ),
              ],
            ),
            // Spacing for the overlapping tab bar
            const SizedBox(height: 30),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Period selector
                    _buildPeriodSelector(),
                    const SizedBox(height: 16),

                    // Cards based on selected tab
                    _buildCardsForSelectedTab(),

                    const SizedBox(height: 24),

                    // Charts Section
                    _buildChartsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.list.map((name) {
            final isSelected = controller.selectedName.value == name;
            return GestureDetector(
              onTap: () => controller.onSelect(name),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Utils.appColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  name.tr,
                  style: Utils.getTextStyle(
                    baseSize: 13,
                    isBold: isSelected,
                    color: isSelected ? Colors.white : Colors.grey[600]!,
                    isUrdu: controller.isUrdu,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${"period".tr}:",
          style: Utils.getTextStyle(
            baseSize: 14,
            isBold: false,
            color: Colors.grey[600]!,
            isUrdu: controller.isUrdu,
          ),
        ),
        GestureDetector(
          onTap: controller.selectDateRange,
          child: Row(
            children: [
              Text(
                controller.formattedDateRange,
                style: Utils.getTextStyle(
                  baseSize: 14,
                  isBold: true,
                  color: Colors.black87,
                  isUrdu: controller.isUrdu,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardsForSelectedTab() {
    switch (controller.selectedName.value) {
      case "General":
        return _buildGeneralCards();
      case "Refueling":
        return _buildRefuelingCards();
      case "Expense":
        return _buildExpenseCards();
      case "Income":
        return _buildIncomeCards();
      case "Service":
        return _buildServiceCards();
      default:
        return _buildGeneralCards();
    }
  }

  Widget _buildGeneralCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildReportCard(
                icon: Icons.account_balance_wallet,
                iconBgColor: const Color(0xFFE8F5F4),
                iconColor: Utils.appColor,
                title: "balance".tr,
                total: controller.formatCurrency(controller.totalBalance.value),
                totalColor: controller.totalBalance.value >= 0
                    ? Utils.appColor
                    : Colors.red,
                byDay: controller.formatCurrency(controller.balanceByDay.value),
                byKm: controller.formatCurrency(controller.balanceByKm.value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildReportCard(
                icon: Icons.trending_down,
                iconBgColor: const Color(0xFFFDE8E8),
                iconColor: Colors.red,
                title: "cost".tr,
                total: controller.formatCurrency(controller.totalCost.value),
                totalColor: Colors.red,
                byDay: controller.formatCurrency(controller.costByDay.value),
                byKm: controller.formatCurrency(controller.costByKm.value),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildReportCard(
                icon: Icons.account_balance_wallet_outlined,
                iconBgColor: const Color(0xFFE8F5F4),
                iconColor: Utils.appColor,
                title: "income".tr,
                total: controller.formatCurrency(controller.totalIncome.value),
                totalColor: Colors.black87,
                byDay: controller.formatCurrency(controller.incomeByDay.value),
                byKm: controller.formatCurrency(controller.incomeByKm.value),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDistanceCard(
                icon: Icons.route,
                iconBgColor: const Color(0xFFE3F2FD),
                iconColor: Colors.blue,
                title: "distance".tr,
                total: controller.formatDistance(
                  controller.totalDistance.value,
                ),
                dailyAverage: controller.formatDistance(
                  controller.dailyAverageDistance.value,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRefuelingCards() {
    return Row(
      children: [
        Expanded(
          child: _buildReportCard(
            icon: Icons.local_gas_station,
            iconBgColor: const Color(0xFFE8F5F4),
            iconColor: Utils.appColor,
            title: "cost".tr,
            total: controller.formatCurrency(controller.refuelingCost.value),
            totalColor: Colors.black87,
            byDay: controller.formatCurrency(
              controller.refuelingCostByDay.value,
            ),
            byKm: controller.formatCurrency(controller.refuelingCostByKm.value),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDistanceCard(
            icon: Icons.route,
            iconBgColor: const Color(0xFFE3F2FD),
            iconColor: Colors.blue,
            title: "distance".tr,
            total: controller.formatDistance(
              controller.refuelingDistance.value,
            ),
            dailyAverage: controller.formatDistance(
              controller.refuelingDailyAverage.value,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseCards() {
    return Row(
      children: [
        Expanded(
          child: _buildReportCard(
            icon: Icons.receipt_long,
            iconBgColor: const Color(0xFFE8F5F4),
            iconColor: Utils.appColor,
            title: "cost".tr,
            total: controller.formatCurrency(controller.expenseCost.value),
            totalColor: Colors.black87,
            byDay: controller.formatCurrency(controller.expenseCostByDay.value),
            byKm: controller.formatCurrency(controller.expenseCostByKm.value),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDistanceCard(
            icon: Icons.route,
            iconBgColor: const Color(0xFFE3F2FD),
            iconColor: Colors.blue,
            title: "distance".tr,
            total: controller.formatDistance(controller.expenseDistance.value),
            dailyAverage: controller.formatDistance(
              controller.expenseDailyAverage.value,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeCards() {
    return Row(
      children: [
        Expanded(
          child: _buildReportCard(
            icon: Icons.account_balance_wallet,
            iconBgColor: const Color(0xFFE8F5F4),
            iconColor: Utils.appColor,
            title: "cost".tr,
            total: controller.formatCurrency(controller.incomeCost.value),
            totalColor: Colors.black87,
            byDay: controller.formatCurrency(controller.incomeCostByDay.value),
            byKm: controller.formatCurrency(controller.incomeCostByKm.value),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDistanceCard(
            icon: Icons.route,
            iconBgColor: const Color(0xFFE3F2FD),
            iconColor: Colors.blue,
            title: "distance".tr,
            total: controller.formatDistance(controller.incomeDistance.value),
            dailyAverage: controller.formatDistance(
              controller.incomeDailyAverage.value,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCards() {
    return Row(
      children: [
        Expanded(
          child: _buildReportCard(
            icon: Icons.build_circle,
            iconBgColor: const Color(0xFFE8F5F4),
            iconColor: Utils.appColor,
            title: "cost".tr,
            total: controller.formatCurrency(controller.serviceCost.value),
            totalColor: Colors.black87,
            byDay: controller.formatCurrency(controller.serviceCostByDay.value),
            byKm: controller.formatCurrency(controller.serviceCostByKm.value),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDistanceCard(
            icon: Icons.route,
            iconBgColor: const Color(0xFFE3F2FD),
            iconColor: Colors.blue,
            title: "distance".tr,
            total: controller.formatDistance(controller.serviceDistance.value),
            dailyAverage: controller.formatDistance(
              controller.serviceDailyAverage.value,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String total,
    required Color totalColor,
    required String byDay,
    required String byKm,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Utils.getTextStyle(
                  baseSize: 14,
                  isBold: true,
                  color: iconColor,
                  isUrdu: controller.isUrdu,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "total".tr,
            style: Utils.getTextStyle(
              baseSize: 12,
              isBold: false,
              color: Colors.grey[500]!,
              isUrdu: controller.isUrdu,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            total,
            style: Utils.getTextStyle(
              baseSize: 20,
              isBold: true,
              color: totalColor,
              isUrdu: controller.isUrdu,
            ),
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: Colors.grey[200]),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "by_day".tr,
                    style: Utils.getTextStyle(
                      baseSize: 10,
                      isBold: false,
                      color: Colors.grey[500]!,
                      isUrdu: controller.isUrdu,
                    ),
                  ),
                  Text(
                    byDay,
                    style: Utils.getTextStyle(
                      baseSize: 13,
                      isBold: true,
                      color: Colors.black87,
                      isUrdu: controller.isUrdu,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "by_km".tr,
                    style: Utils.getTextStyle(
                      baseSize: 10,
                      isBold: false,
                      color: Colors.grey[500]!,
                      isUrdu: controller.isUrdu,
                    ),
                  ),
                  Text(
                    byKm,
                    style: Utils.getTextStyle(
                      baseSize: 13,
                      isBold: true,
                      color: Colors.black87,
                      isUrdu: controller.isUrdu,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String total,
    required String dailyAverage,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Utils.getTextStyle(
                  baseSize: 14,
                  isBold: true,
                  color: Colors.blue,
                  isUrdu: controller.isUrdu,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "total".tr,
            style: Utils.getTextStyle(
              baseSize: 12,
              isBold: false,
              color: Colors.grey[500]!,
              isUrdu: controller.isUrdu,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            total,
            style: Utils.getTextStyle(
              baseSize: 20,
              isBold: true,
              color: Colors.black87,
              isUrdu: controller.isUrdu,
            ),
          ),
          const SizedBox(height: 8),
          Container(height: 1, color: Colors.grey[200]),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "daily_average".tr,
                style: Utils.getTextStyle(
                  baseSize: 10,
                  isBold: false,
                  color: Colors.grey[500]!,
                  isUrdu: controller.isUrdu,
                ),
              ),
              Text(
                dailyAverage,
                style: Utils.getTextStyle(
                  baseSize: 13,
                  isBold: true,
                  color: Colors.black87,
                  isUrdu: controller.isUrdu,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "charts".tr,
              style: Utils.getTextStyle(
                baseSize: 16,
                isBold: true,
                color: Utils.appColor,
                isUrdu: controller.isUrdu,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "view_all".tr,
                style: Utils.getTextStyle(
                  baseSize: 14,
                  isBold: false,
                  color: Colors.grey[600]!,
                  isUrdu: controller.isUrdu,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.selectedChartType.value,
                style: Utils.getTextStyle(
                  baseSize: 14,
                  isBold: false,
                  color: Colors.grey[600]!,
                  isUrdu: controller.isUrdu,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}
