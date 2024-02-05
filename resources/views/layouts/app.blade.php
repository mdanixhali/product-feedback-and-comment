<!DOCTYPE html>
<html lang="en">
    <head>
        @include('layouts.head')
        @vite('resources/js/app.js')
    </head>
    @yield('css')

    <body>
        <div id="app"></div>
        @include('layouts.footer')
        @include('layouts.script')
    </body>
</html>
