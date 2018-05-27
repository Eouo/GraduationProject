<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
			<div class="span3">
				
				<div class="account-container">
				
					<div class="account-avatar">
						<img src="img?imgName=${user.getImgUrl()}" onclick="showChangePicture();" alt="" class="thumbnail" />

					</div>  
				
					<div class="account-details">
					
						<span class="account-name">admin</span>
						
						<span class="account-role">${user.getUserName()}</span>
					
					</div>  
				</div>  
				
				<hr />
				
				<ul id="main-nav" class="nav nav-tabs nav-stacked">
					
					<li id="product-active">
						<a href="admin" targe>
							<i class="icon-home"></i>
							 在售产品			
						</a>
					</li>
					
					<li id="order-active">
						<a href="productRecord">
							<i class="icon-pushpin"></i>
							订单管理	
						</a>
					</li>
					
					<li id="user-active">
						<a href="userMessage">
							<i class="icon-th-list"></i>
							 用户管理		
						</a>
					</li>
					
					<li id="repertory-active">
						<a href="repertory">
							<i class="icon-th-large"></i>
							 	库存管理
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
			
		