package com.omospace.test;

import java.io.File;

public class TestMain {
	public static void main(String[] args){
		File file=new File("D:/java_source_code/LEADs/fitdogcat/WebContent/resources/aceJs");
		File[] fileList=file.listFiles();
		for(File subF:fileList){
			if(subF.getName().endsWith(".js")){
				System.out.println("<script src=\"<c:url value=\"/resources/aceJs/"+subF.getName()+"\" />\"></script>");
			}//test pongsakorn jae kaa kuy
		}
	}
}
