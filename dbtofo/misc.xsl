<?xml version="1.0" encoding="UTF-8"?>

<!-- ********************************************************************

     This file is part of the S1000D XSL stylesheet distribution.
     
     Copyright (C) 2010-2011 Smart Avionics Ltd.
     
     See ../COPYING for copyright details and other information.

     ******************************************************************** -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
  xmlns:rx="http://www.renderx.com/XSL/Extensions"
  xmlns:bc="http://barcode4j.krysalis.org/ns"
  version="1.0">
  
  <!-- misc elements ***************************************************** -->

  <xsl:template match="d:emphasis[@role='overline']">
    <fo:inline text-decoration="overline" xsl:exclude-result-prefixes="d l rx">
      <xsl:call-template name="inline.charseq"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="fo:*|rx:*|bc:*">
    <xsl:element name="{name()}" namespace="{namespace-uri()}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="bookmark.label">
    <xsl:choose>
      <xsl:when test="self::d:chapter|self::d:part">
        <xsl:apply-templates select="." mode="object.title.markup"/>
        <xsl:if test="d:info/d:subtitle/text()">
          <xsl:text> - </xsl:text>
	        <xsl:apply-templates select="." mode="object.subtitle.markup"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="." mode="object.title.markup"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="d:*[@labeltitle]" mode="object.title.markup">
    <xsl:value-of select="@labeltitle"/>
  </xsl:template>

  <!-- Do not show parts -->
  <xsl:template match="d:part">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- No "Part X." on part titles -->
  <xsl:template match="d:part" mode="object.title.markup">
    <xsl:apply-templates select="d:info/d:title/text()"/>
  </xsl:template>

  <!-- No "Index" title on generated index (the dmTitle should cover this) -->
  <xsl:template name="index.titlepage"/>

  <xsl:attribute-set name="index.div.title.properties">
    <xsl:attribute name="margin-left">-20mm</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>
