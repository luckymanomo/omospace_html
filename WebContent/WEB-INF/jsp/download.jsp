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
  response.setContentType("APPLICATION/OCTET-STREAM");   
  response.setHeader("Content-Disposition","attachment; filename=\"" + fileName + "\"");   
  
  java.io.File file=new java.io.File(filePath+java.io.File.separator+fileName);
  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(file);  
  // Get the size of the file
  long length = file.length();
  
  if (length > Integer.MAX_VALUE) {
      throw new java.io.IOException("Could not completely read file " + file.getName() + " as it is too long (" + length + " bytes, max supported " + Integer.MAX_VALUE + ")");
   }

  
  response.setBufferSize(1048576);
  System.out.println("response.getBufferSize():"+response.getBufferSize());
  byte[] bytes = new byte[4086];
  int i;   
  while ((i=fileInputStream.read()) != -1) {  
	  response.getOutputStream().write(i);
	  
  }
  
	fileInputStream.close();
	response.getOutputStream().flush();
  
  
%> 