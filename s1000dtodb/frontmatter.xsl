<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">

  <xsl:template match="dmodule[contains(@xsi:noNamespaceSchemaLocation, 'frontmatter.xsd')]">
    <chapter>
      <xsl:attribute name="xml:id">
        <xsl:text>ID_</xsl:text>
        <xsl:call-template name="get.dmcode"/>
      </xsl:attribute>
      <xsl:variable name="info.code">
        <xsl:call-template name="get.infocode"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$info.code = '001'">
          <xsl:apply-templates select="identAndStatusSection">
            <xsl:with-param name="show.producedby.blurb">
              <xsl:choose>
                <xsl:when test="$producedby.blurb.on.titlepage != 0">yes</xsl:when>
                <xsl:otherwise>no</xsl:otherwise>
              </xsl:choose>
            </xsl:with-param>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="identAndStatusSection"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="content/frontMatter/*"/>
    </chapter>
  </xsl:template>

  <xsl:template match="frontMatterTitlePage">
    <xsl:call-template name="title.page"/>
  </xsl:template>

  <xsl:template match="productIntroName">
    <fo:block font-size="18pt">
      <xsl:apply-templates select="name"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="productAndModel">
    <fo:block font-size="18pt">
      <xsl:apply-templates select="productName/name"/>
      <xsl:if test="productModel">
        <xsl:for-each select="productModel/modelName/name|productModel/natoStockNumber|productModel/identNumber|productModel/endItemCode">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="."/>
        </xsl:for-each>
      </xsl:if>
    </fo:block>
  </xsl:template>

  <xsl:template match="productIllustration">
    <xsl:apply-templates select="graphic">
      <xsl:with-param name="show.icn" select="0"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="frontMatterTableOfContent">
    <xsl:call-template name="table.of.content"/>
  </xsl:template>

  <xsl:template match="frontMatterList">
    <xsl:apply-templates select="reducedPara"/>
    <xsl:apply-templates select="frontMatterSubList"/>
  </xsl:template>

  <xsl:template match="frontMatterSubList">
    <informaltable pgwide="1" frame="topbot" colsep="0" rowsep="0">
      <tgroup cols="6" align="left">
        <colspec colnum="3" colwidth="1.5em" align="center"/>
        <colspec colnum="4" colwidth="6em"/>
        <colspec colnum="5" colwidth="4em"/>
        <thead rowsep="1">
          <row>
            <entry>Document title</entry>
            <entry>Data module code</entry>
            <entry></entry>
            <entry>Issue date</entry>
            <entry>
              <xsl:choose>
                <xsl:when test="$running.pagination = 0">No. of pages</xsl:when>
                <xsl:otherwise>Page</xsl:otherwise>
              </xsl:choose>
            </entry>
            <entry>Applicable to</entry>
          </row>
        </thead>
        <tbody>
          <xsl:apply-templates select="*"/>
        </tbody>
      </tgroup>
    </informaltable>
  </xsl:template>

  <xsl:template match="frontMatterDmEntry">
    <xsl:apply-templates select="dmRef" mode="lodm"/>
  </xsl:template>

</xsl:stylesheet>
