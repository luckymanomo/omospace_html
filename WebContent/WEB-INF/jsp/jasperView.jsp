<%@ page import="java.io.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.*"%>
<%@ page import="net.sf.jasperreports.engine.*"%>
<%@ page import="net.sf.jasperreports.engine.export.*"%>
<%@page language="java" contentType="application/pdf; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<%
	String sourceFilePath = null;
	HashMap<String, Object> parameters = null;
	JRDataSource jrDataSource = null;
	String jasperName = null;
	java.util.Enumeration<java.lang.String> enumString = request
			.getAttributeNames();
	while (enumString.hasMoreElements()) {
		String key = enumString.nextElement();
		Object value = request.getAttribute(key);
		if (key.equalsIgnoreCase("Parameter")) {
			if (value instanceof HashMap) {
				parameters = (HashMap<String, Object>) value;
			}
		} else if (key.equalsIgnoreCase("JRDataSource")) {
			if (value instanceof JRDataSource) {
				jrDataSource = (JRDataSource) value;
			}
		} else if (key.equalsIgnoreCase("JasperPath")) {
			if (value instanceof String) {
				sourceFilePath = application.getRealPath(value + "");
			}
		}
	}

	System.out.println("sourceFilePath:" + sourceFilePath);

	byte[] bytes = null;
	try {
		JasperPrint jasperPrint = null;
		jasperPrint = JasperFillManager.fillReport(sourceFilePath,
				parameters, jrDataSource);
		bytes = JasperExportManager.exportReportToPdf(jasperPrint);

	} catch (JRException e) {
		e.printStackTrace();
	}

	response.setContentType("application/pdf");
	response.setContentLength(bytes.length);
	ServletOutputStream outStream = response.getOutputStream();
	outStream.write(bytes, 0, bytes.length);
	outStream.flush();
	outStream.close();
%>
