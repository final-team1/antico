package com.project.app.common;

import java.util.List;

import lombok.Getter;

/*
 * 파일 업로드 시 파일의 확장자를 검사하기 위한 확장자 지정 ENUM
 */

@Getter
public enum FileType {
	
	IMAGE(List.of("jpg", "jpeg", "png", "gif")), // 이미지 파일

	ALL(List.of("")); // 전체 허용

	private final List<String> fileExtension; // 확장자 리스트
	
	FileType(List<String> fileExtension) {
		this.fileExtension = fileExtension; 
	}

}
