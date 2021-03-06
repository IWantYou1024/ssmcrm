<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../base.jsp"%>
<%@ include file="../../baselist.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
</head>

<body>
<form name="icform" method="post">
<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
  <div id="navMenubar">
<ul>
<li id="back"><a href="#" onclick="history.go(-1);">返回</a></li>
</ul>
  </div>
</div>
</div>
</div>
   
  <div class="textbox-title">
	<img src="${ctx }/skin/default/images/icon/currency_yen.png"/>
   浏览反馈
  </div> 
  

 
    <div>
		<table class="commonTable" cellspacing="1">
	         <tr>
	            <td class="columnTitle">提出人：</td>
	            <td class="tableContent">${inputBy }</td>
	            <td class="columnTitle">提出时间：</td>
	            <td class="tableContentAuto">
	            	${inputTime } 
	            </td>
	        </tr>		
	        <tr>
	            <td class="columnTitle">标题：</td>
	            <td class="tableContent">${title }</td>
	         </tr>
	         <tr>
	            <td class="columnTitle">内容：</td>
	            <td class="tableContent">${content }</td>
	          </tr>
	        <tr>
	            <td class="columnTitle">分类：</td>
	            <td class="tableContent">
	            <c:if test="${classType =='1'}"  >管理</c:if>
	            <c:if test="${classType =='2'}"  >安全</c:if>
	            <c:if test="${classType =='3'}"  >建议</c:if>
	            <c:if test="${classType =='4'}"  >其他</c:if>
	            </td>
	            <td class="columnTitle">电话：</td>
	            <td class="tableContent">${tel }</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">解决人：</td>
	            <td class="tableContent">${answerBy }</td>
	            <td class="columnTitle">解决时间：</td>
	            <td class="tableContent">${answerTime }</td>
	        </tr>
	        <tr>
	            <td class="columnTitle">解决办法：</td>
	            <td class="tableContent">${solveMethod }</td>
	         </tr>
	         <tr>
	            <td class="columnTitle">解决方式：</td>
	            <td class="tableContent">
	            <c:if test="${resolution == '1' }"  >已修改</c:if>
	            <c:if test="${resolution == '2' }"  >无需修改</c:if>
	            <c:if test="${resolution == '3' }"  >重复问题</c:if>
	            <c:if test="${resolution == '4' }"  >描述不完全</c:if>
	            <c:if test="${resolution == '5' }"  >无法再现</c:if>
	            <c:if test="${resolution == '6' }"  >其他</c:if>
	            </td>
	        </tr>
	         <tr>
	            <td class="columnTitle">解决难度：</td>
	            <td class="tableContent">
	             <c:if test="${difficulty == '1'}"  >极难</c:if>
	             <c:if test="${difficulty == '2'}"  >比较难</c:if>
	             <c:if test="${difficulty == '3'}"  >有难度</c:if>
	             <c:if test="${difficulty == '4'}"  >一般</c:if>
	            </td>
	        </tr>
	         <tr>
	            <td class="columnTitle">创建人：</td>
	            <td class="tableContent">${createBy }</td>
	            <td class="columnTitle">创建部门：</td>
	            <td class="tableContent">${createDept }</td>
	            <td class="columnTitle">创建日期：</td>
	            <td class="tableContent">${createTime }</td>
	        </tr>
	        
	        		
	        		
	        	
		</table>
		
	</div>
	


 </form>
 
 



</body>
</html>