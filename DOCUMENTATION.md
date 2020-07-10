# katabase/GROBID_Dictionaries - User guide


Les commandes _infra_ conviennent aux utilisateurs sous UNIX. Dans les autres cas, ne pas hésiter à consulter la documentation officielle (pas mise à jour): https://github.com/MedKhem/grobid-dictionaries/wiki

---

## Lancer les entraînements

0. Installer Docker (https://www.docker.com/)

1. Télécharger GROBID avec

```console
docker pull medkhem/grobid-dictionaries-stable
```

2. Télécharger le jeu de données d'entraînement: https://github.com/katabase/GROBID_Dictionaries

3. Synchroniser un des dataset de train avec le container (<-#kasDéDiMatthias #franglais)

```console
docker run -v CHEMIN VERS TOYDATA:/grobid/grobid-dictionaries/resources -p 8080:8080 -it medkhem/grobid-dictionaries-stable bash
```

Si le port 8080 de votre machine est déjà occupé, il est possible d'en utilise un autre (par exemple `-p 8083:8080`).

Votre terminal doit désormais commencer par quelque chose du genre `root@86f702a24041:/grobid/grobid-dictionaries# `.

Si votre catalogue ressemble à celui-ci:

<img src="https://github.com/katabase/GROBID_Dictionaries/blob/master/_images/RDA_LAD.png" width="50%">

Il faudra synchroniser _GROBID-dictionaries_ avec le dossier `trainingData_RDA_LAD`. La ligne de commande précédemment mentionnée devra donc ressembler à celle-ci:

```console
docker run -v /Users/gabaysimon/Documents/Grobid/trainingData_RDA_LAD/toyData:/grobid/grobid-dictionaries/resources -p 8080:8080 -it medkhem/grobid-dictionaries-stable bash
```

Si votre catalogue ressemble à celui-ci:

<img src="https://github.com/katabase/GROBID_Dictionaries/blob/master/_images/AUCTION.png" width="50%">

Il faudra synchroniser _GROBID-dictionaries_ avec le dossier `trainingData_AUCTION`. La ligne de commande précédemment mentionnée devra donc ressembler à celle-ci:

```console
docker run -v /Users/gabaysimon/Documents/Grobid/trainingData_AUCTION/toyData:/grobid/grobid-dictionaries/resources -p 8080:8080 -it medkhem/grobid-dictionaries-stable bash
```

4. Lancer les entraînements, l'un après l'autre

_Dictionary Segmentation_ (pour les pages)
```console
mvn generate-resources -P train_dictionary_segmentation -e
```

_Dictionary Body Segmentation_ (pour les entrées)
```console
mvn generate-resources -P train_dictionary_body_segmentation -e
```

_Lexical Entry_ (pour les sous-entrées)
```console
mvn generate-resources -P train_lexicalEntries -e
```

_Form_ (pour la première sous-entrée)

```console
mvn generate-resources -P train_form -e
```

_Sense_ (pour la seconde sous-entrée)

```console
mvn generate-resources -P train_sense -e
```

Tous les modèles sont désormais entraînés. Il faut désormais les utiliser.

---

## Web service

1. Lancer le serveur en local:

```console
mvn -Dmaven.test.skip=true jetty:run-war
```

2. Accéder au serveur: http://localhost:8080/

3. Sélectionner `Parse ful dictionary`

4. Charger le pdf

5. Cliquer sur `Submit Query`

6. Quitter l'API: Crtl+c

<img src="https://github.com/katabase/GROBID_Dictionaries/blob/master/_images/selection.png" width="50%">

---

## Transformations

Il est recommandé d'utiliser Oxygen en lançant le projet [`GROBID.xpr`](https://github.com/katabase/GROBID_Dictionaries/blob/master/GROBID.xpr), qui contient tous les scenarios pré-paramétrés.

1. Transformer le document avec [`_transformations/step_1.xsl`](https://github.com/katabase/GROBID_Dictionaries/blob/master/_transformations/step_1.xsl) (Scenario `step_1`).

2. Faire le lien avec le schema [`_schemas/schema_grobid_output.rng`](https://github.com/katabase/GROBID_Dictionaries/blob/master/_schemas/schema_grobid_output.rng). Vous pouvez recopier (en adaptant le chemin) les lignes suivantes (à placer entre les lignes 1 et 2)

```xml
<?xml-model href="../../_schemas/schema_grobid_output.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="../../_schemas/schema_grobid_output.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
```

**Attention**: le contenu de `titleStmt/title` va servir à fabriquer les xml:id des `<item>`. Il doit donc correspondre au code du document.

3. Une fois le fichier XML corrigé, appliquer la feuille de style [`_transformations/step_2.xsl`](https://github.com/katabase/GROBID_Dictionaries/blob/master/_transformations/step_2.xsl) (scénario `step_2`).

4. Modifier les liens des schémas et, désormais, utiliser [`_schemas/odd_editiones.rng`](https://github.com/katabase/GROBID_Dictionaries/blob/master/_schemas/odd_editiones.rng)


---
# Créer des données d'entraînement

## CPDF

Pour créer les données d'entraînement, il nous faut des pdf. Choisissons 8 pages pour le _train_ et 2 pages pour le _test_ pour faire deux pdf distincts.

1. Découper le pdf en images

```
./cpdf -split PATH-TO.pdf -o PATH-TO-OUTPUT/%%%.pdf
```

par exemple:

```
./cpdf -split /Users/gabaysimon/Documents/Grobid/cpdf/cpdf-binaries-master/OSX-Intel/1879_02_15_ETI.pdf -o /Users/gabaysimon/Documents/Grobid/cpdf/cpdf-binaries-master/OSX-Intel/cata%%.pdf
```

2. Recomposer un pdf avec quelques images

```
./cpdf -merge -i image1.pdf image2.pdf image3.pdf -o result.pdf

```

par exemple:

```
./cpdf -merge /Users/gabaysimon/Documents/Grobid/cpdf/cpdf-binaries-master/OSX-Intel/cata09.pdf /Users/gabaysimon/Documents/Grobid/cpdf/cpdf-binaries-master/OSX-Intel/cata10.pdf -o train.pdf
```

## Entraîner le premier niveau (`dictionary-segmentation`)

0. Synchroniser son dossier avec le container docker

1. Placer les PDF dans `dictionary-segmentation/corpus/pdf`. Cette localisation n'est pas imposée par GROBID: il suffira d'ajuster le chemin plus tard dans les commandes (cf §2 juste _infra_).

2. Créer les données d'entraînement

```
java -jar /grobid/grobid-dictionaries/target/grobid-dictionaries-0.5.4-SNAPSHOT.one-jar.jar -dIn resources/dataset/dictionary-segmentation/corpus/pdf/  -dOut resources -exe createTrainingDictionarySegmentation
```

3. Les fichiers sont générés dans `toyData`.  Il faut désormais annoter les documents en TEI en mode auteur avec les balises `<headnote>` et `<body>`.

4. Les replacer dans le(s) fichier(s) de train dans `dictionary-segmentation/corpus/tei` pour le `.xml` et `dictionary-segmentation/corpus/raw` pour `.rawtext` et `.training.dictionarySegmentation`.  Faire de même pour le(s) fichier(s) de test dans `dictionary-segmentation/evaluation`

5. Lancer l'entraînement du niveau:

```
mvn generate-resources -P train_dictionary_segmentation -e
```

## Entraîner un deuxième niveau (`dictionary-body-segmentation`)


1. Créer les données d'entraînement

```
java -jar /grobid/grobid-dictionaries/target/grobid-dictionaries-0.5.4-SNAPSHOT.one-jar.jar -dIn resources/dataset/dictionary-segmentation/corpus/pdf/  -dOut resources -exe createTrainingDictionaryBodySegmentation
```

2. Les fichiers sont générés dans `toyData`.  Il faut désormais annoter les documents en TEI en mode auteur avec la balise `<entry>`

3. Les replacer dans le(s) fichier(s) de train dans `dictionary-body-segmentation/corpus/tei` pour le `.xml` et `dictionary-segmentation/corpus/raw` pour `.rawtext` et `.training.dictionarySegmentation`.  Faire de même pour le(s) fichier(s) de test dans `dictionary-body-segmentation/evaluation`

4. Lancer l'entraînement du niveau:

```
mvn generate-resources -P train_dictionary_body_segmentation -e
```

## Entraîner un troisième niveau (`lexical-entry`)


1. Créer les données d'entraînement

```
java -jar /grobid/grobid-dictionaries/target/grobid-dictionaries-0.5.4-SNAPSHOT.one-jar.jar -dIn resources/dataset/dictionary-segmentation/corpus/pdf/  -dOut resources -exe createTrainingLexicalEntry
```

2. Les fichiers sont générés dans `toyData`.  Il faut désormais annoter les documents en TEI en mode auteur avec les balises `<lemma>` et `<sense>`

3. Les replacer dans le(s) fichier(s) de train dans `lexical-entry/corpus/tei` pour le `.xml` et `lexical-entry/corpus/raw` pour `.rawtext` et `.training.dictionarySegmentation`.  Faire de même pour le(s) fichier(s) de test dans `lexical-entry/evaluation`

4. Lancer l'entraînement du niveau:

```
mvn generate-resources -P train_lexicalEntries -e
```

## Entraîner un quatrième niveau (`form`)


1. Créer les données d'entraînement

```
java -jar /grobid/grobid-dictionaries/target/grobid-dictionaries-0.5.4-SNAPSHOT.one-jar.jar -dIn resources/dataset/dictionary-segmentation/corpus/pdf/ -dOut resources -exe createTrainingForm
```

2. Les fichiers sont générés dans `toyData`.  Il faut désormais annoter les documents en TEI en mode auteur avec les balises `<name>` et `<desc>`

3. Les replacer dans le(s) fichier(s) de train dans `form/corpus/tei` pour le `.xml` et `form/corpus/raw` pour `.rawtext` et `.training.dictionarySegmentation`.  Faire de même pour le(s) fichier(s) de test dans `form/evaluation`

4. Lancer l'entraînement du niveau:

```
mvn generate-resources -P train_form -e
```

## Entraîner un cinquième niveau (`sense`)


1. Créer les données d'entraînement

```
java -jar /grobid/grobid-dictionaries/target/grobid-dictionaries-0.5.4-SNAPSHOT.one-jar.jar -dIn resources/dataset/dictionary-segmentation/corpus/pdf/ -dOut resources -exe createTrainingSense
```

2. Les fichiers sont générés dans `toyData`.  Il faut désormais annoter les documents en TEI en mode auteur avec les balises `<subSense>` et `<note>`

3. Les replacer dans le(s) fichier(s) de train dans `sense/corpus/tei` pour le `.xml` et `sense/corpus/raw` pour `.rawtext` et `.training.dictionarySegmentation`.  Faire de même pour le(s) fichier(s) de test dans `sense/evaluation`

4. Lancer l'entraînement du niveau:

```
mvn generate-resources -P train_sense -e
```





