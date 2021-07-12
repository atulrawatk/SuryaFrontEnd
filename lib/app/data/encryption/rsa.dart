import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

class RSAEncryption{
  String Encrypt_with_pk(String public_key , String plain_text)
  {
    AsymmetricKeyParameter<RSAPublicKey> keyParametersPublic = new PublicKeyParameter(RsaKeyHelper().parsePublicKeyFromPem(public_key));
    final encrypter = Encrypter(RSA(publicKey: keyParametersPublic.key, encoding: RSAEncoding.PKCS1));
    final encrypted = encrypter.encrypt(plain_text);
    return encrypted.base64;
  }

  static String Decrypt_with_sk(String private_key ,String cipher_text)
  {
    AsymmetricKeyParameter<RSAPrivateKey> keyParametersPrivate = new PrivateKeyParameter(RsaKeyHelper().parsePrivateKeyFromPem(private_key));
    final encryptor = Encrypter(RSA(privateKey: keyParametersPrivate.key, encoding: RSAEncoding.PKCS1));
    //Decrypting fromBase64
    final decrypted = encryptor.decrypt64(cipher_text);
    return decrypted;
  }
}