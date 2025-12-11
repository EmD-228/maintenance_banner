# Instructions pour publier sur pub.dev

## Prérequis

1. **Créer un compte sur pub.dev** (si vous n'en avez pas)
   - Allez sur https://pub.dev
   - Cliquez sur "Sign in" et créez un compte avec votre compte Google

2. **Vérifier que votre package est prêt**
   - ✅ Le dry-run a réussi (0 warnings)
   - ✅ Tous les fichiers sont en anglais
   - ✅ Le README est complet
   - ✅ La version est définie dans pubspec.yaml (0.1.0)

## Étapes de publication

### 1. Se connecter à pub.dev

```bash
cd /Users/kokoudenyo/Documents/EMD/PROJECTS/Packages/maintenance_banner
dart pub login
```

Cela ouvrira votre navigateur pour vous connecter avec votre compte Google.

### 2. Vérifier une dernière fois (optionnel)

```bash
flutter pub publish --dry-run
```

### 3. Publier le package

```bash
flutter pub publish
```

⚠️ **Important** : Une fois publié, vous ne pourrez plus supprimer ou modifier la version publiée. Vous pourrez seulement publier de nouvelles versions.

## Mettre à jour une version existante

Pour mettre à jour votre package après la première publication :

1. **Incrémenter la version** dans `pubspec.yaml` :
   ```yaml
   version: 0.1.1  # ou 0.2.0 pour une version mineure, 1.0.0 pour une version majeure
   ```

2. **Mettre à jour le CHANGELOG.md** avec les changements

3. **Commit et push sur GitHub**

4. **Publier la nouvelle version** :
   ```bash
   flutter pub publish
   ```

## Notes importantes

- Le nom du package (`maintenance_banner`) doit être unique sur pub.dev
- Si le nom est déjà pris, vous devrez changer le nom dans `pubspec.yaml`
- Les versions suivent le format semver (MAJOR.MINOR.PATCH)
- Une fois publié, la version ne peut plus être modifiée, seulement de nouvelles versions peuvent être ajoutées

