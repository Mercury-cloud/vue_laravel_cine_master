<html>
<style>
    .content {
        background:#fff;
        width:50%;
        margin: 50px auto;
        padding:50px;
    }
    .logo {
        width:25%;
        margin:0 auto;
        text-align: center;
    }
    .logo span {
        margin-top:50px;
    }
    .logo p  {
        display: inline-block;
        position: relative;
        color: #404040;
        font-size: 25px;
        font-family: sans-serif;
    }
    .footer {
        margin-top:100px;
        background:#e8e8e8;
        padding:20px;
    }
</style>
<body>
<div class="content" style="background: #fff;width: 50%;margin: 50px auto;padding: 50px;">
    <div class="header">
        <div class="logo" style="width: 25%;margin: 0 auto;text-align: center;">
            <p style="display: inline-block;position: relative;color: #404040;font-size: 25px;font-family: sans-serif;">{{ config('app.name') }} </p>
        </div>
    </div>
    <hr>
    <!-- END Header -->

    <div class="body">
        <p>Bonjour {{$data->name}}</p>
        <p>Quelqu'un essaie d'accéder à votre compte</p>
        <hr>
        <p>Emplacement: {{$data->country}} / {{$data->city}}</p>
        <p>IP: {{$data->ip}}</p>
        <p>Date: {{$data->created_at}}</p>
        <hr>
        <p>Veuillez confirmer la localisation de votre appareil
        <a href="{{route('confirm_device', ['token' => $data->confirm_hash])}}">Cliquez ici</a></p>
    </div>
    <!-- END BODY -->

    <div class="footer" style="margin-top: 100px;background: #e8e8e8;padding: 20px;">
        <p>Veuillez ne pas répondre à ce courriel. Les courriers électroniques envoyés à cette adresse ne recevront pas de réponse.
        </p>
        <p>Copyright © 2019-2020{{ config('app.name') }}  </p>
    </div>
</div>
</body>
</html>
