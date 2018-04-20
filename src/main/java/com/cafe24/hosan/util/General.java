package com.cafe24.hosan.util;
import java.util.Random;


public class General {

	//인증키 생성 메소드
	public static String getAuth_key() {
		Random rnd =new Random();

		StringBuffer buf =new StringBuffer();

		for(int i=0;i<8;i++){
			
		    if(rnd.nextBoolean()){
		    	//영문 생성
		        buf.append((char)((int)(rnd.nextInt(26))+97));
		    }else{
		    	//숫자 생성
		        buf.append((rnd.nextInt(10)));
		    }
		}
		
		return buf.toString();
	}
	


}
