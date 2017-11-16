<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../baselist.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	
	<!-- 判断是否唯一选择start ,修改选择的id和跳转页面即可-->
	<script>
	     function isOnlyChecked(){
	    	 var checkBoxArray = document.getElementsByName('packingListId');
				var count=0;
				for(var index=0; index<checkBoxArray.length; index++) {
					if (checkBoxArray[index].checked) {
						count++;
					}	
				}
			//jquery
			//var count = $("[input name='id']:checked").size();
			if(count==1)
				return true;
			else
				return false;
	     }
	     function toView(){
	    	 if(isOnlyChecked()){
	    		 formSubmit('packingListAction_toview','_self');
	    	 }else{
	    		 alert("请先选择一项并且只能选择一项，再进行操作！");
	    	 }
	     }
	     //实现修改,只能修改的草稿
		    function isUpdate(){
		    	var checkBoxArray = document.getElementsByName('packingListId');
		    	for(var index=0; index<checkBoxArray.length; index++) {
		    		if(checkBoxArray[index].checked){
		    			if (checkBoxArray[index].getAttribute("sta")!=0) {
							alert(checkBoxArray[index].getAttribute("sta"));
							return false;
						}	
		    		}
				}
		    	return true;
	     }
	     //实现更新
	     function toUpdate(){
	    	 if(isOnlyChecked()&&isUpdate()){
	    		 formSubmit('packingListAction_toupdate','_self');
	    	 }else{
	    		 alert("只能选择已提交的,并且只能选择一项，再进行操作！");
	    	 }
	     }
	</script>
	<!-- 判断是否唯一选择end -->	
	
	
	<!-- ======================判断各状态的装箱单start ===========================-->
	<script>
		 //实现取消,只能提交的取消
	    function isCancel(){
	    	var checkBoxArray = document.getElementsByName('packingListId');
	    	for(var index=0; index<checkBoxArray.length; index++) {
	    		if(checkBoxArray[index].checked){
	    			if (checkBoxArray[index].getAttribute("sta")!=1) {
						alert(checkBoxArray[index].getAttribute("sta"));
						return false;
					}	
	    		}
			}
	    	return true;
		 }	
	    function toCancel(){
	     if(isCancel()){
	   		 formSubmit('packingListAction_cancel','_self');
	   	 }else{
	   		 alert("只能选择已提交的,请选择已提交的装箱单，再进行操作！");
	   	 }
	    }
	</script>
		<!-- 判断各状态的装箱单end -->
	<script>
		 //实现删除,只能删除草稿
	    function isDelete(){
	    	var checkBoxArray = document.getElementsByName('packingListId');
	    	for(var index=0; index<checkBoxArray.length; index++) {
	    		if(checkBoxArray[index].checked){
	    			if (checkBoxArray[index].getAttribute("sta")!=0) {
						alert(checkBoxArray[index].getAttribute("sta"));
						return false;
					}	
	    		}
			}
	    	return true;
		 }	
	    function toDelete(){
	     if(isDelete()){
	   		 formSubmit('packingListAction_delete','_self');
	   	 }else{
	   		 alert("只能选择草稿的,请选择草稿状态下的装箱单，再进行操作！");
	   	 }
	    }
	</script>
		<!-- 判断各状态的装箱单end -->
	<script>
		 //实现提交,只能提交草稿
	    function isSubmit(){
	    	var checkBoxArray = document.getElementsByName('packingListId');
	    	
	    	for(var index=0; index<checkBoxArray.length; index++) {
	    		if(checkBoxArray[index].checked){
	    			if (checkBoxArray[index].getAttribute("sta")!=0) {
						alert(checkBoxArray[index].getAttribute("sta"));
						return false;
					}	
	    		}
			}
	    	return true;
		 }	
	    function toSubmit(){
	     if(isSubmit()){
	   		 formSubmit('packingListAction_submit','_self');
	   	 }else{
	   		 alert("只能选择草稿的,请选择草稿状态下的装箱单，再进行操作！");
	   	 }
	    }
	</script>
	
</head>

<body>
<form name="icform" method="post">

<div id="menubar">
<div id="middleMenubar">
<div id="innerMenubar">
  <div id="navMenubar">
<ul>
<li id="view"><a href="#" onclick="javascript:toView();this.blur();">查看</a></li>
<li id="new"><a href="#" onclick="formSubmit('packingListAction_tocreate','_self');this.blur();">新增</a></li>
<li id="update"><a href="#" onclick="javascript:toUpdate();this.blur();">修改</a></li>
<li id="update"><a href="#" onclick="javascript:toSubmit();this.blur();">提交</a></li>
<li id="update"><a href="#" onclick="javascript:toCancel();this.blur();">取消</a></li>
<li id="delete"><a href="#" onclick="javascript:toDelete();this.blur();">删除</a></li>
<li id="update"><a href="#" onclick="formSubmit('packingListAction_print','_self');this.blur();">打印</a></li>
</ul>
  </div>
</div>
</div>
</div>
   
  <div class="textbox-title">
	<img src="${ctx }/skin/default/images/icon/currency_yen.png"/>
    装箱单列表
  </div> 
  
<div>


<div class="eXtremeTable" >
<table id="ec_table" class="tableRegion" width="98%" >
	<thead>
	<tr>
		<td class="tableHeader"><input type="checkbox" name="selid" onclick="checkAll('id',this)"></td>
		<td class="tableHeader">序号</td>
		<td class="tableHeader">卖方</td>
		<td class="tableHeader">买方</td>
		<td class="tableHeader">发票号</td>
		<td class="tableHeader">发票日期</td>
		<td class="tableHeader">状态</td>
	</tr>
	</thead>
	<tbody class="tableBody" >
${links}
	
 <c:forEach items="${results}" var="o" varStatus="status">
	<tr class="odd" onmouseover="this.className='highlight'" onmouseout="this.className='odd'" >
		<td>
		<%-- <c:if test="${o.state==0||o.state==1}"> --%>
		<input type="checkbox" name="packingListId" value="${o.packingListId}" sta="${o.state}" />
		<%-- </c:if> --%>
		</td>
		<td>${status.count}</td>
	
		<td>${o.seller}</td>
		<td>${o.buyer}</td>
		<td>${o.invoiceNo}</td>
		
		<td>
		 <fmt:formatDate value="${o.invoiceDate}" pattern="yyyy-MM-dd"/> 
		</td>
		
		<td>
		 <c:if test="${o.state==0}">草稿</c:if>
		   <c:if test="${o.state==1}">已提交</c:if>
		   <c:if test="${o.state==2}">已委托</c:if>
		   <c:if test="${o.state==3}">已发票</c:if>
		   <c:if test="${o.state==4}">已财务</c:if>
		</td>
		
	</tr>
	</c:forEach>

	</tbody>
</table>
</div>
 
</div>
 
 
</form>
</body>
</html>

