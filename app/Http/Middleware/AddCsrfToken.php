<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Log;

class AddCsrfToken
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Log a message for debugging
        if ($request->method() === 'POST' || $request->method() === 'PUT') {
            $request->headers->add(['X-CSRF-Token' => csrf_token()]);
        }
        Log::info('Method: '. csrf_token());

        return $next($request);
    }
}
