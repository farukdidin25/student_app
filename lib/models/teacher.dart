class Teacher {
  String ad;
  String soyad;
  int yas;
  String cinsiyet;

  Teacher(
    this.ad,
    this.soyad,
    this.yas,
    this.cinsiyet,
  );

  Teacher.fromMap(Map<String,dynamic> m) : this(
    m['ad'], m['soyad'], m['yas'], m['cinsiyet']
  );

  Map toMap() {
    return {
      'ad' : ad,
      'soyad':soyad,
      'yas':yas,
      'cinsiyet':cinsiyet
    };
  }

}