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
  xmlns:fox="http://xml.apache.org/fop/extensions"
  version="1.0">

  <xsl:template match="d:part|d:chapter|d:sect1|d:sect2|d:sect3|d:sect4|d:sect5|d:section" mode="bookmark">
    <xsl:variable name="id">
      <xsl:choose>
        <!-- pmEntry (part) bookmarks link to first data module (chapter) -->
        <xsl:when test="self::d:part">
          <xsl:call-template name="object.id">
            <xsl:with-param name="object" select="descendant::d:chapter[1]"/>
          </xsl:call-template>
        </xsl:when>
        <!-- all other element bookmarks link to the element itself -->
        <xsl:otherwise>
          <xsl:call-template name="object.id"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="bookmark-label">
      <xsl:call-template name="bookmark.label"/>
    </xsl:variable>
    <xsl:if test="$bookmark-label != ''">
      <fo:bookmark internal-destination="{$id}" xsl:exclude-result-prefixes="d fox l" starting-state="{$bookmarks.state}">
        <fo:bookmark-title>
          <xsl:value-of select="normalize-space($bookmark-label)"/>
        </fo:bookmark-title>
        <xsl:apply-templates select="*" mode="bookmark"/>
      </fo:bookmark>
    </xsl:if>
  </xsl:template>

  <!-- Do not show empty bookmark for book element -->
  <xsl:template match="d:book" mode="bookmark">
    <xsl:apply-templates select="*" mode="bookmark"/>
  </xsl:template>

</xsl:stylesheet>
