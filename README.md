# Digitalization of Les oiseaux de Sénégambie <img src="https://github.com/user-attachments/assets/9b6fc04c-a2a7-48b8-9a18-2a591f01fdad" align="right" height="400"/>

Raphaël Nussbaumer<sup>1,2</sup>

<sup>1</sup>Swiss Ornithological Institute, Sempach, Switzerland
<sup>2</sup>A Rocha Kenya, Watamu, Kenya

**Corresponding author**: Raphaël Nussbaumer ([raphael.nussbaumer@vogelwarche.ch](mailto:raphael.nussbaumer@vogelwarche.ch))

---

**Keywords:** africa; senegal; gambia; bird; atlas; nest; presence; distribution; long-term; change; map; Occurrence; Observation

## Description

This dataset contains the digitized bird atlas data from "Les oiseaux de Sénégambie" (Morel & Morel, 1990). The data consists of the presence data for all species and adegree grid cells in Senegal and Gambia seperatly up to 19??. The book presents itself as an update of "Liste commentée des oiseaux du Sénégal et de la Gambie" (Morel, 1972) and (Morel, 1980). The book contains informations on the number of nest found by species (by months), but we did not include this data here. Wether a species was uniquely observed by sight or weather at least one specimen have been collected (typically at the Richard-Toll station) is indicated with an asterick in the book and included as the variable `` in this dataset.

The book can be found on [worldcat.org](https://search.worldcat.org/title/1392421968) or consulted on this [webpage](https://horizon.documentation.ird.fr/exl-doc/pleins_textes/divers20-07/31877.pdf).


**Geographical coverage:** Covering all of the Republic of Senegal and Republic of The Gambia, using degree grid cells (1°x1°). On this geographic system, this dataset covers 32 "squares". 

<img src="https://github.com/Rafnuss/Digitization-of-Oiseaux-de-Senegambie/blob/main/data/geometry/intersection_map.png?raw=true" alt="Intersection Map" style="height:400px;">

_See [`data/geometry/grid.geojson`](https://github.com/Rafnuss/Digitization-of-Oiseaux-de-Senegambie/blob/main/data/geometry/grid.geojson) for more details_

**Taxonomic coverage:** All 623 bird species (_aves sp._) recorded in Senegal and Gambia at the time. The book follow the taxonomy adopted by White (1960-1965). In the book, the authors also mention the scientific name used by Bannerman (1953) when they differ but we did not include those names, nor the french name. While the data preserves the original scientific names as `originalNameUsage`, we additionally provide the `scientificName` which matches the GBIF Backbone Taxonomy.

In general, the book precise the subspecies in the species account detail, but only in some particular condition:  this subspecies occurs in the region, species previously lumped as subspecies, when subspecies is identifiable. In this dataset we used the scientific name provided in the table of content (i.e., subspecies). Four subspecies are provided as seperate maps, but they have since then be splitted as different species in the GBIF Backbone Taxonomy: 

- _Egretta garzetta gularis_ -> _Egretta gularis_
- _Cuculus canorus canorus_ and _Cuculus canorus gularis_ -> _Cuculus gularis_
- _Hirundo rustica rustica_ and _Hirundo rustica lucida_ -> _Hirundo lucida_
- _Motacilla alba alba_ and _Motacilla alba vidua_ -> _Motacilla aguimp (vidua)_

In addition, several doubful species are mentioned in the book but without map. We did not include these species as no spatial information is available. 

**Temporal coverage:** 1900-01-01 / 1984-12-31 ????

## Sampling Methods

See Morel & Morel (1990) for information on sampling of the original data. See step description below for the digitisation of the data.

### Study Extent

See Morel & Morel (1990) for information on the study extent of the original data. Here, we describe only the digitisation of the data. We follow as closely as possible the extent of the data provided in the book. 

- We report all species mentioned in the book and followed their taxonomy as close as possible while still respecting the GBIF Backbone Taxonomy.
- We report the spatial information at the grid square level providing a user friendly `locality` name (e.g., `square_Gambia_lat13.5N_lon15.5E`), the exact polygon 
 (degree square - intersecting country boundary) as `footprintWKT` and centre of the square (`decimalLatitude`, `decimalLongitude`).

### Quality Control

See Morel & Morel (1990) for information on the quality control of the original data. We describe here only the digitisation of the data. We considered the book as the reference, and thus manually checked that the digitised data matches the maps of the book. To perform this validation, we generated the same maps as the book based on the digitised data and visually compared them to the original map to check for discrepancy. Additionally, we used the gbif data-validator before the upload (https://www.gbif.org/tools/data-validator).

### Step Description

1. We digitaized the book using `script_digitilize.m`
2. We removed th
3. We converted the data from a text description to a standardised column (date-atlas code).
4. We changed the species name to the name used in the book (both common and scientific names).
5. We added the data from the missing species (e.g., species without a map).
6. We reverted back any species split/lumped/removed since then.
7. Finally, we manually checked the data with the book (see quality control)
8. We exported the data in Darwin core standard with `script_gbif.m`


<img src="https://github.com/user-attachments/assets/6b1ecc6e-d98a-4806-a4fd-4c793f6c82ce" alt="Intersection Map" style="height:400px;">

_Example of the digitalization_

## Bibliographic Citations

Morel, G. J., & Morel, M. Y. (1990). Les oiseaux de Sénégambie: notices et cartes de distribution. IRD Editions.

Morel, G. J. (1972). Liste commentée des oiseaux du Sénégal et de la Gambie. ORSTOM. Dakar.

Morel, G. J. (1980). Liste commentée des oiseaux du Sénégal et de la Gambie, Supplément n°1. ORSTOM. Dakar.


## How to cite?

>
