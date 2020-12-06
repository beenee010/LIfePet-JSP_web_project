<link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/carousel/">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">

<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
	<a class="navbar-brand" href="/welcome.jsp">LIfePet</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarsExampleDefault"
		aria-controls="navbarsExampleDefault" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarsExampleDefault">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item"><a class="nav-link" href="/board/board.jsp">Board</a></li>
			<li class="nav-item"><a class="nav-link" href="/shop/shop.jsp"
				tabindex="-1" aria-disabled="true">Shop</a></li>
			<li class="nav-item"><a class="nav-link" href="/fleaMarket/fleaMarket.jsp">Flea Market</a></li>
		</ul>
		<form class="form-inline my-2 my-lg-0">
			<%
				String oid = (String) session.getAttribute("userOid");
			String id = (String) session.getAttribute("userID");
			if (oid == null) {
				out.println(
				"<button class=\"btn btn-outline-primary my-2 my-sm-0\" type=\"button\" style=\"margin-left: 10px\" onclick=\"location.href=\'/main/login.jsp\'\">Login</button>");
			} else {
				out.println(
				"<button class=\"btn btn-outline-info my-2 my-sm-0\" type=\"button\" style=\"margin-left: 10px\" onclick=\"location.href=\'/main/myPage.jsp?id="
						+ oid + "\'\">" + id + "</button>");
				out.println(
				"<button class=\"btn btn-outline-primary my-2 my-sm-0\" type=\"button\" style=\"margin-left: 10px\" onclick=\"location.href=\'/main/logout.jsp\'\">Logout</button>");
			}
			%>
		</form>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script>window.jQuery || document.write('<script src="/assets/js/vendor/jquery.slim.min.js"><\/script>')</script>
	<script src="/assets/dist/js/bootstrap.bundle.min.js"></script>
</nav>