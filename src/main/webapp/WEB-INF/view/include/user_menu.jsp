<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
			<div class="span3">
				
				<div class="account-container">
				
					<div class="account-avatar">
						<img src="/img?imgName=${user.getImgUrl()}" onclick="showChangePicture();" alt="" class="thumbnail" />
					</div>  
				
					<div class="account-details">
					
						<span class="account-name">user</span>
						
						<span class="account-role">${user.getUserName()}</span>
					
					</div>  
				</div>  
				
				<hr />
				
				<ul id="main-nav" class="nav nav-tabs nav-stacked">
					
					<li id="product-active">
						<a href="user" >
							<i class="icon-home"></i>
							购买产品			
						</a>
					</li>
					<li id="shopcard-active">
						<a href="shopCardList" >
							<i class="icon-pushpin"></i>
							购物车	
						</a>
					</li>
					
					<li id="order-active">
						<a href="productRecord">
							<i class="icon-pushpin"></i>
							订单管理	
						</a>
					</li>
					 <li id="address-active">
						<a href="address">
							<i class="icon-pushpin"></i>
							地址管理	
						</a>
					</li>
					
					<li id="oneUserMessage-active">
						<a href="oneUserMessage">
							<i class="icon-signal"></i>
							个人信息管理
						</a>
					</li>
					<li id="loginOut-active">
						<a href="login.jsp">
							<i class="icon-lock"></i>
							退出	
						</a>
					</li>
					
				</ul>	
				
		
			</div> <!-- /span3 -->	