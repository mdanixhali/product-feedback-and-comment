<?php

namespace App\Http\Requests\Auth;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules;
use App\Models\User;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Support\Facades\Hash;


class RegisterUserRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:' . User::class],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ];
    }

    public function failedValidation(Validator $validator)
    {
        $errors = collect($validator->errors()->messages());
        $errors = $errors->mapWithKeys(function ($error, $key) {
            return [$key => $error[0]];
        });
        throw new HttpResponseException(response()->json([
            'errors' => $errors,
            'message' => 'Please review the form and fix the errors before submitting.'
        ], 422));
    }

    protected function passedValidation(): void
    {
        $this->replace(['password' => Hash::make($this->input('password'))]);
    }
}
