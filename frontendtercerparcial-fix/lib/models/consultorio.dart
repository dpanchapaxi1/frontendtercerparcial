class Consultorio {
  int id;
  String numero;
  int piso;

  Consultorio({
    required this.id,
    required this.numero,
    required this.piso,
  });

  factory Consultorio.fromJson(Map<String, dynamic> json) {
    return Consultorio(
      id: json['id'],
      numero: json['numero'],
      piso: json['piso'],
    );
  }
}
