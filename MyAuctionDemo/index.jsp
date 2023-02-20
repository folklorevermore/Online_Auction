<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>拍卖品列表</title>

 <link rel="stylesheet" href="../css/index.css">
<link href="${pageContext.request.contextPath}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/WebCalendar.js"></script>
<style type="text/css">
             *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            
        }
        body{
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url("../images/back.jpeg");
        }
        .main{
            position: relative;
            width: 400px;
            height: 250px;
            overflow: hidden;
            border-radius: 5px;
        }
        .item{
            position: absolute;
            top: 0;
            width: 100%;
            height: 100%;
            transition: all 0.5s;
            background-size: cover;
        }
        .item1{
           background-image: url(../images/cat.jpg);
        }
        .item2{
            background-image: url(../images/bottom.jpeg);
            left: 100%;
        }
        .item3{
            background-image: url(../images/ak74.jpeg);
            left: 200%;
        }
        input{
            position: relative;
            z-index: 100;
            /* display: none; */
        }
        .select{
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 10px;
            z-index: 1;
            display: flex;
            justify-content: space-between;
            align-items: center;         
        }
        .select>label{
            width: 10px;
            height: 10px;
            background-color: rgb(255, 255, 255);
            border-radius: 50%;
            cursor: pointer;
            border: 1.5px solid white;
        }
        .main input:nth-of-type(1):checked ~ .select label:nth-of-type(1){
            background-color: rgb(26, 26, 26);
        }
        .main input:nth-of-type(2):checked ~ .select label:nth-of-type(2){
            background-color: rgb(26, 26, 26);
        }
        .main input:nth-of-type(3):checked ~ .select label:nth-of-type(3){
            background-color: rgb(26, 26, 26);
        }
        .main input:nth-of-type(1):checked ~ .item{
            transform: translateX(0);
        }
        .main input:nth-of-type(2):checked ~ .item{
            transform: translateX(-100%);
        }
        .main input:nth-of-type(3):checked ~ .item{
            transform: translateX(-200%);
        }
        </style>
</head>

<body>
<div class="main">
        <!-- 三个单选按钮，先默认选择第一个 -->
        <input type="radio" name="choose" id="choose1" checked>
        <input type="radio" name="choose" id="choose2">
        <input type="radio" name="choose" id="choose3">      
        <!-- 放三张图片，用背景图片表示 -->
        <div class="item item1"></div>
        <div class="item item2"></div>
        <div class="item item3"></div>
    </div>

   
<div class="wrap">
 <h1 class='jss'>在线拍卖系统</h1>
<!-- main begin-->

  <div class="sale">
    <div class="logout right"><a href="${pageContext.request.contextPath}/user/doLogout" title="注销">注销</a></div>
  </div>
  <div class="forms">
  	<form id="form_query" action="${pageContext.request.contextPath}/auction/queryAuctions" method="post">
    	<input id="page" name="pageNum" type="hidden" value="1"/> 	
    	<label for="name">名称</label>
        <input name="auctionname" value="${condition.auctionname}" type="text" class="nwinput" id="name"/>
        <label for="names">描述</label>
        <input name="auctiondesc" value="${condition.auctiondesc}" type="text" id="names" class="nwinput"/>
        
        <label for="time">开始时间</label>      
        <input name="auctionstarttime" 
            value="<fmt:formatDate value="${condition.auctionstarttime}" pattern="yyyy-MM-dd HH:mm:ss" />"
        	type="text" id="time" class="nwinput" readonly="readonly" onclick="selectDate(this,'yyyy-MM-dd hh:mm:ss')"/>
        
        <label for="end-time">结束时间</label>
        <input name="auctionendtime"
        	value="<fmt:formatDate value="${condition.auctionendtime}" pattern="yyyy-MM-dd HH:mm:ss" />"
        	type="text" id="end-time" class="nwinput" readonly="readonly" onclick="selectDate(this,'yyyy-MM-dd hh:mm:ss')"/>
        
        <label for="price">起拍价</label>
    	<input name="auctionstartprice" value="${condition.auctionstartprice}" type="text" id="price" class="nwinput" />
    	<input type="submit"  value="查询" class="spbg buttombg f14  sale-buttom"/>
    </form>
    
    <c:if test="${sessionScope.user.userisadmin==0}">
    	<input type="button"  value="竞拍结果" class="spbg buttombg f14  sale-buttom buttomb" onclick="location='${pageContext.request.contextPath}/auction/toAuctionResult'"/>
    </c:if> 
    <c:if test="${sessionScope.user.userisadmin==1}">
    	<input type="button"  value="发布" onclick="javascript:location='${pageContext.request.contextPath}/addAuction.jsp'" class="spbg buttombg f14  sale-buttom buttomb"/>
    </c:if>
  </div>
  <div class="items">
      <ul class="rows even strong">
        <li>名称</li>
        <li class="list-wd">描述</li>
        <li>开始时间</li>
        <li>结束时间</li>
        <li>起拍价</li>
        <li class="borderno">操作</li>
      </ul>
      
      <c:forEach var="auction" items="${auctionList}" varStatus="state">
      		
	      <ul
	          <c:if test="${state.index%2 != 0}">class="rows even"</c:if>
      	      <c:if test="${state.index%2 == 0}">class="rows"</c:if>
	      >
	        <li><a href="国书" title="">${auction.auctionname} </a></li>
	        <li class="list-wd">${auction.auctiondesc}</li>
	        <li>
	        	
	        	<fmt:formatDate value="${auction.auctionstarttime}"  pattern="yyyy-MM-dd hh:mm:ss"/>
	        </li>
	        <li>
	        	
	        	<fmt:formatDate value="${auction.auctionendtime}"  pattern="yyyy-MM-dd hh:mm:ss"/>
	        </li>
	        <li>${auction.auctionstartprice}</li>
	        <li class="borderno red">
	            <c:if test="${sessionScope.user.userisadmin==0}">
	           	    <a href="${pageContext.request.contextPath}/auction/toDetail/${auction.auctionid}" title="竞拍" onclick="dele();">竞拍</a>
	            </c:if>
	            <c:if test="${sessionScope.user.userisadmin==1}">
	            	<a href="${pageContext.request.contextPath}/auction/toUpdate/${auction.auctionid}" title="竞拍" onclick="dele();">修改</a>|
	                <a href="javascript:deleteAuction(${auction.auctionid})" onclick="abc();">删除</a>
	            </c:if>
	        </li>
	      </ul>
      </c:forEach>

      <div class="page">
                    【当前第${pageInfo.pageNum}页，总共${pageInfo.pages}页，总共${pageInfo.total}条记录】
        <a href="javascript:jumpPage(1)" title="">首页</a>
        <a href="javascript:jumpPage(${pageInfo.prePage})" title="">上一页</a>
        <a href="javascript:jumpPage(${pageInfo.nextPage})" title="">下一页</a>
        <a href="javascript:jumpPage(${pageInfo.pages})" title="">尾页</a> 
      </div>
  </div>
  
  <script>
  	function jumpPage(pagenum) {
  		//先修改要访问的页码
  		document.getElementById("page").value=pagenum;
  		//手动提交查询form表单
  		document.getElementById("form_query").submit();
  	}
  
  	//${pageContext.request.contextPath}/auction/removeAuction/${auction.auctionid}
  	function deleteAuction(auctionId) {
  		if(confirm("确定要删除该商品数据吗？")){
  			location = "${pageContext.request.contextPath}/auction/removeAuction/"+auctionId;
  		}
  	}
	 //1、找到container下的所有img标签,li标签,左右按钮
    var aImgs = document.querySelectorAll('.container img');
    var aLis = document.querySelectorAll('.container li');
    var btnLeft = document.querySelector('.container .left');
    var btnRight = document.querySelector('.container .right');

    // //检验是否找到
    // console.log(aImgs);
    // console.log(aLis);
    // console.log(btnLeft);
    // console.log(btnRight);

    //点击事件
    //点击按钮图片切换
    var index = 0;        //当前图片下标
    var lastIndex = 0;
    btnRight.onclick = function(){
        //记录上一张图片的下标
        lastIndex = index;
        //清除上一张图片的样式
        aImgs[lastIndex].className = '';
        aLis[lastIndex].className = '';

        index++;
        index %= aImgs.length;    //实现周期性变化
        //设置当前图片的样式
        aImgs[index].className = 'on';
        aLis[index].className = 'active';
    }
    //左边按钮类似
    btnLeft.onclick = function(){
        //记录上一张图片的下标
        lastIndex = index;
        //清除上一张图片的样式
        aImgs[lastIndex].className = '';
        aLis[lastIndex].className = '';

        index--;
        if (index < 0) {
            index = aImgs.length - 1;
        }
        //设置当前图片的样式
        aImgs[index].className = 'on';
        aLis[index].className = 'active';
    }
  </script>
 
</div>
</body>
</html>
    