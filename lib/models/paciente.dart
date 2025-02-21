class Paciente {
  int id;
  String nombre;
  String apellido;
  String fechaNacimiento;
  String email;

  Paciente({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.email,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      fechaNacimiento: json['fechaNacimiento'],
      email: json['email'],
    );
  }
}
