<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	//configuration
	String piePath="/torrentFiles";
	String torrentCPath="/torrentFiles/Completed";
	String torrentDPath="/torrentFiles/Downloading";
	java.util.Random r=null;
	java.awt.Color color=null;
	String hexColor=null;
	java.io.File filePath=null;
%>
<%
	class HalfRoundingFormat extends java.text.DecimalFormat{
		private static final long serialVersionUID = 1L;
		public HalfRoundingFormat(String string) {
			super(string);
			setRoundingMode(java.math.RoundingMode.HALF_UP);
		}
	}
	double leftSpace=0;
	double totalSpace=0;
	double usedSpace=0;
	java.text.NumberFormat formatter = new HalfRoundingFormat("#,##0.00");
	java.text.NumberFormat formatterNoComma = new HalfRoundingFormat("###0.00");
	java.util.Enumeration<String> enumString = request.getAttributeNames();
	while (enumString.hasMoreElements()) {
		String key = enumString.nextElement();
		Object value = request.getAttribute(key);
		if (key.equalsIgnoreCase("leftSpace") && (value instanceof Double)) {
			leftSpace=Double.parseDouble(value.toString());
		}else if(key.equalsIgnoreCase("totalSpace") && (value instanceof Double)) {
			totalSpace=Double.parseDouble(value.toString());
		}else if(key.equalsIgnoreCase("usedSpace") && (value instanceof Double)) {
			usedSpace=Double.parseDouble(value.toString());
		}
	}
%>
<html>
<head>



<link href="<c:url value="/resources/ace/css/bootstrap.min.css" />" rel="stylesheet" />
<link href="<c:url value="/resources/ace/css/bootstrap-responsive.min.css" />" rel="stylesheet" />
<link href="<c:url value="/resources/ace/css/font-awesome.min.css" />" rel="stylesheet">

<script src="<c:url value="/resources/js/form.js" />"></script>
<link href="<c:url value="/resources/css/form.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/ace.min.css" />" rel="stylesheet">

<title>Report</title>
</head>
<body>
	<div class="topic_content">Welcome to Monitoring Page.</div>
	<br>
	<br>
	<table class="tableLayout" border="0">
	<tr>
		<td valign="top">
			<table class="tableLayout" border="1">
				<tr>
					<td colspan="2">
						<form action="<c:url value="/report" />" method="POST" target="_blank"">
							<table class="tableLayout">
								<tr>
									<td>
										<table>
											<tr>
												<td align="right">Parameter</td>
												<td><input type="text" name="name" /></td>
											</tr>
											<tr>
												<td align="right">Number</td>
												<td><input type='text' name="number1"
													onkeypress='return isNumberKey(event)' /></td>
											</tr>
										</table>
									</td>
									<td valign="top"><input type="submit" value="View iReport">
									</td>
								</tr>
							</table>
						</form>
					</td>

				</tr>
				<tr>
					<td>
						<div class="infobox infobox-green">
							<div class="infobox-progress">
								<div class="easy-pie-chart percentage" data-percent="<%=(int)(leftSpace/totalSpace*100)%>" data-size="46">
									<span class="percent"><%=(int)(leftSpace/totalSpace*100)%></span> %
								</div>
							</div>
							<div class="infobox-data">
							<span class="infobox-text">HDD Space free</span>
								<div class="infobox-content">
									<span class="bigger-110">~</span> <%=(int)(leftSpace)%>GB / <%=(int)(totalSpace)%>GB
								</div>
							</div>
						</div>
					</td>
					<td>
						<!--<div class="infobox infobox-green infobox-small infobox-dark">
							<div class="infobox-progress">
								<div class="easy-pie-chart percentage" data-percent="61"
									data-size="39">
									<span class="percent">61</span> %
								</div>
							</div>
							<div class="infobox-data">
								<div class="infobox-content">Task</div>
								<div class="infobox-content">Completion</div>
							</div>
						</div>-->
						<div class="infobox infobox-red">
							<div class="infobox-progress">
								<div class="easy-pie-chart percentage" data-percent="<%=(int)(usedSpace/totalSpace*100)%>" data-size="46">
									<span class="percent"><%=(int)(usedSpace/totalSpace*100)%></span> %
								</div>
							</div>
							<div class="infobox-data">
							<span class="infobox-text">HDD Space used</span>
								<div class="infobox-content">
									<span class="bigger-110">~</span> <%=(int)(usedSpace)%>GB / <%=(int)(totalSpace)%>GB
								</div>
							</div>
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td colspan="2" align="center">
						<div class="widget-main">
							<div id="piechart-placeholder"></div>
						</div>
					</td>
				</tr>

			</table>
		</td>
		<td width="25px">
		</td>
		<td valign="top">
			<table class="tableLayout" border="1">
				<tr>
					<td>
						<div class="widget-body">
						<div class="widget-main padding-4">
						<div class="tab-content padding-8 overflow-visible">
						<div id="task-tab" class="tab-pane active">
								<h4 class="smaller lighter green">
									<i class="icon-list"></i>
									Torrent Lists
								</h4>
								<h6 class="smaller lighter green">
									Completed
								</h6>

								<ul id="tasksC" class="item-list">
									<%
										filePath=new java.io.File(torrentCPath);
										for(java.io.File sFile:filePath.listFiles()){
											String sFileName=sFile.getName();
											r=new java.util.Random();
											color = new java.awt.Color(r.nextInt(256),r.nextInt(256),r.nextInt(256),r.nextInt(256));
											hexColor = String.format("#%06X", (0xFFFFFF & color.getRGB()));
											%>
												<li class="clearfix" style="border-left-color: <%=hexColor%>">
													<label class="inline">
														<span class="lbl"><%=sFileName%></span>
													</label>
												</li>
											<%
										}
									%>
								</ul>
								<h6 class="smaller lighter red">
									Downloading
								</h6>
								<ul id="tasksD" class="item-list">
									<%
										filePath=new java.io.File(torrentDPath);
										for(java.io.File sFile:filePath.listFiles()){
											String sFileName=sFile.getName();
											r=new java.util.Random();
											color = new java.awt.Color(r.nextInt(256),r.nextInt(256),r.nextInt(256),r.nextInt(256));
											hexColor = String.format("#%06X", (0xFFFFFF & color.getRGB()));
											%>
												<li class="clearfix" style="border-left-color: <%=hexColor%>">
													<label class="inline">
														<span class="lbl"><%=sFileName%></span>
													</label>
												</li>
											<%
										}
									%>
								</ul>
						</div>
						</div>
						</div>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	</table>

	<!-- <div class="main-container container-fluid">-->
	<!--
	<div class="main-container">
		<a class="menu-toggler" id="menu-toggler" href="#"> <span
			class="menu-text"></span></a>
		<div class="main-content">
			<div class="page-content">
				<div class="row-fluid">
					<div class="span7 infobox-container">
						<div class="infobox infobox-orange2  ">
							<div class="infobox-chart">
								<span class="sparkline" data-values="196,128,202,177,154,94,100,170,224"></span>
							</div>
							<div class="infobox-data">
								<span class="infobox-data-number">6,251</span>
								<div class="infobox-content">pageviews</div>
							</div>
							<div class="badge badge-success"> 7.2% <i class="icon-arrow-up"></i>
							</div>
						</div>
						<div class="infobox infobox-blue infobox-small infobox-dark">
							<div class="infobox-chart">
								<span class="sparkline" data-values="3,4,2,3,4,4,2,2"></span>
							</div>
							<div class="infobox-data">
								<div class="infobox-content">Earnings</div>
								<div class="infobox-content">$32,000</div>
							</div>
						</div>
						<div class="infobox infobox-grey infobox-small infobox-dark">
							<div class="infobox-icon">
								<i class="icon-download-alt"></i>
							</div>
							<div class="infobox-data">

								<div class="infobox-content">Downloads</div>

								<div class="infobox-content">1,205</div>
							</div>
						</div>
					</div>
					<div class="span5">
						<div class="widget-box">
							<div class="widget-body">
								<div class="widget-main">
									<div id="piechart-placeholder"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span7">
						<div class="widget-box transparent">
							<div class="widget-header widget-header-flat">
								<h4 class="lighter">
									<i class="icon-signal"></i> Sale Stats
								</h4>
								<div class="widget-toolbar">

									<a href="#" data-action="collapse"> <i
										class="icon-chevron-up"></i>
									</a>
								</div>
							</div>
							<div class="widget-body">
								<div class="widget-main padding-4">
									<div id="sales-charts"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="hr hr32 hr-dotted"></div>
				<div class="row-fluid">
					<div class="span6">
					</div>
				</div>
			</div>
		</div>
	</div>
	-->
	<a href="#" id="btn-scroll-up"
		class="btn-scroll-up btn btn-small btn-inverse"> <i
		class="icon-double-angle-up icon-only bigger-110"></i>
	</a>
	<!--basic scripts-->
	<!--[if !IE]>-->
	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js" />
	">
	</script>
	<!--<![endif]-->
	<!--[if IE]>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" />"></script>
<![endif]-->
	<!--[if !IE]>-->
	<script type="text/javascript">
		window.jQuery
				|| document
						.write("<script src='<c:url value='/resources/ace/js/jquery-2.0.3.min.js' />'>"
								+ "<"+"/script>");
	</script>



	<!--<![endif]-->



	<!--[if IE]>

<script type="text/javascript">

 window.jQuery || document.write("<script src='<c:url value='/resources/ace/js/jquery-1.10.2.min.js' />'>"+"<"+"/script>");

</script>

<![endif]-->



	<script type="text/javascript">
		if ("ontouchend" in document)
			document
					.write("<script src='<c:url value='/resources/ace/js/jquery.mobile.custom.min.js' />'>"
							+ "<"+"/script>");
	</script>

	<script src="<c:url value="/resources/ace/js/bootstrap.min.js" />"></script>



	<!--page specific plugin scripts-->



	<!--[if lte IE 8]>

		  <script src="<c:url value="/resources/ace/js/excanvas.min.js" />"></script>

		<![endif]-->



	<script src="<c:url value="/resources/ace/js/jquery-ui-1.10.3.custom.min.js" />"></script>
	<script src="<c:url value="/resources/ace/js/jquery.ui.touch-punch.min.js" />"></script>
	<script src="<c:url value="/resources/ace/js/jquery.slimscroll.min.js" />"></script>
	<script src="<c:url value="/resources/ace/js/jquery.easy-pie-chart.min.js" />"></script>
	<script src="<c:url value="/resources/ace/js/jquery.sparkline.min.js" />"></script>
	<script src="<c:url value="/resources/ace/js/flot/jquery.flot.min.js" />"></script>
	<script src="<c:url value="/resources/ace/js/flot/jquery.flot.pie.min.js" />"></script>
	<script src="<c:url value="/resources/ace/js/flot/jquery.flot.resize.min.js" />"></script>

	<!--ace scripts-->
	<script src="<c:url value="/resources/ace/js/ace-elements.min.js" />"></script>
	<script src="<c:url value="/resources/ace/js/ace.min.js" />"></script>
	<!--inline scripts related to this page-->
	<script type="text/javascript">
		$(function() {
			$('.easy-pie-chart.percentage')
					.each(
							function() {
								var $box = $(this).closest('.infobox');
								var barColor = $(this).data('color')
										|| (!$box.hasClass('infobox-dark') ? $box
												.css('color')
												: 'rgba(255,255,255,0.95)');
								var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)'
										: '#E2E2E2';
								var size = parseInt($(this).data('size')) || 50;

								$(this)
										.easyPieChart(
												{

													barColor : barColor,

													trackColor : trackColor,

													scaleColor : false,

													lineCap : 'butt',

													lineWidth : parseInt(size / 10),

													animate : /msie\s*(8|7|6)/
															.test(navigator.userAgent
																	.toLowerCase()) ? false
															: 1000,

													size : size

												});

							})

			$('.sparkline').each(
					function() {

						var $box = $(this).closest('.infobox');

						var barColor = !$box.hasClass('infobox-dark') ? $box
								.css('color') : '#FFF';

						$(this).sparkline('html', {
							tagValuesAttribute : 'data-values',
							type : 'bar',
							barColor : barColor,
							chartRangeMin : $(this).data('min') || 0
						});

					});

			var placeholder = $('#piechart-placeholder').css({
				'width' : '100%',
				'min-height' : '150px',
				'border' : '1px dotted #D9D9D9'
			});


			var data = [
			<%
				double dividerToMb=1024*1024;
				java.io.File file=new java.io.File(piePath);
				for(java.io.File sFile:file.listFiles()){
					if(sFile.isDirectory()){
						r=new java.util.Random();
						color = new java.awt.Color(r.nextInt(256),r.nextInt(256),r.nextInt(256),r.nextInt(256));
						hexColor = String.format("#%06X", (0xFFFFFF & color.getRGB()));

						//String data = formatterNoComma.format(Math.random()*100);
					%>
						{
							label : "<%=sFile.getName()%>",
							data : <%=(org.apache.commons.io.FileUtils.sizeOfDirectory(sFile)/dividerToMb)%>,
							color : "<%=hexColor%>"
						},
					<%
					}
				}
			%>
			/*{
				label : "social networks",
				data : <%= 12*30%>,
				color : "#68BC31"
			},
			{
				label : "search engines",
				data : 24.5,
				color : "#2091CF"
			},
			{
				label : "ad campaings",
				data : 8.2,
				color : "#AF4E96"
			},
			{
				label : "direct traffic",
				data : 18.6,
				color : "#DA5430"
			},
			{
				label : "other",
				data : 10,
				color : "#FEE074"
			}*/

			]

			function drawPieChart(placeholder, data, position) {

				$.plot(placeholder, data, {

					series : {

						pie : {

							show : true,

							tilt : 0.8,

							highlight : {

								opacity : 0.25

							},

							stroke : {

								color : '#fff',

								width : 2

							},

							startAngle : 2

						}

					},

					legend : {

						show : true,

						position : position || "ne",

						labelBoxBorderColor : null,

						margin : [ -30, 15 ]

					}

					,

					grid : {

						hoverable : true,

						clickable : true

					}

				})

			}

			drawPieChart(placeholder, data);

			/**

			we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically

			so that's not needed actually.

			 */

			placeholder.data('chart', data);

			placeholder.data('draw', drawPieChart);

			var $tooltip = $(
					"<div class='tooltip top in hide'><div class='tooltip-inner'></div></div>")
					.appendTo('body');

			var previousPoint = null;

			placeholder.on('plothover', function(event, pos, item) {

				if (item) {

					if (previousPoint != item.seriesIndex) {

						previousPoint = item.seriesIndex;

						var tip = item.series['label'] + " : "
								+ item.series['percent'] + '%';

						$tooltip.show().children(0).text(tip);

					}

					$tooltip.css({
						top : pos.pageY + 10,
						left : pos.pageX + 10
					});

				} else {

					$tooltip.hide();

					previousPoint = null;

				}

			});

			var d1 = [];

			for ( var i = 0; i < Math.PI * 2; i += 0.5) {

				d1.push([ i, Math.sin(i) ]);

			}

			var d2 = [];

			for ( var i = 0; i < Math.PI * 2; i += 0.5) {

				d2.push([ i, Math.cos(i) ]);

			}

			var d3 = [];

			for ( var i = 0; i < Math.PI * 2; i += 0.2) {

				d3.push([ i, Math.tan(i) ]);

			}

			var sales_charts = $('#sales-charts').css({
				'width' : '100%',
				'height' : '220px'
			});

			$.plot("#sales-charts", [

			{
				label : "Domains",
				data : d1
			},

			{
				label : "Hosting",
				data : d2
			},

			{
				label : "Services",
				data : d3
			}

			], {

				hoverable : true,

				shadowSize : 0,

				series : {

					lines : {
						show : true
					},

					points : {
						show : true
					}

				},

				xaxis : {

					tickLength : 0

				},

				yaxis : {

					ticks : 10,

					min : -2,

					max : 2,

					tickDecimals : 3

				},

				grid : {

					backgroundColor : {
						colors : [ "#fff", "#fff" ]
					},

					borderWidth : 1,

					borderColor : '#555'

				}

			});

			$('#recent-box [data-rel="tooltip"]').tooltip({
				placement : tooltip_placement
			});

			function tooltip_placement(context, source) {

				var $source = $(source);

				var $parent = $source.closest('.tab-content')

				var off1 = $parent.offset();

				var w1 = $parent.width();

				var off2 = $source.offset();

				var w2 = $source.width();

				if (parseInt(off2.left) < parseInt(off1.left)
						+ parseInt(w1 / 2))
					return 'right';

				return 'left';

			}

			$('.dialogs,.comments').slimScroll({

				height : '300px'

			});

			//Android's default browser somehow is confused when tapping on label which will lead to dragging the task

			//so disable dragging when clicking on label

			var agent = navigator.userAgent.toLowerCase();

			if ("ontouchstart" in document && /applewebkit/.test(agent)
					&& /android/.test(agent))

				$('#tasks').on('touchstart', function(e) {

					var li = $(e.target).closest('#tasks li');

					if (li.length == 0)
						return;

					var label = li.find('label.inline').get(0);

					if (label == e.target || $.contains(label, e.target))
						e.stopImmediatePropagation();

				});

			$('#tasks').sortable({

				opacity : 0.8,

				revert : true,

				forceHelperSize : true,

				placeholder : 'draggable-placeholder',

				forcePlaceholderSize : true,

				tolerance : 'pointer',

				stop : function(event, ui) {//just for Chrome!!!! so that dropdowns on items don't appear below other items after being moved

					$(ui.item).css('z-index', 'auto');

				}

			}

			);

			$('#tasks').disableSelection();

			$('#tasks input:checkbox').removeAttr('checked').on('click',
					function() {

						if (this.checked)
							$(this).closest('li').addClass('selected');

						else
							$(this).closest('li').removeClass('selected');

					});

		})
	</script>
</body>
</html>
