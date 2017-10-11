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
  xmlns:rx="http://www.renderx.com/XSL/Extensions" version="1.0">
  
  <!-- lists ********************************************************** -->
  
  <xsl:template name="next.itemsymbol">
    <xsl:param name="itemsymbol" select="'default'"/>
    <xsl:choose>
      <!-- Change this list if you want to change the order of symbols -->
      <xsl:when test="$itemsymbol = 'endash'">disc</xsl:when>
      <xsl:when test="$itemsymbol = 'disc'">endash</xsl:when>
      <xsl:otherwise>endash</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="itemizedlist.label.markup">
    <xsl:param name="itemsymbol" select="'disc'"/>

    <xsl:choose>
      <xsl:when test="$itemsymbol='none'"></xsl:when>
      <xsl:when test="$itemsymbol='disc'">&#x2022;</xsl:when>
      <xsl:when test="$itemsymbol='bullet'">&#x2022;</xsl:when>
      <xsl:when test="$itemsymbol='endash'">&#x2013;</xsl:when>
      <xsl:when test="$itemsymbol='emdash'">&#x2014;</xsl:when>
      <xsl:when test="$itemsymbol='square'">&#x25A0;</xsl:when>
      <xsl:when test="$itemsymbol='box'">&#x25A0;</xsl:when>
      <xsl:when test="$itemsymbol='smallblacksquare'">&#x25AA;</xsl:when>
      <xsl:when test="$itemsymbol='circle'">&#x25CB;</xsl:when>
      <xsl:when test="$itemsymbol='opencircle'">&#x25CB;</xsl:when>
      <xsl:when test="$itemsymbol='whitesquare'">&#x25A1;</xsl:when>
      <xsl:when test="$itemsymbol='smallwhitesquare'">&#x25AB;</xsl:when>
      <xsl:when test="$itemsymbol='round'">&#x25CF;</xsl:when>
      <xsl:when test="$itemsymbol='blackcircle'">&#x25CF;</xsl:when>
      <xsl:when test="$itemsymbol='whitebullet'">&#x25E6;</xsl:when>
      <xsl:when test="$itemsymbol='triangle'">&#x2023;</xsl:when>
      <xsl:when test="$itemsymbol='point'">&#x203A;</xsl:when>
      <xsl:when test="$itemsymbol='hand'"><fo:inline 
                           font-family="Wingdings 2">A</fo:inline></xsl:when>
      <xsl:otherwise>&#x2022;</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="next.numeration">
    <xsl:param name="numeration" select="'default'"/>
    <xsl:text>arabic</xsl:text>
  </xsl:template>
    
  <xsl:template match="d:orderedlist/d:listitem" mode="item-number">
    <xsl:variable name="numeration">
      <xsl:call-template name="list.numeration">
        <xsl:with-param name="node" select="parent::d:orderedlist"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="type">
      <xsl:choose>
        <xsl:when test="$numeration='arabic'">1</xsl:when>
        <xsl:when test="$numeration='loweralpha'">a</xsl:when>
        <xsl:when test="$numeration='lowerroman'">i</xsl:when>
        <xsl:when test="$numeration='upperalpha'">A</xsl:when>
        <xsl:when test="$numeration='upperroman'">I</xsl:when>
        <!-- What!? This should never happen -->
        <xsl:otherwise>
          <xsl:message>
            <xsl:text>Unexpected numeration: </xsl:text>
            <xsl:value-of select="$numeration"/>
          </xsl:message>
          <xsl:value-of select="1"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="item-number">
      <xsl:call-template name="orderedlist-item-number"/>
    </xsl:variable>

    <xsl:if
      test="ancestor::d:listitem[parent::d:orderedlist]">
      <xsl:apply-templates
        select="ancestor::d:listitem[parent::d:orderedlist][1]"
        mode="item-number"/>
      <xsl:text>.</xsl:text>
    </xsl:if>

    <xsl:number value="$item-number" format="{$type}"/>
  </xsl:template>

  <xsl:template match="d:orderedlist/d:title|d:itemizedlist/d:title" mode="list.title.mode">
    <fo:block font-weight="bold" text-align="left" space-before="8pt">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="d:variablelist/d:title" mode="list.title.mode">
    <fo:block text-align="left" font-style="italic" space-before="8pt">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>
