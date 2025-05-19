-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 20 mai 2025 à 00:42
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `app_bibliotheque`
--

-- --------------------------------------------------------

--
-- Structure de la table `emprunts`
--

CREATE TABLE `emprunts` (
  `id` int(11) NOT NULL,
  `id_membre` int(11) NOT NULL,
  `id_livre` int(11) NOT NULL,
  `date_emprunt` date NOT NULL DEFAULT current_timestamp(),
  `date_retour` date DEFAULT NULL,
  `date_retour_prevue` date DEFAULT NULL,
  `amende` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `emprunts`
--

INSERT INTO `emprunts` (`id`, `id_membre`, `id_livre`, `date_emprunt`, `date_retour`, `date_retour_prevue`, `amende`) VALUES
(1, 1, 2, '2025-05-19', NULL, '2025-05-31', 0),
(3, 2, 4, '2025-05-19', NULL, '2025-06-10', 0),
(5, 2, 10, '2025-05-19', NULL, '2025-06-30', 0),
(7, 1, 2, '2025-05-19', NULL, '2025-06-23', 0);

-- --------------------------------------------------------

--
-- Structure de la table `livre`
--

CREATE TABLE `livre` (
  `id` int(11) NOT NULL,
  `titre` text NOT NULL,
  `auteur` text NOT NULL,
  `isbn` text NOT NULL,
  `annee` int(11) NOT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `livre`
--

INSERT INTO `livre` (`id`, `titre`, `auteur`, `isbn`, `annee`, `disponible`) VALUES
(2, 'jrjjf', 'jrjrjr', 'jfjfjjf', 2008, 1),
(4, 'Bel ami', 'Bon Marchais', '249894', 2001, 1),
(9, 'Amitie', 'Moliere', '434433MKDFMF', 2004, 1),
(10, 'Amour', 'Toto', '5353chfh', 2001, 1),
(22, 'df', 'rdthf', 'vbcfbcfgert434', 2007, 1),
(23, 'df', 'rdthf', 'vbcfbcfgert434', 2007, 1);

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

CREATE TABLE `membre` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `amendes` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `membre`
--

INSERT INTO `membre` (`id`, `nom`, `prenom`, `telephone`, `amendes`) VALUES
(1, 'lglllg', 'klkglgflkg', '8945895489', 0),
(2, 'lfdll', 'lklele', '0954905404', 0),
(3, 'lfdll', 'lklele', '0954905404', 0),
(4, 'lfdll', 'lklele', '0954905404', 0),
(5, 'ELLA', 'Ketsia', '655668899', 0);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`) VALUES
(1, 'ellaketsy@gmail.com', 'Meka@2004');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `emprunts`
--
ALTER TABLE `emprunts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_membre` (`id_membre`),
  ADD KEY `id_livre` (`id_livre`);

--
-- Index pour la table `livre`
--
ALTER TABLE `livre`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `membre`
--
ALTER TABLE `membre`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `emprunts`
--
ALTER TABLE `emprunts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `livre`
--
ALTER TABLE `livre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `membre`
--
ALTER TABLE `membre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `emprunts`
--
ALTER TABLE `emprunts`
  ADD CONSTRAINT `emprunts_ibfk_1` FOREIGN KEY (`id_membre`) REFERENCES `membre` (`id`),
  ADD CONSTRAINT `emprunts_ibfk_2` FOREIGN KEY (`id_livre`) REFERENCES `livre` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
