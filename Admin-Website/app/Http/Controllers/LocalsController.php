<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class LocalsController extends Controller
{

    public function getAllLocals(){
        #$posts = DB::table('locais')->get();
        #foreach($posts as $index=>$post){
        #    $local_nome=DB::table('locais')->where("id", $post->locais_id)->get()->toArray();
        #    $post->local_nome=$local_nome[0]->nome;
        #}

        $locais = DB::table('locais')->get()->toArray();

        return view('locals.locals', [
            #"posts"=>$posts,
            "locais" => $locais
        ]);
    }

    public function filter(Request $request){
        $posts = DB::table('locais')->get();
        $html="";
        foreach($posts as $index=>$post){
            $html .="<tr>";
            #$local_nome=DB::table('locais')->where("id", $post->id)->get()->toArray();
            #$post->local_nome=$local_nome[0]->nome;
            $html .= "<td>".$post->id."</td>";
            $html .= "<td>".$post->tipo."</td>";
            $html .= "<td>".$post->nome."</td>";
            $html .= "<td>".$post->data_inicio."</td>";
            $html .= "<td>".$post->hora_inicio."</td>";
            $html .= "<td>".$post->hora_fim."</td>";
            $html .= "<td>".$post->utilizadores_id."</td>";
            $html .= "<td>".$post->local_nome."</td>";
            $html .= '<td>
            <a href="/edit-post/3" class="btn btn-info">Edit</a>
            <a href="/delete-post/3" class="btn btn-danger">Delete</a>
        </td>';
            $html .="</tr>";

        }

        return $html;
    }

    public function addLocal(){
        return view('locals.addLocal');

    }

    public function addLocalSubmit(Request $request){
        $imagem = base64_encode(file_get_contents($request->file('imagem')->path()));


        DB::table('locais')->insert([
            'nome'=>$request->nome,
            'lugares'=>$request->lugares,
            'descricao'=>$request->descricao,
            'horario_abertura'=>$request->horario_abertura,
            'horario_fecho'=>$request->horario_fecho,
            'localizacao'=>$request->localizacao,
            'imagem'=>$imagem,
            'morada'=>$request->morada]);
        return back()->with('local_created','Local criado com sucesso');
    }


    public function deleteLocal($id){
        DB::table('locais')->where('id',$id)->delete();
        return back()->with('local_deleted','O local foi removido com sucesso');
    }

    public function editLocal($id){
        $local = DB::table('locais')->where('id',$id)->first();
        return view('locals.edit-local',compact('local'));
    }

    public function updateLocal(Request $request){

        if (isset($request->imagem) && $request->imagem!="" ){

            $imagem = base64_encode(file_get_contents($request->file('imagem')->path()));
            DB::table('locais')->where('id',$request->id)->update(['imagem'=>$imagem]);
        }

        DB::table('locais')->where('id',$request->id)->update([
            'nome'=>$request->nome,
            'lugares'=>$request->lugares,
            'descricao'=>$request->descricao,
            'horario_abertura'=>$request->horario_abertura,
            'horario_fecho'=>$request->horario_fecho,
            'localizacao'=>$request->localizacao,
            'morada'=>$request->morada]);


        return back()-> with('local_updated','Local foi atualizado com sucesso');
    }

}
