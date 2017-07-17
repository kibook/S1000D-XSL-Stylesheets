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
      <xsl:apply-templates select="identAndStatusSection">
        <xsl:with-param name="show.producedby.blurb">
          <xsl:choose>
            <!-- Don't show "Produced by" blurb on title page since it's already displayed under Publisher -->
            <xsl:when test="content/frontMatter/frontMatterTitlePage">no</xsl:when>
            <xsl:otherwise><xsl:value-of select="$want.producedby.blurb"/></xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:apply-templates>
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

</xsl:stylesheet>
