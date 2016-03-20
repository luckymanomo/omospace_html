<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String logStr = null;
	java.util.Enumeration<java.lang.String> enumString = request.getAttributeNames();
	while (enumString.hasMoreElements()) {
		String key = enumString.nextElement();
		Object value = request.getAttribute(key);
		if (key.equalsIgnoreCase("logStr")) {
			if (value instanceof String) {
				logStr = (String)value;
				System.out.println("in");
			}
		}
	}

	System.out.println("logStr:" + logStr);

%>
<html>
<head>
<body>
	<%=logStr%>
</body>
</head>
</html>