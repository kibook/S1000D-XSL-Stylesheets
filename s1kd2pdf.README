NAME
====

s1kd2pdf - Create a PDF from S1000D data

SYNOPSIS
========

    s1kd2pdf [-s <XSL>] [-d <XSL>] [-o <out>] <src> [<param>...]

DESCRIPTION
===========

The *s1kd2pdf* command will create a PDF from S1000D data modules or publications using the S1000D XSL Stylesheets, xsltproc, and Apache FOP.

OPTIONS
=======

-d &lt;XSL&gt;  
Use a custom stylesheet for DocBook-to-FO conversion.

-o &lt;out&gt;  
Output to &lt;out&gt; instead of &lt;src&gt;.pdf

-s &lt;XSL&gt;  
Use a custom stylesheet for S1000D-to-DocBook conversion.

&lt;src&gt;  
Source S1000D module to create a PDF from.

&lt;param&gt;...  
xsltproc parameters to pass to both stylesheets.

PARAMETERS
==========

The following parameters can be supplied at the end of the command with the -param or -stringparam flags to customize the PDF output:

auto.expand.acronyms  
The first time an acronym is used, include the definition after it in parentheses.

data.module.index  
Include an index section in each data module.

date.time  
When set, add the "Printed $date.time" statement to the left margin.

definition.list.term.width  
Width of the term column in a definition list.

external.pub.ref.inline  
How external publication references are presented.

front.matter.info.codes  
Descriptive data modules with any of these info codes are presented as front matter.

generate.highlights  
Generate a Highlights section when encountering a descriptive data module with info code 00U.

generate.index  
Generate an index when encountering a descriptive data module with info code 014.

generate.list.of.datamodules  
Generate a List of effective data modules when encountering a descriptive data module with info code 00S.

generate.list.of.illustrations  
Generate a List of illustrations when encountering a descriptive data module with info code 00A.

generate.list.of.tables  
Generate a List of tables when encountering a descriptive data module with info code 00Z.

generate.table.of.contents  
Generate a Table of contents when encountering a descriptive data module with info code 009.

generate.title.page  
Generate a Title page when encountering a descriptive data module with info code 001.

generated.hierarchical.toc.indent  
The indentation of each level of the hierarchical table of contents.

hide.empty.proced.rqmts  
Hide the preliminary requirements section of a procedural data module if all the standard tables are empty.

hide.empty.refs.table  
Hide the References table if it is empty.

hierarchical.table.of.contents  
Generate a hierarchical table of contents.

highlight.applic  
Highlight applicability statements by colouring them blue.

include.pmentry.bookmarks  
Include pmEntry levels and titles in the PDF bookmarks.

index.type  
What kind of index to generate.

part.no.prefix  
Prefix part numbers with the text "Part No."

printedin.blurb  
When set, adds a "Printed in" statement after the "Published by" statement, indicating the country the document was produced in.

printedin.blurb.before  
The text between the "Produced by" and the "Printed in" statements.

producedby.blurb  
Set the "Produced by" statement for the whole publication manually, rather than deriving it from each data module's responsible partner company.

producedby.blurb.before  
The text label of the "Produced by" statement.

producedby.blurb.on.titlepage  
Whether or not to show the "Produced by" statement on the title page. Often this can be redundant as the title page also includes the name of the producer.

publication.code  
Set the publication code manually instead of using the one derived from the publication module.

quantity.decimal.format  
The format to use when presenting quantity values.

quantity.format  
The picture string passed to format-number() when reformat.quantities = custom.

reformat.quantities  
Controls whether and how quantities are reformatted for presentation.

running.pagination  
Whether to use normal or running pagination.

show.applicability  
Whether and how applicability statements are shown on elements.

show.graphic.icn  
Whether to show the ICN below a graphic.

show.schema.heading  
Whether to include the default heading related to the S1000D schema of a data module.

show.unclassified  
Whether to show the text "UNCLASSIFIED" when a document is not classified.

simple.info.codes  
Descriptive data modules with these info codes will be presented with a minimal stylesheet, without the standard lists, tables, or headings.

title.page.issue.date  
Show the issue date of the publication module on the generated title page.

titled.labelled.para.toc  
Include "labelled paras" besides levelledPara in the data module's TOC. For example, steps with titles.

use.unparsed.entity.uri  
Use the unparsed entity URI to resolve an ICN reference rather than the InfoEntityResolver and info-entity-map concept.

want.inwork.blurb  
Whether to include a statement in the left margin when a data module is a draft issue.

want.producedby.blurb  
Whether to include the "Produced by" statement in the left margin.

bridgehead.in.toc  
Whether to include default headings in each data module's TOC.

double.sided  
Whether to use alternating headers/footers for double-sided printing.

end.of.data.module.position  
Where to present the "End of data module" statement.

end.of.text  
How the text of the "End of data module" statement is determined.

font.family  
The default font family for all elements.

footer.show.applic  
Whether to show the "Applicability" statement in the footer.

footer.show.dmc  
Whether to show the data module code in the footer.

footer.show.end.of.data.module  
Whether to show the "End of data module" statement in the footer.

footer.show.security  
Whether to show the security statement in the footer.

footnote.font.size  
The font size of a footnote.

header.show.security  
Whether to show the security statement in the header.

include.title.in.toc  
Whether and how to include the data module title in the data module's TOC.

running.pagination  
Whether to use normal or running pagination.

title.fontset  
Default font for titles.

toc.section.depth  
The depth of each data module's TOC.

ulink.footnotes  
Whether to present external publication hyperlinks as footnotes.

ulink.show  
Whether to show external publication hyperlinks inline.

EXAMPLE
=======

    $ s1kd2pdf -o test.pdf test.xml -param show.unclassified 0
