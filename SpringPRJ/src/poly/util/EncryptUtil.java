package poly.util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;

public class EncryptUtil {
		
		final static String addMessage = "PolyDataAnalysis";
		
		//AES128-CBC 암호화 함수 의 초기 벡터(16바이트 단위로 암호화, 16바이트 미만이면 뒤에 추가되는 바이트)
		final static byte[] ivByte = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
		// key 값은 16자리 문자만 가능
		final static String key = "PolyTechnic12345";
		
		// AES 암호화기능을 하는 함수 
		public static String encAES128CBC(String str)
			throws UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, 
			InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException { 
			
			byte[] textBytes = str.getBytes("UTF-8");
			AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivByte);
			SecretKeySpec newKey = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
			Cipher cipher = null;
			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, newKey, ivSpec);
			
			return Base64.encodeBase64String(cipher.doFinal(textBytes));
		}
		
		// AES 복호화기능을 하는 함수
		public static String decAES128CBC(String str)
				throws UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException, 
				InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException { 
				
				//byte[] textBytes = str.getBytes("UTF-8");
				byte[] textBytes = Base64.decodeBase64(str);
				AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivByte);
				SecretKeySpec newKey = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
				Cipher cipher = null;
				cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
				cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec);
				
				return new String(cipher.doFinal(textBytes), "UTF-8");
			}
		
		public static String encHashSHA256(String str) throws Exception{
			 String res = "";
			 String planText = addMessage + str;
			 
			 try {
				 MessageDigest sh = MessageDigest.getInstance("SHA-256");
				 sh.update(planText.getBytes());
				 
				 byte byteData[] = sh.digest();
				 
				 StringBuffer sb = new StringBuffer();
				 
				 for(int i = 0; i < byteData.length; i++) {
					 sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
				 }
				 
				 res = sb.toString();
				 
				 } catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
					
					res ="";
				}
			 return res;
		}
	
}
