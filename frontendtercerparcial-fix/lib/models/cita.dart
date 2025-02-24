class Cita {
  final int? id;
  final int paciente_Id;
  final int medico_Id;
  final String fecha;
  final String hora;
  final String consultorioNumero;

  Cita({this.id, required this.paciente_Id, required this.medico_Id, required this.fecha, required this.hora, required this.consultorioNumero});

  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
      id: json['id'],
      paciente_Id: json['paciente_Id'],
      medico_Id: json['medico_Id'],
      fecha: json['fecha'],
      hora: json['hora'],
      consultorioNumero: json['consultorioNumero'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paciente_Id': paciente_Id,
      'medico_Id': medico_Id,
      'fecha': fecha,
      'hora': hora,
      'consultorioNumero': consultorioNumero,
    };
  }
}
