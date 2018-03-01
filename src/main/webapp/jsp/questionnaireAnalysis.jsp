<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored = "false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.5.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-tool-functions.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.js"></script>
<script type="text/javascript">


   $(document).ready(function(){	
	 
   })
    
   
   
</script>
</head>
<body style="margin:20px;">  
  <div id= "echartsId" style ="width: 100%;height:400px; margin:10px  " >
     <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
   <div id="numberAnalysisId" style="width: 500px;height:400px;float:left"></div>         
   <script type="text/javascript">
        var questionnaireName = '${questionnaireName}' /* 获取当前问卷的标题 */
        var questionnaireCode = '${questionnaireCode}'; /* 获取当前问卷的code */
		var domNumberAnalysis = document.getElementById("numberAnalysisId");
		var myChartNumberAnalysis = echarts.init(domNumberAnalysis);				
		$.ajax({
            url: "/stu-system-web/sysquestionnaireAnalysisAction/selectCountOfQuestionnaireAnswered.do?questionnaireCode=" + questionnaireCode,
            type:"POST",
            dataType:"json",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',//防止乱码
            success:function(data){
            	var optionNumberAnalysis = {
            			    title : {   /* title这个标题是显示这个表格的题目的 */
            			        text: questionnaireName +'学生回答人数统计图',   /* 主标题  */
            			        subtext: '这个地方写的是副标题',       /* 副标题  */
            			        x:'center'               /* 标题的位置 */
            			    },
            			     tooltip : {   /* tip是提示的意思  tooltip 是提示工具的意思，用来提示具体数据*/
            			        trigger: 'item',  /* trigger是触发器的意思，它的值是Echarts中已经定义好了，程序员值选择就好 */
            			        formatter: "{a} <br/>{b} : {c} ({d}%)"  /* 这些字母和格式都是Echarts中已经定义好了 */
            			    }, 
            			    legend: {
            			        orient: 'vertical',   
            			        left: 'left',
            			        data: ['已回答','未回答']
            			    },
            			    series : [    /* series是系列的意思 说明在这个dom中会有几个图标 */
            			        {
            			            name: '学生',
            			            type: 'pie',      /* 说明这个图表的类型是饼型图 */
            			            radius : '50%',  /* radius是半径的意思，规定了这个饼型图的半径大小  */
            			            center: ['50%', '50%'],  /* 规定了这个饼型图中心点的位置，相对于 它所在dom左上角的点  */
            			            data:   data,
            			            itemStyle: {
            			            	 emphasis: {
            					                shadowBlur: 10,
            					                shadowOffsetX: 0,
            					                shadowColor: 'rgba(0, 0, 0, 0.5)'
            					            },
            			            }
            			        }		         
            			    ]
            			}			              	
            	myChartNumberAnalysis.setOption(optionNumberAnalysis);
            }
        });				
       </script> 
         
        <div id="answerAnalysisId" style="width: 500px;height:400px;float:left"></div>
		 <script>
		 
		    
			var domAnswerAnalysis = document.getElementById("answerAnalysisId");
			var myChart = echarts.init(domAnswerAnalysis);
			
			$.ajax({
	            url: "/stu-system-web/sysquestionnaireAnalysisAction/selectQuestionAnswerForAnalysis.do?questionnaireCode=" + questionnaireCode,
	            type:"POST",
	            dataType:"json",
	            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	            success:function(data){
	            	
	            	var app = {};
	    			option = null;
	    			var posList = [
	    				'left', 'right', 'top', 'bottom',
	    				'inside',
	    				'insideTop', 'insideLeft', 'insideRight', 'insideBottom',
	    				'insideTopLeft', 'insideTopRight', 'insideBottomLeft', 'insideBottomRight'
	    			];

	    			app.configParameters = {
	    				rotate: {
	    					min: -90,
	    					max: 90
	    				},
	    				align: {
	    					options: {
	    						left: 'left',
	    						center: 'center',
	    						right: 'right'
	    					}
	    				},
	    				verticalAlign: {
	    					options: {
	    						top: 'top',
	    						middle: 'middle',
	    						bottom: 'bottom'
	    					}
	    				},
	    				position: {
	    					options: echarts.util.reduce(posList, function(map, pos) {
	    						map[pos] = pos;
	    						return map;
	    					}, {})
	    				},
	    				distance: {
	    					min: 0,
	    					max: 100
	    				}
	    			};

	    			app.config = {
	    				rotate: 90,
	    				align: 'left',
	    				verticalAlign: 'middle',
	    				position: 'insideBottom',
	    				distance: 15,
	    				onChange: function() {
	    					var labelOption = {
	    						normal: {
	    							rotate: app.config.rotate,
	    							align: app.config.align,
	    							verticalAlign: app.config.verticalAlign,
	    							position: app.config.position,
	    							distance: app.config.distance
	    						}
	    					};
	    					myChart.setOption({
	    						series: [{
	    							label: labelOption
	    						}, {
	    							label: labelOption
	    						}, {
	    							label: labelOption
	    						}, {
	    							label: labelOption
	    						}]
	    					});
	    				}
	    			};

	    			var labelOption = {
	    				normal: {
	    					show: true,
	    					position: app.config.position,
	    					distance: app.config.distance,
	    					align: app.config.align,
	    					verticalAlign: app.config.verticalAlign,
	    					rotate: app.config.rotate,
	    					formatter: '{c}  {name|{a}}',
	    					fontSize: 16,
	    					rich: {
	    						name: {
	    							textBorderColor: '#fff'
	    						}
	    					}
	    				}
	    			};

	    			option = {
	        				color: ['#003366', '#006699', '#4cabce', '#e5323e'],
	        				tooltip: {
	        					trigger: 'axis',
	        					axisPointer: {
	        						type: 'shadow'
	        					}
	        				},
	        				legend: {
	        					data: ['A选项', 'B选项', 'C选项']
	        				},
	        				toolbox: {
	        					show: true,
	        					orient: 'vertical',
	        					left: 'right',
	        					top: 'center',
	        					feature: {
	        						mark: {
	        							show: true
	        						},
	        						dataView: {
	        							show: true,
	        							readOnly: false
	        						},
	        						magicType: {
	        							show: true,
	        							type: ['line', 'bar', 'stack', 'tiled']
	        						},
	        						restore: {
	        							show: true
	        						},
	        						saveAsImage: {
	        							show: true
	        						}
	        					}
	        				},
	        				calculable: true,
	        				xAxis: [{
	        					type: 'category',
	        					axisTick: {
	        						show: false
	        					},
	        					data:  data.questionNumber
	        				}],
	        				yAxis: [{
	        					type: 'value'
	        				}],
	        				series: [{
	        					name: 'A选项',
	        					type: 'bar',
	        					barGap: 0,
	        					label: labelOption,
	        					data: data.AOption
	        				}, {
	        					name: 'B选项',
	        					type: 'bar',
	        					label: labelOption,
	        					data:  data.BOption
	        				}, {
	        					name: 'C选项',
	        					type: 'bar',
	        					label: labelOption,
	        					data: data.COption
	        				}]
	        			};   
	            
			if(option && typeof option === "object") {
				myChart.setOption(option, true);
			} 	
	    			
	            	
	              
	               }
	            })
	    	
	         
		</script>
       
       
       
       
          
  </div>
   
      
       
       
</body>
</html>