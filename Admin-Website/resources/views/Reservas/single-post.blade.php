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
    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header">
                        Local
                    </div>
                    <div class="card-body">
                        <form>
                            <div class="form-group">
                                <label for="matricula">Matricula</label>
                                <input type="text" name="matricula" value="{{$post->matricula}}" class="form-control" placeholder="enter Post title"/>
                            </div>
                            <div class="form-group">
                                <label for="tipo">Matricula </label>
                                <input type="text" name="tipo" value="{{$post->tipo}}" class="form-control" placeholder="enter Post title"/>
                            </div>
                            <div class="form-group">
                                <label for="data_inicio">data_inicio</label>
                                <input type="text" name="data_inicio" value="{{$post->data_inicio}}" class="form-control" placeholder="enter Post Titçe"/>
                            </div>
                            <div class="form-group">
                                <label for="hora_inicio">hora_inicio</label>
                                <input type="text" name="hora_inicio" value="{{$post->hora_inicio}}" class="form-control" placeholder="enter Post Titçe"/>
                            </div>
                            <div class="form-group">
                                <label for="hora_fim">hora_fim</label>
                                <input type="text" name="hora_fim" value="{{$post->hora_fim}}" class="form-control" placeholder="enter Post Titçe"/>
                            </div>
                            <div class="form-group">
                                <label for="utilizadores_id">utilizadores_id</label>
                                <input type="text" name="utilizadores_id" value="{{$post->utilizadores_id}}" class="form-control" placeholder="enter Post Titçe"/>
                            </div>
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
