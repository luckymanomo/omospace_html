package com.omospace.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/download")
public class DownloadController {
	@RequestMapping(method = RequestMethod.GET)
	public String printHello(ModelMap model, HttpServletRequest request) {
		String fileName=request.getParameter("fileName");
		//System.out.println("fileName:"+fileName);
		//System.out.println("torrentCPath:"+MainController.torrentCPath);
		
		model.addAttribute("fileName", fileName);
		model.addAttribute("torrentCPath", MainController.torrentCPath);
		return "download";
	}
}
