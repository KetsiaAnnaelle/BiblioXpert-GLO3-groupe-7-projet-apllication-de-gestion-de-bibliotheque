<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>BiblioXpert</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../css/index.css" />

    <style>
      
    </style>
  </head>
  <body>
    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg bg-light shadow sticky-top">
      <div class="container-fluid">
        <a class="navbar-brand fw-bold text-primary" href="/">BiblioXpert</a>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto">
            <li class="nav-item">
              <a class="nav-link active text-primary fw-semibold" href="#">Accueil</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Ã propos</a>
            </li>
            <li class="nav-item dropdown">
              <a
                class="nav-link dropdown-toggle"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
              >
                Mon compte
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">Ketsia</a></li>
                <li><a class="dropdown-item" href="#">Se dÃ©connecter</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- CAROUSEL -->
    <div
      id="carouselExampleCaptions"
      class="carousel slide carousel-fade carousel-custom-height"
      data-bs-ride="carousel"
    >
      <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"></button>
      </div>
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img src="../img/img biblio.jpg" class="d-block w-100" alt="Image 1" />
          <div class="carousel-caption d-none d-md-block">
            <h2 class="text-light fw-bold">Bienvenue sur BiblioXpert</h2>
            <p class="text-white-50">
              Votre outil intelligent pour une gestion simple et efficace de votre bibliotheque !
            </p>
          </div>
        </div>
        <div class="carousel-item">
          <img src="../img/img-biblio-3.jpg" class="d-block w-100" alt="Image 2" />
          <div class="carousel-caption d-none d-md-block">
            <h2 class="text-light fw-bold">
              La technologie transforme la gestion des bibliotheques
            </h2>
            <p class="text-white-50">
              Offrant Ã  chaque livre son propre chemin vers les lecteurs.
            </p>
          </div>
        </div>
        <div class="carousel-item">
          <img src="../img/jeune-etudiant-apprenant-dans-la-bibliotheque.jpg" class="d-block w-100" alt="Image 3" />
          <div class="carousel-caption d-none d-md-block">
            <h2 class="text-light fw-bold">
              A l'ere du numerique, gerer une bibliotheque sans technologie...
            </h2>
            <p class="text-white-50">...c'est vouloir naviguer sans boussole.</p>
          </div>
        </div>
      </div>
      <button
        class="carousel-control-prev"
        type="button"
        data-bs-target="#carouselExampleCaptions"
        data-bs-slide="prev"
      >
        <span class="carousel-control-prev-icon"></span>
        <span class="visually-hidden">Precedent</span>
      </button>
      <button
        class="carousel-control-next"
        type="button"
        data-bs-target="#carouselExampleCaptions"
        data-bs-slide="next"
      >
        <span class="carousel-control-next-icon"></span>
        <span class="visually-hidden">Suivant</span>
      </button>
    </div>

    <!-- CARDS -->
    <div class="container my-5">
      <div class="row g-4">
        <div class="col-md-4">
          <div class="card shadow-sm h-100">
            <div class="card-body">
              <h5 class="card-title text-primary fw-bold">Gestion des Livres</h5>
              <p class="card-text">Ajoutez, modifiez et organisez vos ouvrages en toute simplicitÃ©.</p>
              <a href="/WebApplication1/page-jsp/GestionLivre.jsp" class="btn btn-outline-primary">Visiter</a>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card shadow-sm h-100">
            <div class="card-body">
              <h5 class="card-title text-primary fw-bold">Gestion des Emprunts</h5>
              <p class="card-text">Suivez les prets, les retours et les Echeances sans effort.</p>
              <a href="/WebApplication1/page-jsp/Emprunt.jsp" class="btn btn-outline-primary">Visiter</a>
            </div>
          </div>
        </div>
          
          <div class="col-md-4">
          <div class="card shadow-sm h-100">
            <div class="card-body">
              <h5 class="card-title text-primary fw-bold">Gestion des retours</h5>
              <p class="card-text">Suivez les prets, les retours et les Echeances sans effort.</p>
              <a href="/WebApplication1/page-jsp/RetourEmprunt.jsp" class="btn btn-outline-primary">Visiter</a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- FOOTER -->
    <footer>
      <div class="container">
        &copy; 2025 BiblioXpert Tous droits rreserves.
      </div>
    </footer>

    <script src="../js/bootstrap.bundle.js"></script>
  </body>
</html>

