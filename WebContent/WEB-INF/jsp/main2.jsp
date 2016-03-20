<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<script src="<c:url value="/resources/js/form.js" />"></script>
<link href="<c:url value="/resources/css/form.css" />" rel="stylesheet">


<title>Report</title>
</head>
<body>
	<div class="topic_content">
		Welcome to testing page.
	</div>
	<div class="tableLayout">
		<form action="<c:url value="/report" />" method="POST" target="_blank">
			<table align="center" class="main_content">
				<tr><td align="right">Parameter</td><td><input type="text" name="name"/></td></tr>
				<tr><td align="right">Number</td><td><input type='text' name="number1" onkeypress='return isNumberKey(event)'/></td></tr>
			</table>
			<input type="submit" value="View Report"/>
		</form>
	</div>

<span class="chart" data-percent="86">
		<span class="percent"></span>
	</span>

	<span class="btn js_update">Update chart</span>
	<script>
	$(function() {
		$('.chart').easyPieChart({
			easing: 'easeOutBounce',
			onStep: function(from, to, percent) {
				$(this.el).find('.percent').text(Math.round(percent));
			}
		});
		var chart = window.chart = $('.chart').data('easyPieChart');
		$('.js_update').on('click', function() {
			chart.update(Math.random()*200-100);
		});
	});
	</script>
</body>
</html>
