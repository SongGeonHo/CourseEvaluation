package com.example.lectureevaluation.util;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;


public class Gmail extends Authenticator {


    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication("songgun1234@gmail.com","yagp wvyo duhw grfw");
        // 관리자의 메일 주소와 구글 계정의 2차 앱 비밀번호를 입력해준다.
    }
}
