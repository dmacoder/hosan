package com.cafe24.hosan.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;
 
public class SHA256 {
 
    public static String encrypt(String source, String salt) {
        return ecrypt(source, salt.getBytes());
    }
    
    public static String ecrypt(String source, byte[] salt) {
        
        String result = "";
        
        byte[] sources = source.getBytes();
        byte[] bytes = new byte[sources.length + salt.length];
        
        System.arraycopy(sources, 0, bytes, 0, sources.length);
        System.arraycopy(salt, 0, bytes, sources.length, salt.length);
        
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(bytes);
            
            byte[] byteData = md.digest();
            
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < byteData.length; i++) {
                sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
            }
            
            result = sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        
        return result;
    }
    //8자리 SALT 추가 hash collision 방지
    public static String generateSalt() {
        Random random = new Random();
        
        byte[] salt = new byte[8];
        random.nextBytes(salt);
        
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < salt.length; i++) {
            // Byte TO Hex 
            sb.append(String.format("%02x",salt[i]));
        }
        
        return sb.toString();
    }
    
}