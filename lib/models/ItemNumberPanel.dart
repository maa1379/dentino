class ItemNumberPanel {
  ItemNumberPanel({
    this.name,
    this.companiesNumber,
    this.clinicDiscountNumber,
    this.doctorNumber,
    this.reservtionNumber,
  });

  String name;
  int companiesNumber;
  int clinicDiscountNumber;
  int doctorNumber;
  int reservtionNumber;

  factory ItemNumberPanel.fromJson(Map<String, dynamic> json) => ItemNumberPanel(
    name: json["name"],
    companiesNumber: json["companies_number"],
    clinicDiscountNumber: json["clinic_discount_number"],
    doctorNumber: json["doctor_number"],
    reservtionNumber: json["reservtion_number"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "companies_number": companiesNumber,
    "clinic_discount_number": clinicDiscountNumber,
    "doctor_number": doctorNumber,
    "reservtion_number": reservtionNumber,
  };
}
