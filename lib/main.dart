import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const KamranPortfolio());
}

class KamranPortfolio extends StatelessWidget {
  const KamranPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kamran Rafiq | IT Executive & Developer',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF07111F),
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF21D4A5),
          brightness: Brightness.dark,
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

// =============================================================
// PORTFOLIO PAGE
// =============================================================

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final aboutKey = GlobalKey();
  final expertiseKey = GlobalKey();
  final experienceKey = GlobalKey();
  final contactKey = GlobalKey();

  // ===========================================================
  // SCROLL TO SECTION
  // ===========================================================

  void goTo(GlobalKey key) {
    final context = key.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOut,
      );
    }
  }

  // ===========================================================
  // WHATSAPP
  // ===========================================================

  Future<void> openWhatsApp() async {
    const String phoneNumber = '923441387146';

    const String message =
        'Hello Kamran, I visited your portfolio and would like to contact you.';

    final Uri whatsappUrl = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    try {
      final bool launched = await launchUrl(
        whatsappUrl,
        webOnlyWindowName: '_blank',
      );

      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open WhatsApp.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open WhatsApp.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width < 850;

    return Scaffold(
      // =========================================================
      // MOBILE DRAWER
      // =========================================================

      drawer: mobile
          ? Drawer(
              backgroundColor: const Color(0xFF0D1A2B),
              child: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const Text(
                      'KAMRAN RAFIQ',
                      style: TextStyle(
                        color: Color(0xFF21D4A5),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 30),

                    _drawerItem(
                      'About',
                      () {
                        Navigator.pop(context);
                        goTo(aboutKey);
                      },
                    ),

                    _drawerItem(
                      'Expertise',
                      () {
                        Navigator.pop(context);
                        goTo(expertiseKey);
                      },
                    ),

                    _drawerItem(
                      'Experience',
                      () {
                        Navigator.pop(context);
                        goTo(experienceKey);
                      },
                    ),

                    _drawerItem(
                      'Contact',
                      () {
                        Navigator.pop(context);
                        goTo(contactKey);
                      },
                    ),
                  ],
                ),
              ),
            )
          : null,

      // =========================================================
      // APP BAR
      // =========================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFF07111F),
        elevation: 0,
        title: const Text(
          'KR',
          style: TextStyle(
            color: Color(0xFF21D4A5),
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        actions: mobile
            ? null
            : [
                _navItem('About', aboutKey),
                _navItem('Expertise', expertiseKey),
                _navItem('Experience', experienceKey),
                _navItem('Contact', contactKey),
                const SizedBox(width: 20),
              ],
      ),

      // =========================================================
      // FLOATING WHATSAPP BUTTON
      // =========================================================

      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF25D366).withOpacity(0.40),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: openWhatsApp,
          backgroundColor: const Color(0xFF25D366),
          foregroundColor: Colors.white,
          elevation: 8,
          tooltip: 'Contact me on WhatsApp',
          child: const Icon(
            Icons.chat,
            size: 30,
          ),
        ),
      ),

      // =========================================================
      // BODY
      // =========================================================

      body: SingleChildScrollView(
        child: Column(
          children: [
            // HERO
            _HeroSection(
              onContact: () => goTo(contactKey),
              onExperience: () => goTo(experienceKey),
            ),

            // ABOUT
            _section(
              aboutKey,
              'ABOUT ME',
              const _AboutContent(),
            ),

            // EXPERTISE
            _section(
              expertiseKey,
              'EXPERTISE',
              const _ExpertiseGrid(),
            ),

            // EXPERIENCE
            _section(
              experienceKey,
              'EXPERIENCE',
              const _ExperienceContent(),
            ),

            // CONTACT
            _section(
              contactKey,
              'LET’S CONNECT',
              const _ContactContent(),
            ),

            const SizedBox(height: 40),

            // FOOTER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 28,
              ),
              color: const Color(0xFF040A12),
              child: const Center(
                child: Text(
                  '© 2026 Kamran Rafiq • IT Executive & Developer',
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // DESKTOP NAV ITEM
  // ===========================================================

  Widget _navItem(
    String title,
    GlobalKey key,
  ) {
    return TextButton(
      onPressed: () => goTo(key),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }

  // ===========================================================
  // MOBILE DRAWER ITEM
  // ===========================================================

  Widget _drawerItem(
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // ===========================================================
  // SECTION BUILDER
  // ===========================================================

  Widget _section(
    GlobalKey key,
    String title,
    Widget child,
  ) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 85,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  letterSpacing: 3,
                  color: Color(0xFF21D4A5),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: 55,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFF21D4A5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 32),

              child,
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================
// HERO SECTION
// =============================================================

class _HeroSection extends StatelessWidget {
  final VoidCallback onContact;
  final VoidCallback onExperience;

  const _HeroSection({
    required this.onContact,
    required this.onExperience,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width < 800;

    final content = Column(
      crossAxisAlignment: mobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const Text(
          'HELLO, I’M',
          style: TextStyle(
            color: Color(0xFF21D4A5),
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Kamran Rafiq',
          textAlign: mobile
              ? TextAlign.center
              : TextAlign.left,
          style: TextStyle(
            fontSize: mobile ? 46 : 68,
            height: 1,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
          ),
        ),

        const SizedBox(height: 22),

        Text(
          'IT Executive & Developer',
          textAlign: mobile
              ? TextAlign.center
              : TextAlign.left,
          style: TextStyle(
            fontSize: mobile ? 22 : 30,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 25),

        Text(
          'SAP Business One • CRM Systems • SQL • Power BI • '
          'Flutter • Dart • Firebase',
          textAlign: mobile
              ? TextAlign.center
              : TextAlign.left,
          style: TextStyle(
            fontSize: mobile ? 15 : 17,
            height: 1.7,
            color: Colors.white54,
          ),
        ),

        const SizedBox(height: 38),

        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: mobile
              ? WrapAlignment.center
              : WrapAlignment.start,
          children: [
            ElevatedButton(
              onPressed: onContact,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF21D4A5),
                foregroundColor: const Color(0xFF061019),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 17,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'CONTACT ME',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            OutlinedButton(
              onPressed: onExperience,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.white24,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 17,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'VIEW EXPERIENCE',
              ),
            ),
          ],
        ),
      ],
    );

    // =========================================================
    // PROFILE IMAGE
    // =========================================================

    final portrait = Container(
      width: mobile ? 245 : 360,
      height: mobile ? 245 : 360,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF21D4A5),
          width: 3,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x5521D4A5),
            blurRadius: 35,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/kamran_profile.png',
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        mobile ? 25 : 70,
        mobile ? 70 : 105,
        mobile ? 25 : 70,
        mobile ? 75 : 110,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF07111F),
            Color(0xFF0B2430),
            Color(0xFF07111F),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1120,
          ),
          child: mobile
              ? Column(
                  children: [
                    portrait,
                    const SizedBox(height: 42),
                    content,
                  ],
                )
              : Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: content,
                    ),
                    const SizedBox(width: 55),
                    portrait,
                  ],
                ),
        ),
      ),
    );
  }
}

// =============================================================
// ABOUT CONTENT
// =============================================================

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Results-driven IT Executive & Flutter Developer with hands-on '
      'experience in CRM Systems, SAP Business One (SAP B1), SQL, Power BI, '
      'and Flutter application development. Skilled in developing '
      'cross-platform mobile applications using Flutter, Dart, and Firebase, '
      'while delivering efficient IT solutions through ERP support, '
      'application testing, data analysis, and strong problem-solving abilities.',
      style: TextStyle(
        fontSize: 18,
        height: 1.85,
        color: Colors.white70,
      ),
    );
  }
}

// =============================================================
// EXPERTISE GRID
// =============================================================

class _ExpertiseGrid extends StatelessWidget {
  const _ExpertiseGrid();

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        'IT Infrastructure',
        Icons.settings_suggest,
        'System troubleshooting, software installation and technical user support.',
      ),
      (
        'ERP & CRM Management',
        Icons.business_center,
        'SAP Business One, CRM systems, ERP support and technical coordination.',
      ),
      (
        'Flutter Development',
        Icons.phone_android,
        'Cross-platform mobile application development using Flutter and Dart.',
      ),
      (
        'Database & Firebase',
        Icons.storage,
        'SQL, Firebase Authentication and Cloud Firestore experience.',
      ),
      (
        'Reporting & Data',
        Icons.bar_chart,
        'SQL, Power BI and SAP Crystal Reports for reporting and analysis.',
      ),
      (
        'QA & Problem Solving',
        Icons.bug_report,
        'Debugging, application testing, quality assurance and issue resolution.',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 850
            ? 3
            : constraints.maxWidth > 550
                ? 2
                : 1;

        final cardWidth =
            (constraints.maxWidth -
                    ((columns - 1) * 18)) /
                columns;

        return Wrap(
          spacing: 18,
          runSpacing: 18,
          children: items.map((item) {
            return SizedBox(
              width: cardWidth,
              child: _InfoCard(
                icon: item.$2,
                title: item.$1,
                description: item.$3,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// =============================================================
// INFO CARD
// =============================================================

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 185,
      ),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1A2B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF21D4A5),
            size: 30,
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            description,
            style: const TextStyle(
              color: Colors.white54,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// EXPERIENCE CONTENT
// =============================================================

class _ExperienceContent extends StatelessWidget {
  const _ExperienceContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _TimelineCard(
          role: 'IT Executive',
          company: 'Evyol Group, Multan',
          period: '2024 – Present',
          points: [
            'Managed and maintained CRM systems to ensure smooth business operations and accurate customer data management.',
            'Provided technical support and day-to-day administration for SAP Business One (SAP B1) across multiple departments.',
            'Coordinated ERP support activities, resolving user issues and ensuring timely system performance.',
            'Performed application testing (QA), identified bugs, documented issues, and verified fixes before deployment.',
            'Generated and analyzed reports using SQL, Power BI and Crystal Reports.',
            'Assisted users with technical training and prompt IT support to minimize operational downtime.',
            'Collaborated with cross-functional teams to implement new system features and improve business processes.',
          ],
        ),

        SizedBox(height: 22),

        _TimelineCard(
          role: 'Data Analyst',
          company: 'Pakistan College of Science, Multan',
          period: '',
          points: [
            'SQL Query Development',
            'Power BI Dashboard Creation',
            'SAP Crystal Reports',
            'Data Analysis & Reporting',
            'Data Cleaning & Validation',
            'Database Management',
            'Microsoft Excel Reporting',
            'Data Visualization',
            'Report Automation',
            'Data Accuracy & Quality Assurance',
          ],
        ),
      ],
    );
  }
}

// =============================================================
// TIMELINE CARD
// =============================================================

class _TimelineCard extends StatelessWidget {
  final String role;
  final String company;
  final String period;
  final List<String> points;

  const _TimelineCard({
    required this.role,
    required this.company,
    required this.period,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1A2B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            role,
            style: const TextStyle(
              color: Color(0xFF21D4A5),
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            company,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          if (period.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              period,
              style: const TextStyle(
                color: Colors.white54,
              ),
            ),
          ],

          const SizedBox(height: 20),

          ...points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(
                bottom: 11,
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: Color(0xFF21D4A5),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
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

// =============================================================
// CONTACT CONTENT
// =============================================================

class _ContactContent extends StatelessWidget {
  const _ContactContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0D1A2B),
            Color(0xFF102536),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: const Wrap(
        spacing: 50,
        runSpacing: 25,
        children: [
          _ContactItem(
            icon: Icons.email_outlined,
            label: 'EMAIL',
            value: 'kamranrafiq301@gmail.com',
          ),

          _ContactItem(
            icon: Icons.phone_outlined,
            label: 'PHONE',
            value: '+92 344 1387146',
          ),

          _ContactItem(
            icon: Icons.location_on_outlined,
            label: 'LOCATION',
            value: 'Multan, Pakistan',
          ),
        ],
      ),
    );
  }
}

// =============================================================
// CONTACT ITEM
// =============================================================

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: const Color(0xFF21D4A5),
          size: 27,
        ),

        const SizedBox(width: 14),

        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}