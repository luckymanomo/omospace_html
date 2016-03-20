package com.omospace.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/report")
public class ReportController{

   //@RequestMapping(method = RequestMethod.GET)
   @RequestMapping(method = RequestMethod.POST)
   public String printHello(ModelMap model, HttpServletRequest request) {
	  System.out.println("request.getCharacterEncoding():"+request.getCharacterEncoding());
	  //request.setCharacterEncoding("UTF-8"); //force encoding

	  String name=request.getParameter("name");
	  HashMap<String, Object> parameters=new HashMap<String, Object>();
	  parameters.put("fullname", name);
	  System.out.println("name:"+name);
      model.addAttribute("Parameter", parameters);
      model.addAttribute("JRDataSource", null);
      model.addAttribute("JasperPath", "/WEB-INF/jasperReport/customer.jasper");

      return "jasperView";
   }

}