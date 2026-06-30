import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
  final MapController _mapController = MapController();

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

    _mapController.move(currentPosition, 17.5);
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ================= TOP =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              PresensiData.hasCheckedIn
                                  ? "Check Out"
                                  : "Check In",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              formatDate(now),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formatTime(now),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ================= KARYAWAN =================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "KARYAWAN",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Ayu Setiawan",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ================= MAP =================
                    const Text(
                      "LOKASI SAAT INI",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),

                    const SizedBox(height: 8),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: SizedBox(
                        width: double.infinity,
                        height: 395,
                        child: FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter: currentPosition,
                            initialZoom: 17.5,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName:
                                  'com.example.app_mybhakti',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: currentPosition,
                                  width: 80,
                                  height: 80,
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ================= ALAMAT =================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.red, size: 24),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "ALAMAT TERDETEKSI",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Jl. Telekomunikasi No. 1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257.",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ================= MODE PRESENSI =================
                    const Text(
                      "MODE PRESENSI",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => selectedMode = "WFO");
                            },
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: selectedMode == "WFO"
                                    ? const Color(0xffC30D19)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: selectedMode == "WFO"
                                      ? const Color(0xffC30D19)
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.home,
                                    color: selectedMode == "WFO"
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                    size: 18,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "WFO",
                                    style: TextStyle(
                                      color: selectedMode == "WFO"
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => selectedMode = "DINAS / WFA");
                            },
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: selectedMode == "DINAS / WFA"
                                    ? const Color(0xffC30D19)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: selectedMode == "DINAS / WFA"
                                      ? const Color(0xffC30D19)
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.work,
                                    color: selectedMode == "DINAS / WFA"
                                        ? Colors.white
                                        : Colors.grey.shade700,
                                    size: 18,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "DINAS / WFA",
                                    style: TextStyle(
                                      color: selectedMode == "DINAS / WFA"
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // ================= FOTO SELFIE =================
                    const Text(
                      "FOTO SELFIE",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),

                    const SizedBox(height: 10),

                    GestureDetector(
                      onTap: openCamera,
                      child: Container(
                        width: double.infinity,
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: selfieImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: kIsWeb
                                    ? Image.network(
                                        selfieImage!.path,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(selfieImage!.path),
                                        fit: BoxFit.cover,
                                      ),
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    size: 42,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Tap untuk selfie",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ================= BUTTON CHECK IN/OUT =================
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PresensiData.hasCheckedIn
                              ? const Color(0xff2D4A76)
                              : const Color(0xffB1121B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          if (selectedMode == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pilih mode presensi dulu"),
                              ),
                            );
                            return;
                          }

                          if (selfieImage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Selfie wajib diisi"),
                              ),
                            );
                            return;
                          }

                          final now = DateTime.now();
                          String jam =
                              "${now.hour.toString().padLeft(2, '0')}:"
                              "${now.minute.toString().padLeft(2, '0')}";
                          String tanggal =
                              "${now.day}/${now.month}/${now.year}";

                          final String currentAction =
                              PresensiData.hasCheckedIn
                                  ? "Check Out"
                                  : "Check In";

                          PresensiData.hasCheckedIn =
                              !PresensiData.hasCheckedIn;

                          PresensiData.riwayat.insert(0, {
                            "tanggal": tanggal,
                            "jam": jam,
                            "status": "Hadir",
                            "mode": selectedMode,
                            "type": currentAction,
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("$currentAction berhasil"),
                            ),
                          );

                          Navigator.pop(context);
                        },
                        child: Text(
                          PresensiData.hasCheckedIn ? "Check Out" : "Check In",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
