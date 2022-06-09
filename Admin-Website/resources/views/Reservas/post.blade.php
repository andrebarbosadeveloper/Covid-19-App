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
  </head>
  <body>

  <style>
      .card-header {
          font-size: 1.2rem;
          padding: .75rem 1.25rem;
          margin-bottom: 0;
          background-color: paleturquoise;
          border-bottom: 1px solid rgba(0,0,0,.125);
      }
      .bg-light-turq {
          background-color: paleturquoise;
      }
      </style>
    <section>
        <div class="row">
            <div class="col-md-12">
                <div class="card">
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
                    <div class="dropdown" style="padding: .75rem 1.25rem;">
                        <button type="button" class="btn btn-dark dropdown-toggle   mt-2 mb-2" data-toggle="dropdown" style="padding: .75rem 1.25rem;">
                          Locais
                        </button>
                        <div class="dropdown-menu ">
                            @foreach($locais as $local)
                                <a class="dropdown-item dropdown_local " local_id="{{$local->id}}" href="#">{{$local->nome}}</a>
                            @endforeach
                        </div>
                      </div>
                    <div class="card-body">
                        @if(Session::has('post_deleted'))
                            <div class="alert alert-success" role="alert">
                                {{Session::get('post_deleted')}}
                            </div>
                        @endif




                            <table class="table table-striped table-hover">
                                <thead class="thead-dark">
                            <tr>
                                <th>ID</th>
                                <th>Tipo</th>
                                <th>Matricula</th>
                                <th>Data</th>
                                <th>Hora Inicio</th>
                                <th>Hora Fim</th>
                                <th>ID Utilizador</th>
                                <th>Nome Local</th>
                                <th>Ação</th>

                            </tr>
                            </thead>
                            <tbody id="tbody">
                            @foreach($posts as $post)
                                <tr>
                                    <td>{{$post->id}}</td>
                                    <td>{{$post->tipo}}</td>
                                    <td>{{$post->matricula}}</td>
                                    <td>{{$post->data_inicio}}</td>
                                    <td>{{$post->hora_inicio}}</td>
                                    <td>{{$post->hora_fim}}</td>
                                    <td>{{$post->utilizadores_id}}</td>
                                    <td>{{$post->local_nome}}</td>
                                    <td>
                                        <a href="/edit-post/{{$post->id}}" class="btn btn-outline-dark">Edit</a>
                                        <a href="/delete-post/{{$post->id}}" class="btn btn-danger">Delete</a>
                                    </td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <script>
        $(document).ready(function(){
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });
            $(".dropdown_local").click(function(){
                var local_id=$(this).attr("local_id");

                $.ajax({
                    type: "POST",
                    url: "/filter",
                    async: false,
                    data:{
                        local_id: local_id
                    },
                    success: function(data)
                    {
                        $("#tbody").html(data);
                    }
                });
            });
        });
    </script>

  </body>
</html>
