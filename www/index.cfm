<cfif structKeyExists(session.user,"userID")>
	<cflocation url="myProjects.cfm" addtoken="false" />
</cfif>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">

        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/main.css">
        <script src="js/vendor/modernizr-2.6.2.min.js"></script>
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->
		
		

        <!-- Add your site or application content here -->
        <div style="height:50px"></div>
	<div style="background-color:lightpink; border:solid lime;border-radius:10px; width:250px; text-align:center; margin-top:50px; margin:auto">
	<p><img src="img/flower logo.jpg" width="368" height="250"></p>
		<form method="post" action="login.cfm">
        <p>Login:<br><input type="text" name="username"/>
        	<br>
        	Password:<br>
        	<input type="password" name="password"/>
        	<br>
        	<br>
			<input type="submit" name="submit"/>
        </p>
		</form>
		<p>&nbsp; </p>
		<p><a href="register.cfm">Register</a></p>
	</div>
	<div style="height:50px"></div>	
		
		
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.9.1.min.js"><\/script>')</script>
	<script src="js/plugins.js"></script>
	<script src="js/main.js"></script>
   	<!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
	<script>
            var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
            (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
            g.src='//www.google-analytics.com/ga.js';
            s.parentNode.insertBefore(g,s)}(document,'script'));
        	</script>
    </body>
</html>
