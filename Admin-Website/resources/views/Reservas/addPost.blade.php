<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DB CRUD Operation</title>
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
                        <div class="card-header">
                            Adicionar Novo Local
                        </div>
                        <div class="card-body">
                            @if(Session::has('post_created'))
                                <div class="alert alert-success" role="alert">
                                    {{Session::get('post_created')}}
                                </div>
                            @endif
                            <form method="POST" action="{{route('post.addsubmit')}}">
                                @csrf

                               <div class="form-group">
                                   <label for="matricula">Matricula </label>
                                   <input type="text" name="matricula" class="form-control" placeholder="enter Post title"/>
                               </div>
                                <div class="form-group">
                                    <label for="tipo">Example select</label>
                                    <select class="form-control" name='tipo' id="exampleFormControlSelect1">
                                        <option>Vacinacao</option>
                                        <option>Teste Covid</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="data_inicio">data_inicio</label>
                                    <input type="text" name="data_inicio" class="form-control" placeholder="enter Post Titçe"/>
                                </div>
                                <div class="form-group">
                                    <label for="hora_inicio">hora_inicio</label>
                                    <input type="text" name="hora_inicio" class="form-control" placeholder="enter Post Titçe"/>
                                </div>
                                <div class="form-group">
                                    <label for="hora_fim">hora_fim</label>
                                    <input type="text" name="hora_fim" class="form-control" placeholder="enter Post Titçe"/>
                                </div>
                                <div class="form-group">
                                    <label for="utilizadores_id">utilizadores_id</label>
                                    <input type="text" name="utilizadores_id" class="form-control" placeholder="enter Post Titçe"/>
                                </div>
                                <div class="form-group">
                                    <label for="locais_id">locais_id</label>
                                    <input type="text" name="locais_id" class="form-control" placeholder="enter Post Titçe"/>
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
