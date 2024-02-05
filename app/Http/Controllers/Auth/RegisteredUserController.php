<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\RegisterUserRequest;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;


class RegisteredUserController extends Controller
{
    /**
     * Handle an incoming registration request.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(RegisterUserRequest $request): Response
    {
        DB::beginTransaction();
        try {
            $validated = $request->validated();
            $all = $request->all();
            $validated['password'] = $all['password'];
            $user = User::create($validated);
            event(new Registered($user));
            DB::commit();
            return response([
                'success' => true,
                'message' => 'Register successfully!'
            ]);
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'success' => false,
                'message' => 'Something went wrong. Please refresh the page and try again.',
            ]);
        }
    }
}
