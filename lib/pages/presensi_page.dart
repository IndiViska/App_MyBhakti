import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() =>
      _PresensiPageState();
}

class _PresensiPageState
    extends State<PresensiPage> {
  LatLng currentPosition =
      const LatLng(-6.973316, 107.630478);

  File? selfieImage;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  // ================= LOCATION =================

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return;
    }

    permission =
        await Geolocator.checkPermission();

    if (permission ==
        LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission();
    }

    if (permission ==
            LocationPermission.denied ||
        permission ==
            LocationPermission.deniedForever) {
      return;
    }

    Position position =
        await Geolocator.getCurrentPosition();

    setState(() {
      currentPosition = LatLng(
        position.latitude,
        position.longitude,
      );
    });
  }

  // ================= CAMERA =================

  Future<void> openCamera() async {
    final picker = ImagePicker();

    final pickedFile =
        await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        selfieImage = File(
          pickedFile.path,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xffF3F3F3),

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
                  bottomLeft:
                      Radius.circular(38),

                  bottomRight:
                      Radius.circular(38),
                ),
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [
                  Container(
                    width: 38,
                    height: 38,

                    decoration: BoxDecoration(
                      color: Colors.white24,

                      borderRadius:
                          BorderRadius.circular(
                        100,
                      ),
                    ),

                    child: IconButton(
                      padding: EdgeInsets.zero,

                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),

                  const Text(
                    "Presensi",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  Container(
                    width: 38,
                    height: 38,

                    decoration:
                        const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: const Center(
                      child: Text(
                        "A",

                        style: TextStyle(
                          color:
                              Color(0xffB1121B),

                          fontWeight:
                              FontWeight.bold,

                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ================= CONTENT =================

            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.all(14),

                child: Container(
                  padding:
                      const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      // ================= TOP =================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,

                        children: [
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: const [
                              Text(
                                "Check In",

                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight
                                          .w700,
                                ),
                              ),

                              SizedBox(height: 2),

                              Text(
                                "Jumat, 10 April 2026",

                                style: TextStyle(
                                  color:
                                      Colors.grey,

                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),

                          const Text(
                            "09.00",

                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                                  FontWeight
                                      .w700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // ================= KARYAWAN =================

                      Container(
                        width: double.infinity,

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 18,
                        ),

                        decoration:
                            BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),

                          border: Border.all(
                            color: Colors
                                .grey.shade300,
                          ),
                        ),

                        child: const Column(
                          children: [
                            Text(
                              "KARYAWAN",

                              style: TextStyle(
                                color:
                                    Colors.grey,

                                fontSize: 10,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              "Ayu Setiawan",

                              style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                    FontWeight
                                        .w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // ================= MAP =================

                      const Text(
                        "LOKASI SAAT INI",

                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),

                      const SizedBox(height: 8),

                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),

                        child: SizedBox(
                          width: double.infinity,
                          height: 395,

                          child: GoogleMap(
                            initialCameraPosition:
                                CameraPosition(
                              target:
                                  currentPosition,

                              zoom: 17.5,
                            ),

                            markers: {
                              Marker(
                                markerId:
                                    const MarkerId(
                                  "current",
                                ),

                                position:
                                    currentPosition,
                              ),
                            },

                            myLocationEnabled:
                                true,

                            myLocationButtonEnabled:
                                false,

                            zoomControlsEnabled:
                                false,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ================= ALAMAT =================

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),

                        decoration:
                            BoxDecoration(
                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),

                          border: Border.all(
                            color: Colors
                                .grey.shade300,
                          ),
                        ),

                        child: const Row(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 24,
                            ),

                            SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [
                                  Text(
                                    "ALAMAT TERDETEKSI",

                                    style:
                                        TextStyle(
                                      color:
                                          Colors
                                              .grey,

                                      fontSize:
                                          10,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 4,
                                  ),

                                  Text(
                                    "Jl. Telekomunikasi No. 1, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257.",

                                    style:
                                        TextStyle(
                                      fontSize:
                                          13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ================= BUTTON =================

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 55,

                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xffC30D19,
                                ),

                                borderRadius:
                                    BorderRadius.circular(
                                  14,
                                ),
                              ),

                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,

                                children: [
                                  Icon(
                                    Icons.home,
                                    color: Colors
                                        .white,
                                    size: 18,
                                  ),

                                  SizedBox(
                                    height: 4,
                                  ),

                                  Text(
                                    "WFO",

                                    style:
                                        TextStyle(
                                      color:
                                          Colors
                                              .white,

                                      fontWeight:
                                          FontWeight
                                              .w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Container(
                              height: 55,

                              decoration:
                                  BoxDecoration(
                                color:
                                    Colors.white,

                                borderRadius:
                                    BorderRadius.circular(
                                  14,
                                ),

                                border: Border.all(
                                  color: Colors
                                      .grey
                                      .shade300,
                                ),
                              ),

                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,

                                children: [
                                  Icon(
                                    Icons.work,
                                    color: Colors
                                        .grey
                                        .shade700,

                                    size: 18,
                                  ),

                                  const SizedBox(
                                    height: 4,
                                  ),

                                  Text(
                                    "DINAS / WFA",

                                    style:
                                        TextStyle(
                                      color: Colors
                                          .grey,

                                      fontWeight:
                                          FontWeight
                                              .w500,

                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // ================= FOTO SELFIE =================

                      const Text(
                        "FOTO SELFIE",

                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: openCamera,

                        child: Container(
                          width: double.infinity,
                          height: 170,

                          decoration:
                              BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              18,
                            ),

                            border: Border.all(
                              color: Colors
                                  .grey
                                  .shade300,
                            ),
                          ),

                          child:
                              selfieImage != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(
                                        18,
                                      ),

                                      child:
                                          Image.file(
                                        selfieImage!,
                                        fit: BoxFit
                                            .cover,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,

                                      children: const [
                                        Icon(
                                          Icons
                                              .camera_alt_outlined,

                                          size: 42,

                                          color: Colors
                                              .grey,
                                        ),

                                        SizedBox(
                                          height:
                                              10,
                                        ),

                                        Text(
                                          "Tap untuk selfie",

                                          style:
                                              TextStyle(
                                            color:
                                                Colors.grey,

                                            fontSize:
                                                13,
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}