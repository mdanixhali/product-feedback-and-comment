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
                        <a href="/login" class="nav-item nav-link">Login</a>
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
                            <h1 class="text-primary">Register yourself</h1>
                            <p class="mb-4">Streamline your experience with a quick and secure account registration process.</p>
                        </div>
                    </div>
                    <form action="" class="">
                        <input type="text" class="w-100 form-control border-0 py-3 mb-4" placeholder="Your Name">
                        <input type="email" class="w-100 form-control border-0 py-3 mb-4" placeholder="Enter Your Email">
                        <input type="password" class="w-100 form-control border-0 py-3 mb-4" placeholder="Your Password">
                        <input type="password" class="w-100 form-control border-0 py-3 mb-4" placeholder="Comfirm Password">
                        <button class="w-100 btn form-control border-secondary py-3 bg-white text-primary " type="submit">Register</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    @include('layouts.script')
</body>

</html>