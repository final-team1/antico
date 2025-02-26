package com.project.app.member.domain;

import lombok.Data;
import lombok.Getter;

@Getter
public class KakaoUserDataVO {

	public Long id;
	public String connected_at;
	public Properties properties;
	public Kakao_account kakao_account;

		@Data
		public class Kakao_account {
			
			public Boolean profile_nickname_needs_agreement;
			public Boolean profile_image_needs_agreement;
			public Boolean name_needs_agreement;
			public Boolean phone_number_needs_agreement;
			public Profile profile;
			public Boolean has_email;
			public Boolean email_needs_agreement;
			public Boolean is_email_valid;
			public Boolean is_email_verified;
			public String email;
			public String phone_number;
			public String name;
			public Boolean has_phone_number;
			
			@Data
			public class Profile {
				
				public String is_default_nickname;
				public Boolean name_needs_agreement;
				public String nickname;
				public String thumbnail_image_url;
				public String profile_image_url;
				public Boolean is_default_image;
				
				
				
			}
		}
		
		@Data
		public class Properties {
			
			public String nickname;
			public String profile_image;
			public String thumbnail_image;
			
		}
	
}
