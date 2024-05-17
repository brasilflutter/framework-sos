import 'package:flutter/material.dart';
import 'package:framework_sos/framework_sos.dart';

class InputValidator {
  //Contexto adicionado para ser possível buscar string no applocalization
  final BuildContext context;
  final String? value;
  String? _message;

  InputValidator({required this.context, required this.value});
  String? get message => _message;

  String? validateEmptyField({String? errorText}) {
    if (value?.isEmpty ?? true) {
      return _message = errorText ?? "Esse campo não pode ser vazio";
    }
    return _message;
  }

  String? validateMaxLength(int maxLength, {String? errorText}) {
    if ((value?.length ?? 0) > maxLength) {
      return _message = errorText ?? "Esse campo deve ter no máximo $maxLength caractere(s)";
    }
    return _message;
  }

  String? validateMinLength(int minLength, {String? errorText}) {
    if ((value?.length ?? 0) < minLength) {
      return _message = errorText ?? "Esse campo deve ter no mínimo $minLength caractere(s)";
    }
    return _message;
  }

  String? validatePassword({String? errorText}) {
    if (PasswordValidator.hasSpecialCharacter(value ?? '')) {
      return _message = errorText ?? "Senha tem que ter pelo menos uma letra, número e caracteres especiais";
    }
    return _message;
  }

  String? validateConfirmPassword(String? password, {String? errorText}) {
    if (value != password) {
      return _message = errorText ?? "Senha não confere.";
    }
    return _message;
  }

  String? validateTransferValue({
    required double userBalance,
    required double transferValue,
    required double pixAvailableLimit,
  }) {
    if (transferValue <= 0) {
      return 'Valor inválido';
    } else if (userBalance < transferValue) {
      return 'Saldo insuficiente';
      // } else if (pixAvailableLimit < transferValue) {
      //   return 'Limite insuficiente';
    }
    return null;
  }

  String? validateCopyPastePixKey({String? errorText}) {
    final isOk = value?.toLowerCase().contains('br.gov.bcb.pix') ?? false;
    if (isOk == false) {
      return _message = errorText ?? 'Digite uma chave válida';
    }
    return _message;
  }
}
