<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AppCovid</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
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
                    <a class="nav-item nav-link active" href="{{ url('/posts') }}">Reservas No Sistema <span class="sr-only"></span></a>
                    <a class="nav-item nav-link active" href="{{ url('/locals') }}">Locais <span class="sr-only"></span></a>
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
                    <div class="card-header">
                        Adicionar Novo Local
                    </div>
                    <div class="card-body">
                        @if(Session::has('local_created'))
                            <div class="alert alert-success" role="alert">
                                {{Session::get('local_created')}}
                            </div>
                        @endif
                        <form method="POST" action="{{route('local.addsubmit')}}" enctype="multipart/form-data">
                            @csrf

                            <div class="form-group" style="margin: 10px">
                                <label for="nome">Nome</label>
                                <input type="text" name="nome" class="form-control" placeholder="Insira o nome"/>
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="lugares">Lugares</label>
                                <input type="text" name="lugares" class="form-control" placeholder="Insira os lugares"/>
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="descricao">Descricao</label>
                                <textarea class = "form-control w-100" name="descricao" placeholder="Insira a descricao"></textarea>
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="horario_abertura">Horario Abertura</label>
                                <input type="text" name="horario_abertura"  class="form-control" placeholder="Insira a hora de abertura"/>
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="horario_fecho">Horario Fecho</label>
                                <input type="text" name="horario_fecho"  class="form-control" placeholder="Insira a hora de fecho"/>
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="localizacao">Localizacao</label>
                                <input type="text" name="localizacao"  class="form-control" placeholder="Insira a localizacao"/>
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="imagem">Imagem</label>
                                <input accept="image/png, image/jpeg" type="file" name="imagem" class="form-control" placeholder="Insira a imagem"/>
                            </div>
                            <div class="form-group" style="margin: 10px">
                                <label for="morada">Morada</label>
                                <input type="text" name="morada" class="form-control" placeholder="Insira a morada"/>
                            </div>
                            <input type="submit" class="btn btn-success" value="Submit"/>
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
