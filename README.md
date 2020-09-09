`geneName` Package
================

## GitHub Documents

This package provides functions to convert human and mouse gene synonyms
to gene names; and mouse gene names to human homologous genes.

## Examples

Here is an example data frame including gene names in one column:

|    V3 | Gene name | V5          |
| ----: | :-------- | :---------- |
| 15041 | AP5Z1     | rs397704705 |
| 15043 | ZNF592    | rs150829393 |
| 15044 | FOXRED1   | rs267606829 |
| 15679 | ICK       | rs118203918 |
| 16772 | KIF1BP    | rs121434514 |
| 21227 | YARS      | rs121908833 |
| 23208 | KARS      | rs267607194 |
| 23505 | AARS      | rs267606621 |

`gnameconverter` function converts gene synonyms (if any) in the
selected column to gene names. This makes it easier to transform gene
synonyms to gene names even when the column contains a mixture of gene
synonyms and gene names. This function can also be used to be sure all
elements are gene names and there is no gene synonym in the table.
Output is the same data table with all other columns preserved.

## Usage

``` r
df<-gnameConverter(example, "Gene name")
```

| Gene name |    V3 | V5          |
| :-------- | ----: | :---------- |
| AARS1     | 23505 | rs267606621 |
| AP5Z1     | 15041 | rs397704705 |
| FOXRED1   | 15044 | rs267606829 |
| CILK1     | 15679 | rs118203918 |
| KARS1     | 23208 | rs267607194 |
| KIFBP     | 16772 | rs121434514 |
| YARS1     | 21227 | rs121908833 |
| ZNF592    | 15043 | rs150829393 |
