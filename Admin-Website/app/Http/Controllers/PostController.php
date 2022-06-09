<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class PostController extends Controller
{

    public function getAllPost(){
        $posts = DB::table('reservas')->get();
        foreach($posts as $index=>$post){
            $local_nome=DB::table('locais')->where("id", $post->locais_id)->get()->toArray();
            $post->local_nome=$local_nome[0]->nome;
        }
        $locais = DB::table('locais')->get()->toArray();
        return view('Reservas.post', [
            "posts"=>$posts,
            "locais" => $locais
        ]);
    }

    public function filter(Request $request){
        $posts = DB::table('reservas')->where("locais_id", $request->local_id)->get();
        $html="";
        foreach($posts as $index=>$post){
            $html .="<tr>";
            $local_nome=DB::table('locais')->where("id", $post->locais_id)->get()->toArray();
            $post->local_nome=$local_nome[0]->nome;
            $html .= "<td>".$post->id."</td>";
            $html .= "<td>".$post->tipo."</td>";
            $html .= "<td>".$post->matricula."</td>";
            $html .= "<td>".$post->data_inicio."</td>";
            $html .= "<td>".$post->hora_inicio."</td>";
            $html .= "<td>".$post->hora_fim."</td>";
            $html .= "<td>".$post->utilizadores_id."</td>";
            $html .= "<td>".$post->local_nome."</td>";
            $html .= '<td>
            <a href="/edit-post/3" class="btn btn-outline-dark">Edit</a>
            <a href="/delete-post/3" class="btn btn-danger">Delete</a>
        </td>';
            $html .="</tr>";

        }

        return $html;
    }

    public function addPost(){
        return view('Reservas.addPost');

    }

    public function addPostSubmit(Request $request){



        DB::table('reservas')->insert(['matricula'=>$request->matricula,
                                            'tipo'=>$request->tipo,
                                            'data_inicio'=>$request->data_inicio,
                                             'hora_inicio'=>$request->hora_inicio,
                                            'hora_fim'=>$request->hora_fim,
                                            'utilizadores_id'=>$request->utilizadores_id,
                                            'locais_id'=>$request->locais_id]);
        return back()->with('post_created','Post has been created');
    }

    public function getPostByLocalId($local_id){
        $post =DB::table('reservas')->where('locais_id',$local_id);
        return view('Reservas.single-post',compact('post'));
    }

    public function deletePost($id){
        DB::table('reservas')->where('id',$id)->delete();
        return back()->with('post_deleted','A reserva foi removida com sucesso');
    }

    public function editPost($id){
        $post = DB::table('reservas')->where('id',$id)->first();
        $locais=DB::table('locais')->get()->toArray();
        return view('Reservas.edit-post',compact('post', "locais"));
    }

    public function updatePost(Request $request){
        DB::table('reservas')->where('id',$request->id)->update([
            'matricula'=>$request->matricula,
            'tipo'=>$request->tipo,
            'data_inicio'=>$request->data_inicio,
            'hora_inicio'=>$request->hora_inicio,
            'hora_fim'=>$request->hora_fim,
            'utilizadores_id'=>$request->utilizadores_id,
            'locais_id'=>$request->locais_id]);

        return back()-> with('post_updated','Reserva foi atualizada com sucesso');
    }

}
