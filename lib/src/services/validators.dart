import 'package:app_law_order/src/models/avaliation_model.dart';
import 'package:app_law_order/src/models/avaliation_values_model.dart';
import 'package:app_law_order/src/models/occupation_areas_model.dart';
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
  if (cep == null || cep.isEmpty || cep.length != 8) {
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
  DateTime dataDezoitoAnosAtras = dataAtual.subtract(const Duration(days: 18 * 365));

  if (!dataNascimento.isBefore(dataDezoitoAnosAtras)) {
    return "Deve ser maior de 18 anos";
  }

  return null;
}

String? occupationAreaValidator(OccupationAreasModel? value) {
  if (value == null) {
    return 'Por favor, selecione uma área de atuação';
  }
  // Outras validações conforme necessário
  return null; // Retorna null se estiver tudo certo
}

String? avaliationValidator(AvaliationValuesModel? value) {
  if (value == null) {
    return 'Por favor, selecione uma opção';
  }
  // Outras validações conforme necessário
  return null; // Retorna null se estiver tudo certo
}

String? avaliationPlatformValidator(int? value) {
  if (value == null) {
    return 'Por favor, selecione uma opção';
  }
  // Outras validações conforme necessário
  return null; // Retorna null se estiver tudo certo
}

String? titleServiceValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Digite o Título do Serviço';
  }

  return null;
}

String? descriprionServiceValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Digite a Descrição do Serviço';
  }

  return null;
}

String? valueServiceValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Digite o Valor do Serviço';
  }

  return null;
}

String? skillValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Digite o Valor do Serviço';
  }

  return null;
}
