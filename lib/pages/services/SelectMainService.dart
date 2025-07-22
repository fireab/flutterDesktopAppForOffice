import 'package:flutter/material.dart';
import 'package:nifas_silk/l10n/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:nifas_silk/pages/services/EnviromentalPollution.dart';
import 'package:nifas_silk/pages/services/BioDiversity.dart';
import 'package:nifas_silk/pages/services/VehicleServiceList.dart';
import 'package:nifas_silk/pages/services/climateChangeAndAlternativEnergy.dart';
import 'package:nifas_silk/shared/CustomAppBar.dart';

class SelectMainService extends StatelessWidget {
  const SelectMainService({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonWidth = size.width * 0.9;
    final buttonHeight = size.height * 0.13;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: customAppBar(context, false)),
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 700,
              ),
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
                children: [
                  _FancyServiceButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DriverService()),
                      );
                    },
                    icon: 'assets/icons/responsible.png',
                    label: AppLocalizations.of(context)!
                        .environmental_pollution_control,
                    buttonHeight: buttonHeight,
                    fontSize: size.width * 0.038,
                  ),
                  SizedBox(height: 28),
                  _FancyServiceButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                climateChangeAndAlternativEnergyService()),
                      );
                    },
                    icon: 'assets/icons/responsible.png',
                    label: AppLocalizations.of(context)!
                        .climate_change_and_alternative_energy_technology_dissemination_and_awareness,
                    buttonHeight: buttonHeight,
                    fontSize: size.width * 0.038,
                  ),
                  SizedBox(height: 28),
                  _FancyServiceButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VehicleServices()),
                      );
                    },
                    icon: 'assets/icons/responsible.png',
                    label: AppLocalizations.of(context)!
                        .mineral_resource_research_Licensing_and_management,
                    buttonHeight: buttonHeight,
                    fontSize: size.width * 0.038,
                  ),
                  SizedBox(height: 28),
                  _FancyServiceButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BioDiversitySErvice()),
                      );
                    },
                    icon: 'assets/icons/responsible.png',
                    label: AppLocalizations.of(context)!
                        .biodiversity_and_ecosystem_management,
                    buttonHeight: buttonHeight,
                    fontSize: size.width * 0.038,
                  ),
                  // Add more _FancyServiceButton widgets here as needed
                ],
              ),
            ),
          ),
        ));
  }
}

class _FancyServiceButton extends StatefulWidget {
  final VoidCallback onTap;
  final String icon;
  final String label;
  final double buttonHeight;
  final double fontSize;

  const _FancyServiceButton({
    required this.onTap,
    required this.icon,
    required this.label,
    required this.buttonHeight,
    required this.fontSize,
    Key? key,
  }) : super(key: key);

  @override
  State<_FancyServiceButton> createState() => _FancyServiceButtonState();
}

class _FancyServiceButtonState extends State<_FancyServiceButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  bool _hovering = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.97;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onEnter(PointerEnterEvent event) {
    setState(() {
      _hovering = true;
      _scale = 1.04;
    });
  }

  void _onExit(PointerExitEvent event) {
    setState(() {
      _hovering = false;
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedScale(
        scale: _scale,
        duration: Duration(milliseconds: 120),
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: Card(
            elevation: _hovering ? 18 : 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            color: Colors.white,
            shadowColor: _hovering
                ? Color.fromRGBO(11, 73, 118, 0.32)
                : Color.fromRGBO(11, 73, 118, 0.18),
            child: Container(
              height: widget.buttonHeight + 60, // Make card even taller
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: Color(0xFFE3F0FF),
                    backgroundImage: AssetImage(widget.icon),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(11, 73, 118, 1),
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
