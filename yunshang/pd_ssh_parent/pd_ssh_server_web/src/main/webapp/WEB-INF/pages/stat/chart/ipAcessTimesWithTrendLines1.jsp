<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>amCharts examples</title>
		 <link rel="stylesheet" href="${pageContext.request.contextPath }/components/newAmcharts/style.css" type="text/css">
        <script src="${pageContext.request.contextPath }/components/newAmcharts/amcharts/amcharts.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath }/components/newAmcharts/amcharts/serial.js" type="text/javascript"></script>
        <script>
            var chart;

          
             var chartData = ${ipAcessList};
            
            

            AmCharts.ready(function () {
                // SERIAL CHART
                chart = new AmCharts.AmSerialChart();

                chart.dataProvider = chartData;
                chart.categoryField = "IP";


                // AXES
                // category
                var categoryAxis = chart.categoryAxis;
                categoryAxis.parseDates = true; // as our data is date-based, we set parseDates to true
             //   categoryAxis.minPeriod = "HOUR"; // our data is daily, so we set minPeriod to DD
                categoryAxis.gridAlpha = 0.1;
                categoryAxis.minorGridAlpha = 0.1;
                categoryAxis.axisAlpha = 0;
                categoryAxis.minorGridEnabled = true;
                categoryAxis.inside = true;

                // value
                var valueAxis = new AmCharts.ValueAxis();
                valueAxis.tickLength = 0;
                valueAxis.axisAlpha = 0;
                valueAxis.showFirstLabel = false;
                valueAxis.showLastLabel = false;
                chart.addValueAxis(valueAxis);

                // GRAPH
                var graph = new AmCharts.AmGraph();
                graph.dashLength = 3;
                graph.lineColor = "#00CC00";
                graph.valueField = "AT";
                graph.dashLength = 3;
                graph.bullet = "round";
                graph.balloonText = "[[category]]<br><b><span style='font-size:14px;'>value:[[value]]</span></b>";
                chart.addGraph(graph);

                // CURSOR
                var chartCursor = new AmCharts.ChartCursor();
                chartCursor.valueLineEnabled = true;
                chartCursor.valueLineBalloonEnabled = true;
                chart.addChartCursor(chartCursor);

                // SCROLLBAR
                var chartScrollbar = new AmCharts.ChartScrollbar();
                chart.addChartScrollbar(chartScrollbar);

                // HORIZONTAL GREEN RANGE
                var guide = new AmCharts.Guide();
                guide.value = 10;
                guide.toValue = 20;
                guide.fillColor = "#00CC00";
                guide.inside = true;
                guide.fillAlpha = 0.2;
                guide.lineAlpha = 0;
                valueAxis.addGuide(guide);

                // TREND LINES
                // first trend line
                var trendLine = new AmCharts.TrendLine();
                // note,when creating date objects 0 month is January, as months are zero based in JavaScript.
                //trendLine.initialDate = new Date(2012, 0, 2, 12); // 12 is hour - to start trend line in the middle of the day
                //trendLine.finalDate = new Date(2012, 0, 11, 12);
                trendLine.initialValue = 10;
                trendLine.finalValue = 19;
                trendLine.lineColor = "#CC0000";
                chart.addTrendLine(trendLine);

                // second trend line
                trendLine = new AmCharts.TrendLine();
                trendLine.initialDate = new Date(2012, 0, 17, 12);
                trendLine.finalDate = new Date(2012, 0, 22, 12);
                trendLine.initialValue = 16;
                trendLine.finalValue = 10;
                trendLine.lineColor = "#CC0000";
                chart.addTrendLine(trendLine);

                // WRITE
                chart.write("chartdiv");
            }); 
        </script>
    </head>

    <body>
        <div id="chartdiv" style="width: 100%; height: 400px;"></div>
    </body>

</html>