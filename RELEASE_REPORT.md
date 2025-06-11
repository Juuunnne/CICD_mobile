# RELEASE_REPORT.md

## Outils Testés

### 1. Standard-Version

- **Description** : Gère le version bump, la génération de changelog et le tagging Git.
- **Forces** :
  - Simple à configurer et utiliser.
  - Génère automatiquement un changelog structuré basé sur les commits conventionnels.
  - Compatible avec SemVer.
- **Faiblesses** :
  - Ne gère pas directement la publication des releases sur GitHub ou GitLab.

### 2. Release-It

- **Description** : Outil tout-en-un pour gérer les versions, les changelogs, les tags et publier les releases.
- **Forces** :
  - Interface interactive et intuitive.
  - Supporte la publication sur GitHub/GitLab.
  - Hautement configurable.
- **Faiblesses** :
  - Configuration initiale plus complexe.

### 3. Semantic-Release

- **Description** : Publication totalement automatisée via CI, basée sur les commits conventionnels.
- **Forces** :
  - Automatisation complète du processus de release.
  - Intégration native avec les pipelines CI/CD.
  - Génère des changelogs et publie des releases sans intervention manuelle.
- **Faiblesses** :
  - Nécessite une stricte adhérence aux commits conventionnels.
  - Plus difficile à configurer pour les débutants.

## Comparaison des Outils

| Outil            | Version Bump | Changelog | Tag Git | Release GitHub/GitLab | Automatisation CI |
| ---------------- | ------------ | --------- | ------- | --------------------- | ----------------- |
| Standard-Version | Oui          | Oui       | Oui     | Non                   | Non               |
| Release-It       | Oui          | Oui       | Oui     | Oui                   | Partiel           |
| Semantic-Release | Oui          | Oui       | Oui     | Oui                   | Oui               |

## Choix et Justification

Pour ce projet, nous avons choisi d'utiliser **Standard-Version** et **Release-It** car :

- **Standard-Version** est simple et rapide à configurer pour gérer les versions et les changelogs.
- **Release-It** complète Standard-Version en permettant de publier les releases sur GitHub.

## Difficultés Rencontrées

- Configuration initiale de Release-It pour gérer les tokens d'authentification GitHub.
- Adaptation des messages de commit pour respecter les conventions nécessaires à Standard-Version.

## Résultats

- Un script `release.sh` unifié a été créé pour centraliser le processus de publication.
- Les releases sont maintenant semi-automatisées avec génération de changelog, tagging Git, et publication sur GitHub.

## Améliorations Futures

- Intégrer **Semantic-Release** pour une automatisation complète via CI/CD.
- Ajouter des tests supplémentaires pour sécuriser davantage le processus de release.
