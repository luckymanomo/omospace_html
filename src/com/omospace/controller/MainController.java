package com.omospace.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class MainController {
	public static String torrentCPath="/torrentFiles/Completed";
	@RequestMapping(method = RequestMethod.GET)
	public String printHello(ModelMap model, HttpServletRequest request) {

		File file=new File("/");
		double dividerToGb=1024*1024*1024;
		double leftSpace=file.getFreeSpace()/dividerToGb;
		double totalSpace=file.getTotalSpace()/dividerToGb;
		double usedSpace=totalSpace-leftSpace;

		model.addAttribute("leftSpace", leftSpace);
		model.addAttribute("totalSpace", totalSpace);
		model.addAttribute("usedSpace", usedSpace);
		model.addAttribute("torrentCPath", torrentCPath);
		return "main";
	}
}
