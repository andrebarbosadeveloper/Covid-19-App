<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HelloWorldController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\LocalsController;
use Illuminate\Support\Facades\Auth;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {

    return view('auth/login');
});

Route::get('/helloworld',[HelloWorldController::class,'index']);


Route::get('/posts',[PostController::class,'getAllPost'])->name('post.getallpost')->middleware('auth');;
Route::post('/filter',[PostController::class,'filter'])->name('post.filter');
Route::get('/addpost',[PostController::class,'addPost'])->name('post.add');
Route::post('/addpost',[PostController::class,'addPostSubmit'])->name('post.addsubmit');

Route::get('posts/{local_id}',[PostController::class,'getPostByLocalId'])->name('post.getbylocal_id');

Route::get('/delete-post/{id}',[PostController::class,'deletePost'])->name('post.delete');
Route::get('edit-post/{id}',[PostController::class,'editPost'])->name('post.edit');
Route::post('/update-request',[PostController::class,'updatePost'])->name('post.update');

Route::get('/locals',[LocalsController::class,'getAllLocals'])->name('locals.getalllocals')->middleware('auth');;
Route::get('/delete-local/{id}',[LocalsController::class,'deleteLocal'])->name('local.delete');
Route::get('edit-local/{id}',[LocalsController::class,'editLocal'])->name('local.edit');
Route::post('/update-local',[LocalsController::class,'updateLocal'])->name('local.update');
Route::get('/addlocal',[LocalsController::class,'addLocal'])->name('local.add');
Route::post('/addlocal',[LocalsController::class,'addLocalSubmit'])->name('local.addsubmit');

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
