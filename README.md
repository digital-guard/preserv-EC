# preserv-EC
[Preservación digital](https://en.wikipedia.org/wiki/Digital_preservation) de las principales fuentes de la **base de datos AddressForAll-Ecuador**, mantenida por el [Instituto AddressForAll](http://addressforall.org/).

A Ecuador se le asignó: en el contexto ISO&nbsp;3166&#8209;2 el geocódigo **EC** y el número **218**; en Wikidata el identificador [Q736](http://wikidata.org/entity/Q736); en OpenStreetMap el identificador de [*relación* 108089](http://osm.org/relation/108089).


## Organización territorial
El territorio nacional y sus subdivisiones representam **jurisdiciones**:

* El país está dividido en **24 provincias**, que se subdividen en **221 cantones**, y estos en **1499 parroquias** urbanas y rurales.

* Los cantones están gobernados por un alcalde y un concejo elegidos. Los datos que nos interesan están a este nivel.

* Las parroquias urbanas (es decir, parte urbana de el cantón) no tienen autonomía. Las parroquias rurales son administradas por un consejo parroquial electo (a veces con un sitio web).

* Quito es tanto el Distrito Metropolitano como la capital de la provincia de Pichincha.

* El nombre del cantón puede diferir de la sede cantonal (sede de la ciudad del municipio).

Los catastros urbanos se encuentran en los cantones.

La jurisdicción que asigna nombres a las calles y el sistema de numeración urbana es el cantón.

## Organización de este repositorio

En este *git*, solo se guardan los metadatos, es decir, descriptores de entidad, como nombres y códigos geográficos &mdash; mapas y otros datos, almacenados externamente porque son muy grandes. Los metadatos se organizaron de la siguiente manera, en la carpeta [`/data`](./data):

* [`/data`](./data): datos originales de **entrada**, es decir, metadatos proporcionados para el sistema.
   * `jurisdictionLevel*.csv`:  jurisdicciones (en todos los niveles) y sus geocódigos. La primera subdivisión es [jurisdictionLevel4.csv](./data/in/jurisdictionLevel4.csv).
   * [`cl-donor.csv`](./data/in/cl-donor.csv): donantes de paquetes de datos. Metadatos de las instituciones que brindan datos oficiales. (pendente)
   * [`cl-donatedPack.csv`](./data/in/cl-donatedPack.csv): descriptores de los archivos donados. (pendente)
   * *paquetes* (carpetas `_packXX`): *hash*  y otros descriptores de archivos almacenados externamente, así como `makefile` y otros descriptores de proceso para descomprimir estos archivos y llevarlos a la base de datos (PostregSQL)... 

* [`/data/out`](./data/out): resultados generados por el sistema (**salida**), es decir, metadatos creados a partir de los algoritmos y estadísticas aplicados a los datos de `_pack`.

## Licencia
[Licencia CC0](https://creativecommons.org/publicdomain/zero/1.0/deed.es).
