<%@page import="java.io.IOException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%
String fileName="";
String filePath="";
java.util.Enumeration<String> enumString = request.getAttributeNames();
while (enumString.hasMoreElements()) {
	String key = enumString.nextElement();
	Object value = request.getAttribute(key);
	if (key.equalsIgnoreCase("fileName") && (value instanceof String)) {
		fileName=value.toString();
	}else if(key.equalsIgnoreCase("torrentCPath") && (value instanceof String)) {
		filePath=value.toString();
	}
	
}
%>
<%
	//String filename = "home.jsp";
	java.io.File file = new java.io.File(filePath + java.io.File.separator + fileName);
	response.setContentType("APPLICATION/OCTET-STREAM");
	response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
	// Get the size of the file
	long length = file.length();

	response.setHeader("Content-Type", getServletContext().getMimeType(fileName));
	response.setHeader("Content-Length", String.valueOf(length));
	java.io.FileInputStream fileInputStream = new java.io.FileInputStream(file);

	if (length > Integer.MAX_VALUE) {
		throw new java.io.IOException("Could not completely read file " + file.getName()+ " as it is too long (" + length + " bytes, max supported " + Integer.MAX_VALUE + ")");
	}
	BufferedInputStream input = null;
	BufferedOutputStream output = null;

	try {
		input = new BufferedInputStream(new FileInputStream(file));
		output = new BufferedOutputStream(response.getOutputStream());
		byte[] buffer = new byte[8192];
		int length1 = 0;
		while ((length1 = input.read(buffer)) > 0) {
			output.write(buffer, 0, length1);
		}
	} finally {
		if (output != null) try {output.close();} catch (IOException logOrIgnore) {}
		if (input != null) try {input.close();} catch (IOException logOrIgnore) {}
	}
%> 