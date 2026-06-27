import 'package:flutter/material.dart';

import 'tambah_lead_baru.dart';
import 'import_data_leads.dart';

class TambahOpportunityMenuScreen extends StatelessWidget {
  const TambahOpportunityMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryRed = Color(0xFFB91C21);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: const Text(
          "Tambah Opportunity",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Tambah Lead Manual"),
                style: ElevatedButton.styleFrom(backgroundColor: primaryRed),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TambahLeadBaruScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text("Import via Template Excel"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ImportDataLeadsScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
