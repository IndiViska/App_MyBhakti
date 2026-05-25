class ProjectDraft {
  // ================= PAGE 1 =================
  String? kategoriProyek;
  String? kategoriMarket;
  String? judul;
  String? deskripsi;

  // ================= PAGE 2 =================
  String? customerSelected;
  String? endUserSelected;

  String? newCustomerName;
  String? newCustomerPic;

  String? newEndUserName;
  String? newEndUserPic;

  String? newCustomerPhone;
  String? newEndUserPhone;

  // ================= PAGE 3 =================
  String? picLt;
  String? picMarketing;

  // ================= PAGE 4 =================
  String? nilaiPekerjaan;
  DateTime? startDate;
  DateTime? endDate;

  ProjectDraft({
    this.kategoriProyek,
    this.kategoriMarket,
    this.judul,
    this.deskripsi,
    this.customerSelected,
    this.endUserSelected,
    this.newCustomerName,
    this.newCustomerPic,
    this.newEndUserName,
    this.newEndUserPic,
    this.newCustomerPhone,
    this.newEndUserPhone,
    this.picLt,
    this.picMarketing,
    this.nilaiPekerjaan,
    this.startDate,
    this.endDate,
  });
}
