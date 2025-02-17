package com.project.app.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;

import org.springframework.stereotype.Component;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class FileManager {

	public String doFileUpload(byte[] bytes, String originalFilename, String path) throws Exception {
		
		String newFileName = null;
		
		if(bytes == null) {
			return null;
		}
			
		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename == null || "".equals(originalFilename)) {
			return null;
		}

		String fileExt = originalFilename.substring(originalFilename.lastIndexOf(".")); 
		if(fileExt == null || "".equals(fileExt) || ".".equals(fileExt)) {
			return null;
		}

		newFileName = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance()); 
		newFileName += System.nanoTime();
		newFileName += fileExt;
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성한다.
		File dir = new File(path);
		// 파라미터로 입력받은 문자열인 path(파일을 저장할 경로)를 실제 폴더로 만든다.
		// 자바에서는 File 클래스를 사용하여 폴더 또는 파일을 생성 및 관리를 하게 된다.
		
		if(!dir.exists()) {
			// 만약에 파일을 저장할 경로인 폴더가 실제로 존재하지 않는다면
			
			dir.mkdirs(); // 파일을 저장할 경로인 폴더를 생성한다.
		}
		
		String pathname = path + File.separator + newFileName; 
		
		FileOutputStream fos = new FileOutputStream(pathname);
		// FileOutputStream 는 해당 경로 파일명(pathname)에 실제로 데이터 내용(byte[] bytes)을 기록해주는 클래스 이다.
		// 이러한 일을 하는 FileOutputStream 객체 fos 를 생성한다.
		
		fos.write(bytes);
		// write(byte[] bytes) 메소드가 해당 경로 파일명(pathname)에 실제로 데이터 내용(byte[] bytes)을 기록해주는 일을 하는 것이다.
		
		fos.close();
		// 생성된 FileOutputStream 객체 fos 가 더이상 사용되지 않도록 소멸 시킨다.
		
		return newFileName;
		// 파일을 업로드 한 이후에 
		// 업로드 되어진 파일명(현재의 년월일시분초에다가 현재 나노세컨즈nanoseconds 값을 결합하여 확장자를 붙여서 만든것)을 알아온다. 
		
	}// end of public String doFileUpload(byte[] bytes, String originalFilename, String path) throws Exception-----------
	
	
	
	// == 파일 업로드 하기 두번째 방법(네이버 스마트 에디터를 사용한 사진첨부에 해당하는 것임) ==
	public String doFileUpload(InputStream is, String originalFilename, String path) throws Exception {
		
		String newFilename = null;

		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename==null || originalFilename.equals("")) {
			return null;
		}	
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals("")) {
			return null;
		}
			
		// 서버에 저장할 새로운 파일명을 만든다.
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
		newFilename += System.nanoTime();
		newFilename += fileExt;
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}	
		
		String pathname = path + File.separator + newFilename;
		
		byte[] byteArr = new byte[1024];
		int size = 0;
		FileOutputStream fos = new FileOutputStream(pathname);
		
		while((size = is.read(byteArr)) != -1) {
			fos.write(byteArr, 0, size);
		}
		fos.flush();
		
		fos.close();
		is.close();
		
		return newFilename;		
		
	}// end of public String doFileUpload(InputStream is, String filename, String path)-------	
	
	
	
	// === 파일 다운로드 하기 === //
	public boolean doFileDownload(String fileName, String originalFilename, String path, HttpServletResponse response) {
		
	    String pathname = path + File.separator + fileName;
	    
	    try {
		    if(originalFilename == null || "".equals(originalFilename) ) {
		    	originalFilename = fileName;
		    }
		    
		    originalFilename = new String(originalFilename.getBytes("UTF-8"), "8859_1");  

	    } catch(UnsupportedEncodingException e) {}
	    
	    try {
	    
		    File file = new File(pathname);
		    // 다운로드 할 파일명(pathname)을 가지고 File 객체를 생성한다. 
		    
		    if(file.exists()) { // 실제로 다운로드할 해당 파일이 존재한다라면
		    	
		    	response.setContentType("application/octet-stream");
		    	
		    	response.setHeader("Content-disposition",
				           		   "attachment; filename=" + originalFilename);
		    	
		    	byte[] readByte = new byte[4096];

		    	BufferedInputStream bfin = new BufferedInputStream(new FileInputStream(file)); 
		    	
		    	ServletOutputStream souts = response.getOutputStream();

		    	
		    	int length = 0;
				
				while( (length = bfin.read(readByte, 0, 4096)) != -1 ) {
					souts.write(readByte, 0, length);
				}// end of while()----------------------------------
				
				souts.flush(); // ServletOutputStream souts 에 기록(저장)해둔 내용을 클라이언트로 내본다. 
				
				souts.close(); // ServletOutputStream souts 객체를 소멸시킨다.
				bfin.close();  // BufferedInputStream bfin 객체를 소멸시킨다.
				
				return true; // 다운로드 해줄 파일이 존재하고 Exception 이 발생하지 않으면 true 를 리턴시킨다.  
				
		    }// end of if(file.exists())-----------------
	    
	    } catch(Exception e) {}
	    
		return false;
		
	}// end of public boolean doFileDownload(String fileName, String originalFilename, String path, HttpServletResponse response)------


	// === 파일 삭제하기 === //
	public void doFileDelete(String filename, String path) throws Exception {
		String pathname = path + File.separator + filename;
		
		File file = new File(pathname);
		
		if(file.exists()) {
			file.delete();
		}
		
	} // end of doFileDelete

	
}







