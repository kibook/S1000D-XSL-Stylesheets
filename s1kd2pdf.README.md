NAME
====

s1kd2pdf - Create a PDF from S1000D data

SYNOPSIS
========

    s1kd2pdf [-s <XSL>] [-d <XSL>] [-o <out>] [-DFSh?] <src> [<param>...]

DESCRIPTION
===========

The *s1kd2pdf* command will create a PDF from S1000D data modules or
publications using the S1000D XSL Stylesheets, xsltproc, and Apache FOP.

OPTIONS
=======

-D  
Generate template XSLT for a custom DocBook-to-FO stylesheet (-d).

-d &lt;XSL&gt;  
Use a custom stylesheet for DocBook-to-FO conversion.

-F  
Output the generated XSL-FO instead of a PDF.

-o &lt;out&gt;  
Output to &lt;out&gt; instead of &lt;src&gt;.pdf (or &lt;src&gt;.fo if
the -F option is used).

-S  
Generate template XSLT for a custom S1000D-to-DocBook stylesheet (-s).

-s &lt;XSL&gt;  
Use a custom stylesheet for S1000D-to-DocBook conversion.

&lt;src&gt;  
Source S1000D module to create a PDF from.

&lt;param&gt;...  
xsltproc parameters to pass to both stylesheets.

Adding customizations to the stylesheets
----------------------------------------

To add project-specific customizations to the PDF output:

1.  Use the -D/-S options to create a template XSLT file which imports
    the installed default stylesheets.

2.  Add customizations to this file.

3.  Use the -d/-s options to apply this custom stylesheet.

Example:

    $ s1kd2pdf -S > custom.xsl

    <?xml version="1.0"?>
    <xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    <xsl:import href="/path/to/original/stylesheet.xsl"/>

    <!-- Present verbatimText type vs51 as green. -->
    <xsl:template match="verbatimText[@verbatimStyle = 'vs51']">
    <fo:inline color="green">
    <xsl:apply-imports/>
    </fo:inline>
    </xsl:template>

    </xsl:stylesheet>

    $ s1kd2pdf -s custom.xsl ...

PARAMETERS
==========

The following parameters can be supplied at the end of the command with
the -param or -stringparam flags to customize the PDF output:

auto.expand.acronyms  
Choose how to expand acronyms:

-   "no" - Only show the term

-   "before" - Show the definition followed by the term in parentheses
    (default)

-   "after" - Show the term followed by the definition in parentheses

bridgehead.in.toc  
Whether to include default headings in each data module's TOC.

data.module.index  
Include an index section in each data module.

date.time  
When set, add the "Printed $date.time" statement to the left margin.

definition.list.term.width  
Width of the term column in a definition list.

double.sided  
Whether to use alternating headers/footers for double-sided printing.

end.of.data.module.position  
Where to present the "End of data module" statement.

end.of.text  
How the text of the "End of data module" statement is determined.

external.pub.ref.inline  
How external publication references are presented.

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

front.matter.info.codes  
Descriptive data modules with any of these info codes are presented as
front matter.

generate.display.text  
If set to "0", display text for applicability annotations that have none
will not be automatically generated, and no annotation will be displayed
on elements referencing it.

generate.highlights  
Generate a Highlights section when encountering a descriptive data
module with info code 00U.

generate.index  
Generate an index when encountering a descriptive data module with info
code 014.

generate.list.of.datamodules  
Generate a List of effective data modules when encountering a
descriptive data module with info code 00S.

generate.list.of.illustrations  
Generate a List of illustrations when encountering a descriptive data
module with info code 00A.

generate.list.of.tables  
Generate a List of tables when encountering a descriptive data module
with info code 00Z.

generate.table.of.contents  
Generate a Table of contents when encountering a descriptive data module
with info code 009.

generate.title.page  
Generate a Title page when encountering a descriptive data module with
info code 001.

generated.hierarchical.toc.indent  
The indentation of each level of the hierarchical table of contents.

header.show.security  
Whether to show the security statement in the header.

hide.deleted.content  
-   "0" - Present "deleted" content as struck-through.

-   "1" - Hide "deleted" content.

hide.empty.proced.rqmts  
Hide empty tables in the preliminary requirements section.

hide.empty.refs.table  
Hide the References table if it is empty.

hierarchical.table.of.contents  
Generate a hierarchical table of contents.

highlight.applic  
Highlight applicability statements by colouring them blue.

include.pmentry.bookmarks  
Include pmEntry levels and titles in the PDF bookmarks.

include.title.in.toc  
Whether and how to include the data module title in the data module's
TOC.

index.type  
What kind of index to generate.

part.no.prefix  
Prefix part numbers with the text "Part No."

printedin.blurb  
When set, adds a "Printed in" statement after the "Published by"
statement, indicating the country the document was produced in.

printedin.blurb.before  
The text between the "Produced by" and the "Printed in" statements.

producedby.blurb  
Set the "Produced by" statement for the whole publication manually,
rather than deriving it from each data module's responsible partner
company.

producedby.blurb.before  
The text label of the "Produced by" statement.

producedby.blurb.on.titlepage  
Whether or not to show the "Produced by" statement on the title page.
Often this can be redundant as the title page also includes the name of
the producer.

publication.code  
Set the publication code manually instead of using the one derived from
the publication module.

quantity.decimal.format  
The format to use when presenting quantity values.

quantity.format  
The picture string passed to format-number() when reformat.quantities =
custom.

reformat.quantities  
Controls whether and how quantities are reformatted for presentation.

running.pagination  
Whether to use normal or running pagination.

running.pagination  
Whether to use normal or running pagination.

show.content.applic  
Whether content applicability annotations are shown.

-   "0" - Do not show content applicability annotations

-   "1" - Show content applicability annotations (default)

show.graphic.icn  
Whether to show the ICN below a graphic.

show.schema.heading  
Whether to include the default heading related to the S1000D schema of a
data module.

show.unclassified  
Whether to show the text "UNCLASSIFIED" when a document is not
classified.

simple.info.codes  
Descriptive data modules with these info codes will be presented with a
minimal stylesheet, without the standard lists, tables, or headings.

title.fontset  
Default font for titles.

title.page.illustration  
Product illustration to show on the title page. Can be used to provide
an illustration when the title page is generated with a descriptive DM
placeholder (as opposed to a frontmatter DM) or to override the
illustration specified in a frontmatter title page DM.

title.page.issue.date  
Show the issue date of the publication module on the generated title
page.

title.page.publisher  
Show the responsible partner company on the generated title page.

titled.labelled.para.toc  
Include "labelled paras" besides levelledPara in the data module's TOC.
For example, steps with titles.

toc.section.depth  
The depth of each data module's TOC.

ulink.footnotes  
Whether to present external publication hyperlinks as footnotes.

ulink.show  
Whether to show external publication hyperlinks inline.

use.unparsed.entity.uri  
Use the unparsed entity URI to resolve an ICN reference rather than the
InfoEntityResolver and info-entity-map concept.

want.inwork.blurb  
Whether to include a statement in the left margin when a data module is
a draft issue.

want.producedby.blurb  
Whether to include the "Produced by" statement in the left margin.

EXAMPLE
=======

    $ s1kd2pdf -o test.pdf test.xml -param show.unclassified 0
