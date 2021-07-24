import 'dart:math';

String decryptAlgo(int length,String inputString)
{

  if(length%2==0)
  {
    return(decryptEvenLengthString(inputString));
  }
  else
  {
    return(decryptOddLengthString(inputString));
  }
}

String decryptEvenLengthString(String inputString)
{
  String decryptedString = "";

  int length = inputString.length;

  int i = 0;
  bool skipThree = true;



  while(i<length)
  {
    if(i==0)
    {
      decryptedString =  decryptedString+inputString.substring(i,i+1);
      i = i+3;
    }
    else
    {
      if(skipThree)
      {
        decryptedString = decryptedString + inputString.substring(i,(i+1));
        i = i+2;
        skipThree = false;
      }
      else
      {
        decryptedString = decryptedString + inputString.substring(i,(i+1));
        i = i+3;
        skipThree = true;
      }

    }

  }

  //reversing the string
  String reversedString = (decryptedString.split('').reversed.join()).toString();
  return reversedString;
}

String decryptOddLengthString(String inputString)
{
  String decryptedString = "";

  int length = inputString.length;

  int i = 0;
  bool skipTwo = true;

  while(i<length)
  {
    if(i==0)
    {
      decryptedString =  decryptedString+inputString.substring(i,i+1);
      i = i+2;
    }
    else
    {
      if(skipTwo)
      {
        decryptedString = decryptedString + inputString.substring(i,(i+1));
        i = i+3;
        skipTwo = false;
      }
      else
      {
        decryptedString = decryptedString + inputString.substring(i,(i+1));
        i = i+2;
        skipTwo = true;
      }

    }

  }

  //reversing the string
  String reversedString = (decryptedString.split('').reversed.join());
  return(reversedString);
}

