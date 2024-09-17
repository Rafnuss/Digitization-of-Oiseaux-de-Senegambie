# Digitalization of A Bird Atlas of Kenya

Raphaël Nussbaumer<sup>1,2,[![](https://figshare.com/ndownloader/files/8439032/preview/8439032/preview.jpg)](http://orcid.org/0000-0002-8185-1020)</sup>

<sup>1</sup>Swiss Ornithological Institute, Sempach, Switzerland
<sup>2</sup>A Rocha Kenya, Watamu, Kenya

**Corresponding author**: Raphaël Nussbaumer ([raphael.nussbaumer@vogelwarche.ch](mailto:raphael.nussbaumer@vogelwarche.ch))

---

[![DOI:10.15468/2ga3wk](https://zenodo.org/badge/DOI/10.15468/2ga3wk.svg)](https://doi.org/10.15468/2ga3wk)

<div data-badge-popover="right" data-badge-type="1" data-doi="10.15468/2ga3wk" data-condensed="true" data-hide-no-mentions="true" class="altmetric-embed"></div>

[![licensebuttons by-nc](https://licensebuttons.net/l/by-nc/3.0/88x31.png)](https://creativecommons.org/licenses/by-nc/4.0)

**Keywords:** africa; senegal; gambia; bird; atlas; nest; presence; distribution; long-term; change; map; Occurrence; Observation

## Description

This dataset contains the digitized bird atlas data from "Les oiseaux de Sénégambie" (Morel & Morel, 1990).

Presented as an update of "Liste commentée des oiseaux du Sénégal et de la Gambie" (Morel, 1972) et complétée en 1980).

The data consists of the presence data for all species and degree grid cells in Senegal and Gambia up to 19??.

The book contains informations on the number of nest found by species (by months), but we did not include this data here.

Wether a species was uniquely observed by sight or weather at least one specimen have been collected (typically at the Richard-Toll station) is indicated with an asterick in the book and included as the variable `` in this dataset.

**Geographical coverage:** Covering all of the Republic of Senegal and Republic of The Gambia, using degree grid cells (1°x1°). On this geographic system, this dataset covers 32 squares. See the [coverage map]() for more details.

**Taxonomic coverage:** All 623 bird species (_aves sp._) recorded in Senegal and Gambia.

The book follow the taxonomy adopted by White (1960-1965). In the book, the authors also mention the scientific name used by BANNERMAN (1953) when they differ but we did not include those names, nor the french name. While the data preserves the original common and scientific names (as `originalNameUsage`), the `scientificName` uses the GBIF Backbone Taxonomy.

In general, the book precise the subspecies in particular condition (only this subspecies occurs in the region, species previously lumped as subspecies, when subspecies is identifiable).

In this data we only provide data, we used the scientific name provieded in the table of content (no subspecies) with the expection of:

- _Egretta garzetta gularis_
- _Cuculus canorus canorus_ and _Cuculus canorus gularis_
- _Hirundo rustica rustica_ and _Hirundo rustica lucida_
- _Motacilla alba alba_ and _Motacilla alba vidua_

chaque espèce reconnue est accompagnée d'une curte de distribution; les espèces douteuses
en sont donc ciépourvues. Dans le cas des "Iormes" considérées tantôt sous-espèces
tantôt espèces selon les auteurs, nous n'avons fourni deux cartes distinctes que lorsque
nous avions assez cie données sOres pour les deux populations.

**Temporal coverage:** 1900-01-01 / 1984-12-31 ????

## Sampling Methods

See Morel & Morel (1990) for information on sampling of the original data. See step description below for the digitisation of the data.

### Study Extent

See Morel & Morel (1990) for information on the study extent of the original data. Here, we describe only the digitisation of the data. We follow as closely as possible the extent of the data provided in the book. (1) We report all species mentioned in the book and followed their taxonomy (even for species which have since been split or lumped). (2) We report the spatial information at the grid square level providing the original QDGC name (locality), the square as polygon (footprintWKT) and centre of the square (decimalLatitude, decimalLongitude). (3) We report the atlas code (presence, probable and confirmed) as given in the book at the square level. Note that we are not able to provide the atlas code for the pre-atlas period if the post-atlas period has a greater or equal atlas code (data not provided in the book).

### Quality Control

See Morel & Morel (1990) for information on the quality control of the original data. We describe here only the digitisation of the data. We considered the book as the reference, and thus manually checked that the digitised data matches the maps of the book. To perform this validation, we generated the same maps as the book based on the digitised data and visually compared them to the original map to check for discrepancy. In the absence of map in the book, we checked the square code provided in the book. Additionally, we used the gbif data-validator before the upload (https://www.gbif.org/tools/data-validator).

### Step Description

1. The base spreadsheet was recovered by Colin Jackson and contains most of the data from the book with some modifications, losses and additions. The source of this document remains unknown.
2. We removed all data dating from after the atlas project.
3. We converted the data from a text description to a standardised column (date-atlas code).
4. We changed the species name to the name used in the book (both common and scientific names).
5. We added the data from the missing species (e.g., species without a map).
6. We reverted back any species split/lumped/removed since then.
7. Finally, we manually checked the data with the book (see quality control)
8. We exported the data in Darwin core standard with the code: https://github.com/Rafnuss/Digitization-of-A-Bird-Atlas-of-Kenya

![image](https://user-images.githubusercontent.com/7571260/161981966-ce19656c-b712-493c-a053-a767e3fe49ef.png)

## Bibliographic Citations

Morel, G. J., & Morel, M. Y. (1990). Les oiseaux de Sénégambie: notices et cartes de distribution. IRD Editions.

Morel, G. J. (1972). Liste commentée des oiseaux du Sénégal et de la Gambie. Office de la recherche scientifique et technique outre-mer, Centre ORSTOM de Dakar.

Morel, G. J., & Morel, M. Y. (1982). Dates de reproduction des oiseaux de Sénégambie. Bonn. Zoo/. Beitr 33 249-268.

## How to cite?

>
