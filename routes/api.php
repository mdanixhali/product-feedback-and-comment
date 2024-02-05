<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\FeedbackController;
use App\Http\Controllers\CommentController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware(['auth:sanctum'])->group(function () {
    Route::post('/auth/logout', [AuthenticatedSessionController::class, 'destroy']);


    Route::resource('feedback', FeedbackController::class);
    Route::resource('comment', CommentController::class);
    Route::get('user', [CommentController::class, 'getUsers']);
});

Route::get('/refresh-csrf-token', [AuthenticatedSessionController::class, 'refreshCsrfToken']);
Route::post('/auth/login', [AuthenticatedSessionController::class, 'store']);
Route::post('/auth/register', [RegisteredUserController::class, 'store']);
