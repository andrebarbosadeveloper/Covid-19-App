<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <title>AppCovid</title>

    <style>
        .card-header {
            font-size: 1.2rem;
            padding: .75rem 1.25rem;
            margin-bottom: 0;
            color:#fff;
            background-color: paleturquoise;
            border-bottom: 1px solid rgba(0,0,0,.125);
        }
    </style>
</head>



<body>
<section>

    <navbar>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="background-color: paleturquoise">
            <a class="navbar-brand" href="#">AppCovid</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav ">
                    <a class="nav-item nav-link active" href="{{ url('/posts') }}">Reservas No Sistema <span class="sr-only">(current)</span></a>
                    <a class="nav-item nav-link active" href="{{ url('/locals') }}">Locais <span class="sr-only">(current)</span></a>
                    <a class="nav-item nav-link active" style="position: absolute;right: 15px;" class="dropdown-item" href="{{ route('logout') }}"
                       onclick="event.preventDefault();
                            document.getElementById('logout-form').submit();">
                        {{ __('Logout') }}
                    </a>
                    <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                        @csrf
                    </form>

                </div>
            </div>
        </nav>
    </navbar>
    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card" style="margin-top: 20px;">
                    <div class="card-header bg-dark">
                        Editar Reserva
                    </div>
                    <div class="card-body">
                        @if(Session::has('post_updated'))
                            <div class="alert alert-success" role="alert">
                                {{Session::get('post_updated')}}
                            </div>
                        @endif
                        <form method="POST" action="{{route('post.update')}}">
                            @csrf
                            <input type="hidden" name="id" value="{{$post->id}}"/>
                            <div class="form-group" style="margin: 10px">
                                <label for="matricula">Matricula</label>
                                <input type="text" name="matricula" value="{{$post->matricula}}" class="form-control" />
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="tipo">Tipo</label>
                                <select class="form-control" name='tipo' value="{{$post->matricula}}" id="exampleFormControlSelect1">
                                    <option>Vacinacao</option>
                                    <option>Teste Covid</option>
                                </select>
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="data_inicio">Data</label>
                                <input type="text" name="data_inicio" value="{{$post->data_inicio}}" class="form-control"/>
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="hora_inicio">Hora Inicio</label>
                                <input type="text" name="hora_inicio" value="{{$post->hora_inicio}}" class="form-control" />
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="hora_fim">Hora Fim</label>
                                <input type="text" name="hora_fim" value="{{$post->hora_fim}}" class="form-control" />
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="utilizadores_id">ID Utilizador</label>
                                <input type="text" name="utilizadores_id" value="{{$post->utilizadores_id}}" class="form-control" />
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="locais_id">Locais</label>
                                <select name="locais_id" id="locais_id" class="form-control">
                                    @foreach($locais as $local)
                                        @if($local->id==$post->locais_id)
                                            <option value="{{$local->id}}" selected>{{$local->nome}}</option>
                                        @else
                                            <option value="{{$local->id}}">{{$local->nome}}</option>
                                        @endif

                                    @endforeach
                                </select>
                            </div>
                            <input type="submit" class="btn btn-success" value="Update" style="margin: 10px"/>

                        </form>

                    </div>
                </div>
            </div>

        </div>

    </div>
</section>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>

</body>
</html>
