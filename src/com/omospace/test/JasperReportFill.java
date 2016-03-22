package com.omospace.test;

import java.util.HashMap;
import java.util.Map;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

public class JasperReportFill {
	public static void main(String[] args) {
		String sourceFileName = "D:/java_source_code/LEADs/fitdogcat/WebContent/WEB-INF/jasperReport/customer.jasper";

		HashMap<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("fullname", "พงศกร d");
		try {
			JasperPrint jasperPrint = null;
			jasperPrint = JasperFillManager.fillReport(sourceFileName,parameters, new JREmptyDataSource());
			JasperExportManager.exportReportToPdfFile(jasperPrint, "D:/java_source_code/LEADs/fitdogcat/WebContent/WEB-INF/jasperReport/simple_report.pdf");
			System.out.println("Export succesfully");//test jae kuy
		} catch (JRException e) {
			e.printStackTrace();
		}
	}
}