# katabase/GROBID_Dictionaries

---

## Using _GROBID-dictionaries_ to encode manuscripts sale catalogs

_GROBID-dictionaries_ is a machine-learning software that automatically encod in XML-TEI lexical and encyclopedic-like resources.

The steps to install _GROBID-dictionaries_, create new models and train already existing ones to process documents can be found [here](https://github.com/MedKhem/grobid-dictionaries/wiki/Docker_Instructions9).

A general model was developed for automatically encoding manuscripts sale catalogs. It can be downloaded from [this repository](https://github.com/lairaines/grobid_TEI_2019). The training data are extracted from the following catalogs and periodical issues:
+ Gabriel Charavay, _Revue des Autographes_, first series : 25, 35, 42, 50, 60, 70, 80, 87, 95, 116, 137.
+ Gabrielle Charavay _Revue des Autographes_, second series : 24, 56.
+ Auguste Laverdet, _Catalogue de lettres autographes et manuscrits_ : 1, 22.
+ Etienne Charavay, _Catalogue d’une intéressante collection de lettres autographes…_ (14 décembre 1908).

This general model gives satisfying results for all types of manuscripts sale catalogs likely to be processed (fixed-prices or auction catalogs). However, restraining at certain levels the training data that are used can provide even more accurate results and reduce the inaccuracies that need to be corrected by hand.

Choosing the data set you are going to train _GROBID-dictionaries_ with depends on the type and the layout of the series of documents you want to process.

## When choose the train set `trainingData_RDA_LAD`?

**If you process fixed-prices cataloges and their layout is the same as the _Revue des autographes_ (see below), _GROBID-dictionaries_ should be trained with the `trainingData_RDA_LAD` train set.**

<img src="https://github.com/katabase/GROBID_Dictionaries/blob/master/_images/RDA_LAD.png">

_Revue des autographes_, Gabriel Charavay. (Première série N°42, Decembre 1874)

<br/>The train set contains at every level data extracted only from different issues of the _Revue des Autographes_ (25, 35, 50, 80 of the first series / 24, 56 of the second series).

## When choose the train set `trainingData_OTHER_FIXED_PRICES`?

**If you process fixed-prices cataloges but their layout is not as structured as the _Revue des autographes_ (see below), _GROBID-dictionaries_ should be trained with the `trainingData_OTHER_FIXED_PRICES` train set**.

<img src="https://github.com/katabase/GROBID_Dictionaries/blob/master/_images/OTHER_FIXED_PRICES.png">

_Catalogue de lettres autographes et manuscrits_, Auguste Laverdet (N°1, April 1856.)

<br/>The train set contains at dictionary body segnentation level data extracted only from different issues of Auguste Laverdet's fixed-prices catalogs (issue 1 and issue 22). For the following levels, it contains the same data as the general model.

## When choose the train set `trainingData_AUCTION`?

**If you process auction cataloges but with no indication of prices, _GROBID-dictionaries_ should be trained with the `trainingData_AUCTION` train set**.

<img src="https://github.com/katabase/GROBID_Dictionaries/blob/master/_images/AUCTION.png">

_Catalogue d’une intéressante collection de lettres autographes…_, Noël Charavay (December, 14th 1908)

<br/>The train set contains at dictionary body segnentation level data extracted only from a catalogue published by Etienne Charavay concerning an auctions sale that took place on December, 14th 1908. For the following levels, it contains the same data as the general model.

## User guide

The protocol is described in detail in our [user guide](https://github.com/katabase/GROBID_Dictionaries/blob/master/DOCUMENTATION.md).

## Examples / Data to play with

You can find in some pdf to test our modesl in the [`_example_examples`](https://github.com/katabase/GROBID_Dictionaries/blob/master/DOCUMENTATION.md) folder.


## Credits

_GROBID-dictionaries_ is developed by Mohamed Khemakhem ([GitHub](https://github.com/MedKhem)). More info on _GROBID_ technologies can be found [here](https://grobid.readthedocs.io).

## Licence

Regarding _GROBID-dictionaries_, cf. [here](https://github.com/MedKhem/grobid-dictionaries).

Regarding the corpus: extracted data is CC-BY.

<a rel="license" href="https://creativecommons.org/licenses/by/2.0"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/2.0/88x31.png" /></a><br />

## Cite this dataset

A first version as been presetend at the TEI conference.  If you use these data, please cite this paper:

```
@inproceedings{rondeaudunoyer:hal-02272962,
  AUTHOR = {Rondeau Du Noyer, Lucie and Gabay, Simon and Khemakhem, Mohamed and Romary, Laurent},
  TITLE = {Scaling up Automatic Structuring of Manuscript Sales Catalogues},
  ADDRESS = {Graz, Austria},
  MONTH = Sep,
  YEAR = {2019},
  BOOKTITLE = {TEI 2019: What is text, really? TEI and beyond},
  KEYWORDS = {Machine learning ; Manuscript sales catalogues ; 19th c. France},
  URL = {https://hal.inria.fr/hal-02272962},
  PDF = {https://hal.inria.fr/hal-02272962/file/Grobid%20Catalogues%20TEI%202019.pdf},
  HAL_ID = {hal-02272962},
  HAL_VERSION = {v1},
}
```


