<!DOCTYPE html>
<html lang="en">

<head>
    @include('layouts.head')
</head>

<style>
    .mt-10 {
        margin-top: 5rem;
    }
</style>

<body>


    <!-- Navbar start -->
    <div class="container-fluid fixed-top">
        <div class="container topbar bg-primary d-none d-lg-block">
            <div class="d-flex justify-content-between">
                <div class="top-info ps-2">
                    <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">123 Street, New York</a></small>
                    <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">Email@Example.com</a></small>
                </div>
                <div class="top-link pe-2">
                    <a href="#" class="text-white"><small class="text-white mx-2">Privacy Policy</small>/</a>
                    <a href="#" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a>
                    <a href="#" class="text-white"><small class="text-white ms-2">Sales and Refunds</small></a>
                </div>
            </div>
        </div>
        <div class="container px-0">
            <nav class="navbar navbar-light bg-white navbar-expand-xl">
                <a href="index.html" class="navbar-brand">
                    <h1 class="text-primary display-6">IKONIC</h1>
                </a>
                <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-primary"></span>
                </button>
                <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                    <div class="navbar-nav mx-auto"></div>
                    <div class="d-flex m-3 me-0">
                        <a href="/register" class="nav-item nav-link">Register</a>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->


    <div class="container-fluid contact py-5 mt-10">
        <div class="row py-5 justify-content-center">
            <div class="col-lg-5 p-5 bg-light rounded">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="text-center mx-auto" style="max-width: 700px;">
                            <h1 class="text-primary">Login</h1>
                            <p class="mb-4">Effortless access to your personalized world with a seamless login experience.</p>
                        </div>
                    </div>
                    <form action="{{ route('login') }}" class="" method="POST">
                        @csrf
                        <input name="email" type="email" class="w-100 form-control border-0 py-3 mb-4" placeholder="Your Email">
                        <input name="password" type="password" class="w-100 form-control border-0 py-3 mb-4" placeholder="Your Password">
                        <button class="w-100 btn form-control border-secondary py-3 bg-white text-primary " type="submit">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    @include('layouts.script')
</body>

</html>