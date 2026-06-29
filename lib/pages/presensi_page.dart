import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_mybhakti/pages/presensi_data.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  // ================= LOCATION =================
  LatLng currentPosition = const LatLng(-6.973316, 107.630478);

  GoogleMapController? mapController;

  // ================= SELFIE =================
  XFile? selfieImage;
  final ImagePicker picker = ImagePicker();

  // ================= MODE =================
  String? selectedMode;

  // ================= TIME =================
  DateTime now = DateTime.now();
  Timer? timer;

  bool mapReady = false;

  @override
  void initState() {
    super.initState();
    getLocation();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // ================= TIME FORMAT =================
  String formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} WIB";
  }

  String formatDate(DateTime date) {
    List<String> hari = [
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jumat",
      "Sabtu",
      "Minggu",
    ];

    List<String> bulan = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];

    return "${hari[date.weekday - 1]}, ${date.day} ${bulan[date.month - 1]} ${date.year}";
  }

  // ================= LOCATION =================
  Future<void> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  // ================= CAMERA =================
  Future<void> openCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        selfieImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F3F3),

      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 12,
                left: 20,
                right: 20,
                bottom: 24,
              ),
              decoration: const BoxDecoration(
                color: Color(0xffB1121B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(38),
                  bottomRight: Radius.circular(38),
                ),
              ),
              child: const Center(
                child: Text(
                  "Presensi",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            // ================= CONTENT =================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    // ================= MAP SAFE =================
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: SizedBox(
                        height: 350,
                        child:
                            currentPosition.latitude == 0 &&
                                currentPosition.longitude == 0
                            ? const Center(child: CircularProgressIndicator())
                            : GoogleMap(
                                onMapCreated: (controller) {
                                  mapController = controller;
                                  setState(() => mapReady = true);
                                },
                                initialCameraPosition: CameraPosition(
                                  target: currentPosition,
                                  zoom: 17,
                                ),
                                markers: {
                                  Marker(
                                    markerId: const MarkerId("me"),
                                    position: currentPosition,
                                  ),
                                },
                                myLocationEnabled: true,
                                zoomControlsEnabled: false,
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ================= MODE =================
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => selectedMode = "WFO");
                            },
                            child: modeBox("WFO"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => selectedMode = "DINAS");
                            },
                            child: modeBox("DINAS"),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ================= CAMERA =================
                    GestureDetector(
                      onTap: openCamera,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: selfieImage == null
                            ? const Center(
                                child: Icon(Icons.camera_alt, size: 40),
                              )
                            : kIsWeb
                            ? Image.network(
                                selfieImage!.path,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(selfieImage!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ================= BUTTON =================
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffB1121B),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        if (selectedMode == null) return;

                        PresensiData.riwayat.insert(0, {
                          "tanggal": DateTime.now().toString(),
                          "mode": selectedMode,
                        });

                        Navigator.pop(context);
                      },
                      child: const Text("Check In"),
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

  Widget modeBox(String title) {
    final isSelected = selectedMode == title;

    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xffC30D19) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
