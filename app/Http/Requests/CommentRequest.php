<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Contracts\Validation\Validator;

class CommentRequest extends FormRequest
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
            'comment' => ['required', 'string', 'max:500'],
            'feedback_id' => ['required'],
            'user_id' => ['required'],
        ];
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'user_id' => auth()->user()->id,
        ]);
    }

    public function failedValidation(Validator $validator){
        $errors = collect($validator->errors()->messages());
        $errors = $errors->mapWithKeys(function ($error, $key) {
            return [$key => $error[0]];
        });
        throw new HttpResponseException(response()->json([
            'errors' => $errors,
            'message' => 'Please review the form and fix the errors before submitting.'
        ], 422));
    }
}
