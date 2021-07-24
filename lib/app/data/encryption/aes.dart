import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:surya/app/data/encryption/algo/decrypt_algo.dart';
import 'package:surya/dot_env_controller.dart';
/* In this project, AES Method is used to store data locally in the device for better security */
class AESEncryption{

  //Encryptor Initialization
   Encrypter _encryptorInitialize({required String key}){
    return Encrypter(AES(Key.fromBase16(key) , mode: AESMode.cbc));
  }

  //Encrypting Normal Text using key and iv(initialization vector)
   String encryptDataAES({required String key, required String iv, required String plainText})
  {
    final encryptor = _encryptorInitialize(key: decryptAlgo(64, key));
    final encrypted = encryptor.encrypt(plainText, iv: IV.fromBase16(decryptAlgo(32, iv)));
    return encrypted.base16;
  }

  //Decrypting Cipher Text using key and iv(initialization vector)
   String decryptDataAES({required String key, required String iv, required String cipherText})
  {
    final encryptor = _encryptorInitialize(key: decryptAlgo(64, key));
    final decrypted = encryptor.decrypt(Encrypted.fromBase16(cipherText), iv: IV.fromBase16(decryptAlgo(32, iv)));
    return decrypted;
  }

  //Basic AES encrypt

  String encryptAESFull({required String plainText}){
     DotEnvController _dotEnv=Get.find<DotEnvController>();
     return encryptDataAES(key: _dotEnv.encryptKey, iv: _dotEnv.encryptIv, plainText: plainText);
   }

   String decryptAESFull({required String cipherText}){
     DotEnvController _dotEnv=Get.find<DotEnvController>();
     return decryptDataAES(key: _dotEnv.encryptKey, iv: _dotEnv.encryptIv, cipherText: cipherText);

   }
}