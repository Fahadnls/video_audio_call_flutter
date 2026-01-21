import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../constants/constants.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _Background(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(onLogout: controller.logoutUser),
                  const SizedBox(height: 20),
                  Text(
                    'Ready to connect?',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Start a voice or video call in seconds.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _UserCard(userId: currentUser.id),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      const Icon(Icons.bolt, color: Color(0xFF39D98A)),
                      const SizedBox(width: 8),
                      Text(
                        'Start a call',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _CallCard(
                    title: 'One-to-one call',
                    description:
                        'Invite a single user for a private audio or video call.',
                    controller: controller,
                    textController: controller.singleInviteeUserIDTextCtrl,
                    inputLabel: 'Invitee ID',
                  ),
                  const SizedBox(height: 18),
                  _CallCard(
                    title: 'Group call',
                    description:
                        'Enter multiple IDs separated by commas to start a group call.',
                    controller: controller,
                    textController: controller.groupInviteeUserIDsTextCtrl,
                    inputLabel: 'Group IDs',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0B161E),
            Color(0xFF1C2E3A),
            Color(0xFF102028),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -40,
            child: _GlowOrb(
              diameter: 180,
              color: Color(0xFF39D98A),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -30,
            child: _GlowOrb(
              diameter: 220,
              color: Color(0xFF4CC3FF),
            ),
          ),
          Positioned(
            top: 160,
            left: -70,
            child: _GlowOrb(
              diameter: 140,
              color: Color(0xFFFFC857),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final double diameter;
  final Color color;

  const _GlowOrb({required this.diameter, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 80,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onLogout;

  const _Header({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.16),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white24),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              appLogoAsset,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            appName,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: onLogout,
          icon: const Icon(Icons.logout),
          color: const Color(0xFFFF6B6B),
          tooltip: 'Log out',
        ),
      ],
    );
  }
}

class _UserCard extends StatelessWidget {
  final String userId;

  const _UserCard({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x22FFFFFF),
            Color(0x14FFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF39D98A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Signed in as',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                userId.isEmpty ? 'Unknown user' : userId,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF39D98A).withOpacity(0.18),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFF39D98A)),
            ),
            child: Text(
              'Online',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF39D98A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CallCard extends StatelessWidget {
  final String title;
  final String description;
  final HomeController controller;
  final TextEditingController textController;
  final String inputLabel;

  const _CallCard({
    required this.title,
    required this.description,
    required this.controller,
    required this.textController,
    required this.inputLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFDFEFF),
            Color(0xFFEAF1F5),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8EE)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF203A43),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: textController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9,]')),
            ],
            decoration: InputDecoration(
              labelText: inputLabel,
              hintText: 'e.g. 102938, 120948',
              filled: true,
              fillColor: const Color(0xFFF3F5F7),
              prefixIcon: const Icon(Icons.person_add_alt_1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF39D98A)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _CallAction(
                label: 'Voice call',
                isVideoCall: false,
                controller: controller,
                inviteeUsersIDTextCtrl: textController,
              ),
              const SizedBox(width: 16),
              _CallAction(
                label: 'Video call',
                isVideoCall: true,
                controller: controller,
                inviteeUsersIDTextCtrl: textController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CallAction extends StatelessWidget {
  final String label;
  final bool isVideoCall;
  final HomeController controller;
  final TextEditingController inviteeUsersIDTextCtrl;

  const _CallAction({
    required this.label,
    required this.isVideoCall,
    required this.controller,
    required this.inviteeUsersIDTextCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: inviteeUsersIDTextCtrl,
            builder: (context, value, _) {
              final invitees =
                  controller.getInvitesFromTextCtrl(value.text.trim());
              return ZegoSendCallInvitationButton(
                isVideoCall: isVideoCall,
                invitees: invitees,
                resourceID: 'zego_data',
                iconSize: const Size(36, 36),
                buttonSize: const Size(54, 54),
                onPressed: controller.onSendCallInvitationFinished,
              );
            },
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF203A43),
            ),
          ),
        ],
      ),
    );
  }
}
