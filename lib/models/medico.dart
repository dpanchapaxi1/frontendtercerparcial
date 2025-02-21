class Medico {
  int id;
  String nombre;
  String apellido;
  String especialidad;

  Medico({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.especialidad,
  });

  factory Medico.fromJson(Map<String, dynamic> json) {
    return Medico(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      especialidad: json['especialidad'],
    );
  }
}