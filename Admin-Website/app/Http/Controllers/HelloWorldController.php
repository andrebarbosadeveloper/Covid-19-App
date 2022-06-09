<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HelloWorldController extends Controller
{
    public function index(){
        $helloWorld='hello world';
        return view('hello_world.index',compact('helloWorld'));
    } 
}

