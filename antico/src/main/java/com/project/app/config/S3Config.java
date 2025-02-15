package com.project.app.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;

/*
 * AWS S3 라이브러리 빈 설정 클래스
 */

@Configuration
public class S3Config {
	
   // IAM 사용자 엑세스 키
   @Value("${cloud.aws.credentials.access-key}")
   private String accessKey;
   
   // IAM 사용자 비밀 엑세스 키
   @Value("${cloud.aws.credentials.secret-key}")
   private String secretKey;
   
   // S3 버켓 리전
   @Value("${cloud.aws.region.static}")
   private String region;

   @Bean
   public S3Client s3Client () {
     AwsBasicCredentials credentials = AwsBasicCredentials.create(accessKey, secretKey); // AWS IAM 사용자 자격 증명 객체

     return S3Client.builder()
             .region(Region.of(region))  // 리전 설정
             .credentialsProvider(StaticCredentialsProvider.create(credentials))  // 자격 증명 설정
             .build();
   }
}
