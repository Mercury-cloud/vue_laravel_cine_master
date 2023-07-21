<html lang="{{ app()->getLocale() }}">
    <head>
        <meta http-equiv="content-type" content="text/html;charset=UTF-8">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="HandheldFriendly" content="true">
        <meta name="theme-color" content="#db5945">
        <meta name="description" content="Regardez des films et des séries en ligne ou directement sur votre smart TV, votre console de jeu, votre PC, votre Mac, votre mobile, votre tablette et bien plus encore. Commencez votre essai gratuit dès aujourd'hui.">
        <link rel="manifest" href="manifest.json">
        <link rel="icon" sizes="192x192" href="/images/logo.png">
        <link rel="stylesheet" href="/css/app.css">
		<script src="/jwplayer.flash.swf"></script>
        <script src="https://vps809932.ovh.net/jwp/jwplayer.js"></script>
    
    </head>
  <body id="root">
   <!--  container content: START -->
   <div class="{{config('plugin.theme')}}"></div>
   <!--  container content: END -->
   <noscript>

  <div class="container">
    <div class="col-sm-6 col-sm-offset-3">
      <div class="alert alert-danger">
      JavaScript is disabled in your web browser!
    </div>
  </div>
  </div>
 </noscript>  <!--  container javascript alert: END -->
   <script src="//npmcdn.com/tether@1.2.4/dist/js/tether.min.js"></script>
   <script src="/js/admin-js/manifest.js"></script>
   <script src="/js/admin-js/vendor.js"></script>

   <script src="/js/app.js"></script>


  </body>
</html>
