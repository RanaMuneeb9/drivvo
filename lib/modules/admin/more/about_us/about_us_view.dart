import 'package:drivvo/modules/admin/more/about_us/about_us_controller.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Utils.appColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'about'.tr,
          style: Utils.getTextStyle(
            baseSize: 18,
            isBold: true,
            color: Colors.white,
            isUrdu: controller.isUrdu,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              // Rate Our App Section
              Text(
                'rate_our_app'.tr,
                style: Utils.getTextStyle(
                  baseSize: 20,
                  isBold: true,
                  color: Utils.appColor,
                  isUrdu: controller.isUrdu,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'rate_app_description'.tr,
                textAlign: TextAlign.center,
                style: Utils.getTextStyle(
                  baseSize: 14,
                  isBold: false,
                  color: Colors.grey[600]!,
                  isUrdu: controller.isUrdu,
                ),
              ),
              const SizedBox(height: 16),
              // Star Rating
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return GestureDetector(
                      onTap: () => controller.setRating(index + 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          index < controller.currentRating.value
                              ? Icons.star
                              : Icons.star_border,
                          size: 40,
                          color: Utils.appColor,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 32),

              // Follow Us Section
              Text(
                'follow_us'.tr,
                style: Utils.getTextStyle(
                  baseSize: 20,
                  isBold: true,
                  color: Utils.appColor,
                  isUrdu: controller.isUrdu,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: Icons.facebook,
                    label: 'Facebook',
                    onTap: controller.openFacebook,
                  ),
                  const SizedBox(width: 16),
                  _buildSocialButton(
                    icon: Icons.camera_alt,
                    label: 'Instagram',
                    onTap: controller.openInstagram,
                  ),
                  const SizedBox(width: 16),
                  _buildSocialButton(
                    icon: Icons.alternate_email,
                    label: 'Twitter',
                    onTap: controller.openTwitter,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Last Update Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Utils.appColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.update,
                        color: Utils.appColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'last_update'.tr,
                          style: Utils.getTextStyle(
                            baseSize: 16,
                            isBold: true,
                            color: const Color(0xFF1E2E4B),
                            isUrdu: controller.isUrdu,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.lastUpdate,
                          style: Utils.getTextStyle(
                            baseSize: 14,
                            isBold: false,
                            color: Utils.appColor,
                            isUrdu: controller.isUrdu,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Legal Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'legal'.tr,
                  style: Utils.getTextStyle(
                    baseSize: 16,
                    isBold: true,
                    color: Colors.grey[700]!,
                    isUrdu: controller.isUrdu,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Privacy Policy
              _buildLegalTile(
                icon: Icons.expand_more,
                label: 'privacy_policy'.tr,
                onTap: controller.openPrivacyPolicy,
              ),
              const SizedBox(height: 12),

              // Terms of Use
              _buildLegalTile(
                icon: Icons.description_outlined,
                label: 'terms_of_use'.tr,
                onTap: controller.openTermsOfUse,
              ),

              const SizedBox(height: 60),

              // Website Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'visit_our'.tr,
                    style: Utils.getTextStyle(
                      baseSize: 14,
                      isBold: false,
                      color: Colors.grey[600]!,
                      isUrdu: controller.isUrdu,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.openWebsite,
                    child: Text(
                      'www.drivo.com',
                      style: Utils.getTextStyle(
                        baseSize: 14,
                        isBold: true,
                        color: Utils.appColor,
                        isUrdu: controller.isUrdu,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Utils.appColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: Utils.getTextStyle(
                baseSize: 12,
                isBold: false,
                color: Colors.grey[700]!,
                isUrdu: controller.isUrdu,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.grey[600]),
            const SizedBox(width: 12),
            Text(
              label,
              style: Utils.getTextStyle(
                baseSize: 15,
                isBold: false,
                color: const Color(0xFF1E2E4B),
                isUrdu: controller.isUrdu,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
