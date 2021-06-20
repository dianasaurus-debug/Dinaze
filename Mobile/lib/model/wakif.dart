class Wakif {
  int? id;
  String? nik;
  String? nama;
  String? email;
  String? nomorPonsel;
  String? alamat;
  String? foto;

  Wakif({
    this.id,
    this.nik,
    this.nama,
    this.email,
    this.nomorPonsel,
    this.alamat,
    this.foto,
  });

  factory Wakif.create(Map<String, dynamic> data) => Wakif(
        id: data['id'],
        nik: data['nik'],
        nama: data['nama'],
        email: data['email'],
        nomorPonsel: data['nomor_ponsel'],
        alamat: data['alamat'],
        foto: data['foto'],
      );
}
