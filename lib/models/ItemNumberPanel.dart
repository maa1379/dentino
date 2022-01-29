class ItemNumberPanel {
  ItemNumberPanel({
    this.name,
    this.companiesNumber = 0,
    this.clinicDiscountNumber = 0,
    this.doctorNumber = 0,
    this.reservtionNumber = 0,
  });

  String name;
  int companiesNumber = 0;
  int clinicDiscountNumber = 0;
  int doctorNumber = 0;
  int reservtionNumber= 0;

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
