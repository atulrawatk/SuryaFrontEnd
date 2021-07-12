import 'package:encrypt/encrypt.dart';
/* In this project, AES Method is used to store data locally in the device for better security */
class AESEncryption{

  //Encryptor Initialization
  static Encrypter encryptorInitialize({required String key}){
    return Encrypter(AES(Key.fromBase16(key) , mode: AESMode.cbc));
  }

  //Encrypting Normal Text using key and iv(initialization vector)
  static String encryptDataAES({required String key, required String iv, required String plainText})
  {
    final encryptor = encryptorInitialize(key: key);
    final encrypted = encryptor.encrypt(plainText, iv: IV.fromBase16(iv));
    return encrypted.base16;
  }

  //Decrypting Cipher Text using key and iv(initialization vector)
  static String decryptDataAES({required String key, required String iv, required String cipherText})
  {
    final encryptor = encryptorInitialize(key: key);
    final decrypted = encryptor.decrypt(Encrypted.fromBase16(cipherText), iv: IV.fromBase16(iv));
    return decrypted;
  }
}