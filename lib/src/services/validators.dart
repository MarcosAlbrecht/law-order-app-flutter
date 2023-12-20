import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu email';
  }
  if (!email.isEmail) {
    return 'Digite um email válido';
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Digite sua senha';
  }
  if (password.length < 7) {
    return 'Digite uma senha com pelo menos 7 caracteres';
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite seu nome';
  }

  return null;
}

String? lastNameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Digite seu sgundo nome';
  }

  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Digite um número de celular';
  }
  if (!phone.isPhoneNumber || phone.length < 13) {
    return 'Digite um número válido';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Digite seu CPF';
  }
  if (!cpf.isCpf) {
    return 'Digite um CPF válido';
  }
  return null;
}

String? cepValidator(String? cep) {
  if (cep == null || cep.isEmpty || cep.length != 9) {
    return 'Digite seu CEP';
  }

  return null;
}

String? nascimentoValidator(DateTime? dateTime) {
  if (dateTime == null) {
    return 'Digite sua data de nascimento';
  }
  DateTime dataNascimento = dateTime;

  DateTime dataAtual = DateTime.now();
  DateTime dataDezoitoAnosAtras =
      dataAtual.subtract(const Duration(days: 18 * 365));

  if (!dataNascimento.isBefore(dataDezoitoAnosAtras)) {
    return "Deve ser maior de 18 anos";
  }

  return null;
}
