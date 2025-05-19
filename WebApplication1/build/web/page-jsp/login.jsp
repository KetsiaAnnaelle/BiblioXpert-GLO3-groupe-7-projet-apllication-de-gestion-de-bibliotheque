<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion - BiblioXpert</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <style>
        body {
            background-color: #f5f6fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .card {
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: none;
            animation: fadeInUp 1s ease-in-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-label {
            font-weight: 500;
        }

        .form-control {
            transition: all 0.3s ease;
        }

        .form-control:focus {
            box-shadow: 0 0 5px rgba(0,123,255,0.6);
            transform: scale(1.02);
        }

        .btn-primary {
            width: 100%;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        .login-img {
            width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 8px;
            transition: transform 0.4s ease;
        }

        .login-img:hover {
            transform: scale(1.05);
        }

        .title-main {
            font-size: 1.5rem;
            font-weight: bold;
            text-align: center;
            margin-bottom: 0.5rem;
        }

        .subtitle {
            font-size: 0.95rem;
            text-align: center;
            color: #666;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center align-items-center min-vh-100">
        <div class="col-md-10">
            <div class="card p-4">
                <div class="row">
                    <!-- Image -->
                    <div class="col-md-6 d-none d-md-block">
                        <img src="../img/img biblio.jpg" alt="Bibliothèque" class="login-img">
                    </div>

                    <!-- Formulaire -->
                    <div class="col-md-6">
                        <p class="title-main text-primary">Veuillez-vous connecter à notre application <strong>BiblioXpert</strong>.</p>
                        <p class="subtitle">Gérez efficacement vos livres, emprunts et membres via notre interface intuitive.</p>

                        <form method="post" action="login">
                            <div class="mb-3">
                                <label for="email" class="form-label">Adresse Email</label>
                                <input type="email" class="form-control" name="email" id="email" required>
                                <div id="errorColor" class="invalid-feedback"></div>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">Mot de passe</label>
                                <input type="password" class="form-control" name="password" id="password" required>
                                <div id="errorRange" class="invalid-feedback"></div>
                            </div>

                            <button type="submit" class="btn btn-primary">Se connecter</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="../js/bootstrap.bundle.js"></script>
<script src="../js/all.min.js"></script>
</body>
</html>
