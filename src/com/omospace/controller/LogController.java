package com.omospace.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/log")
public class LogController {
	@RequestMapping(method = RequestMethod.GET)
	public String printHello(ModelMap model, HttpServletRequest request) {

		Properties properties = new Properties();
		String logStr="";
		try {
			properties.load(request.getServletContext().getResourceAsStream("/WEB-INF/application.properties"));
			String line=request.getParameter("line");
			int row = 1000; //default
			try{
				row=Integer.parseInt(line);
			}catch(Exception e){
				e.printStackTrace();
			}

			String logPath=properties.get("logpath")+"";
			File file=new File(logPath);

			FileReader fr=new FileReader(file);
			BufferedReader br=new BufferedReader(fr);

			String lineB=null;


			while((lineB=br.readLine())!=null && row!=0){
				logStr+=(lineB+"<br>");
				row--;
			}
		} catch (IOException e) {
			e.printStackTrace();
			logStr+=e.getMessage()+"<br>";
		}
		model.addAttribute("logStr", logStr);

		return "log";
	}
}
