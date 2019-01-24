//FIleUploadService는 수업시간에 강사님이 쓰신것을 그대로 사용. 
//후에 여기랑 beans.xml에서 파일이 저장되는 경로를 수정해야 함.
package com.example.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service("fileUploadService")
public class FileUploadService {
	private String uploadPath = null;
	//Windows의 경우에는 JVM이 자동으로 Eclipse의 workspace의 drive를 인식한다.
	public String restore(MultipartFile multipartFile, String uploadPath) {
		this.uploadPath = uploadPath;
		String uri = null;
		try {
			String originalName = multipartFile.getOriginalFilename();
			String extName = originalName.substring(originalName.lastIndexOf("."), 
																			originalName.length());
			long fileSize = multipartFile.getSize();
			String savedFileName = this.generateSavedName(extName);
			
			System.out.println("originalName = " + originalName);
			System.out.println("extName = " + extName);
			System.out.println("fileSize = " + fileSize);
			System.out.println("savedFileName = " + savedFileName);
			
			saveToFileSystem(multipartFile, savedFileName);
			uri = savedFileName;
		}catch(Exception ex) {
			System.out.println(ex);
		}	
		return uri;
	}
	
	public String restore1(MultipartFile multipartFile, String uploadPath) { // 진웅이가만든거
		this.uploadPath = uploadPath;
		String uri = null;
		try {
			String originalName = multipartFile.getOriginalFilename();
			saveToFileSystem(multipartFile, originalName);
			uri = originalName;
		}catch(Exception ex) {
			System.out.println(ex);
		}	
		return uri;
	}
	//파일 저장
	private void saveToFileSystem(MultipartFile mFile, String savedFileName) 
			throws IOException{
		byte [] buffers = mFile.getBytes();
		File file = new File(this.uploadPath + "/" + savedFileName);  //C:/upload/2018...jpg
		FileOutputStream fos = new FileOutputStream(file);
		fos.write(buffers);
		fos.close();
	}
	//파일 이름 변경
	private String generateSavedName(String extName) {
		String newName = "";
		Calendar now = Calendar.getInstance();
		newName += now.get(Calendar.YEAR);
		newName += now.get(Calendar.MONTH) + 1;
		newName += now.get(Calendar.DATE);
		newName += now.get(Calendar.HOUR_OF_DAY);
		newName += now.get(Calendar.MINUTE);
		newName += now.get(Calendar.SECOND);
		newName += now.get(Calendar.MILLISECOND);
		newName += extName;
		return newName;
	}
}
