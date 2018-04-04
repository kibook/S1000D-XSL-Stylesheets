<?xml version="1.0" encoding="UTF-8"?>

<!-- ********************************************************************

     This file is part of the S1000D XSL stylesheet distribution.
     
     Copyright (C) 2010-2011 Smart Avionics Ltd.
     
     See ../COPYING for copyright details and other information.

     ******************************************************************** -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">

  <xsl:attribute-set name="step.title.level1.properties">
    <xsl:attribute name="font-size">14pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="step.title.level2.properties">
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="step.title.level3.properties">
    <xsl:attribute name="font-size">10pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="step.title.level4.properties">
    <xsl:attribute name="font-size">10pt</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="step.title.level5.properties">
    <xsl:attribute name="font-size">10pt</xsl:attribute>
    <xsl:attribute name="font-style">italic</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="dmodule[contains(@xsi:noNamespaceSchemaLocation, 'proced.xsd')]">
    <xsl:element name="chapter">
      <xsl:attribute name="xml:id">
        <xsl:text>ID_</xsl:text>
	      <xsl:call-template name="get.dmcode"/>
      </xsl:attribute>
      <xsl:apply-templates select="identAndStatusSection"/>
      <xsl:call-template name="content.refs"/>
      <xsl:apply-templates select="content/procedure"/>
    </xsl:element>    
  </xsl:template>

  <xsl:template match="procedure">
    <xsl:choose>
      <xsl:when test="$hide.empty.proced.rqmts = 0">
        <xsl:apply-templates select="*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="commonInfo"/>
        <xsl:apply-templates select="preliminaryRqmts[
          reqCondGroup[not(noConds)] or
          reqPersons or
          reqSupportEquips[not(noSupportEquips)] or
          reqSupplies[not(noSupplies)] or
          reqSpares[not(noSpares)]]"/>
        <xsl:apply-templates select="mainProcedure"/>
        <xsl:apply-templates select="closeRqmts[reqCondGroup[not(noConds)]]"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="mainProcedure">
    <xsl:if test="$show.schema.heading != 0">
      <bridgehead renderas="centerhead">Procedure</bridgehead>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="proceduralStep/title">
    <fo:block xsl:use-attribute-sets="step.title.level1.properties">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <xsl:template match="proceduralStep/proceduralStep/title">
    <fo:block xsl:use-attribute-sets="step.title.level2.properties">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <xsl:template match="proceduralStep/proceduralStep/proceduralStep/title">
    <fo:block xsl:use-attribute-sets="step.title.level3.properties">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <xsl:template match="proceduralStep/proceduralStep/proceduralStep/proceduralStep/title">
    <fo:block xsl:use-attribute-sets="step.title.level4.properties">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <xsl:template match="proceduralStep/proceduralStep/proceduralStep/proceduralStep/proceduralStep/title">
    <fo:block xsl:use-attribute-sets="step.title.level5.properties">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="proceduralStep" mode="label">
    <fo:block xsl:use-attribute-sets="step.title.level1.properties">
      <xsl:apply-templates select="." mode="number"/>
    </fo:block>
  </xsl:template>
  <xsl:template match="proceduralStep/proceduralStep" mode="label">
    <fo:block xsl:use-attribute-sets="step.title.level2.properties">
      <xsl:apply-templates select="." mode="number"/>
    </fo:block>
  </xsl:template>
  <xsl:template match="proceduralStep/proceduralStep/proceduralStep" mode="label">
    <fo:block xsl:use-attribute-sets="step.title.level3.properties">
      <xsl:apply-templates select="." mode="number"/>
    </fo:block>
  </xsl:template>
  <xsl:template match="proceduralStep/proceduralStep/procedurapStep/proceduralStep" mode="label">
    <fo:block xsl:use-attribute-sets="step.title.level4.properties">
      <xsl:apply-templates select="." mode="number"/>
    </fo:block>
  </xsl:template>
  <xsl:template match="proceduralStep/proceduralStep/proceduralStep/proceduralStep/proceduralStep" mode="label">
    <fo:block xsl:use-attribute-sets="step.title.level5.properties">
      <xsl:apply-templates select="." mode="number"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="proceduralStep">
    <xsl:call-template name="labelled.para">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="title">
            <xsl:apply-templates select="." mode="label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="." mode="number"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="content">
        <fo:block keep-with-next="always">
          <xsl:apply-templates select="title"/>
        </fo:block>
        <fo:block>
          <xsl:call-template name="make.applic.annotation"/>
          <xsl:apply-templates select="@warningRefs|@cautionRefs"/>
          <xsl:apply-templates select="*[not(self::proceduralStep or self::title)]"/>
        </fo:block>
      </xsl:with-param>
      <xsl:with-param name="title">
        <xsl:apply-templates select="title" mode="labeltitle"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates select="proceduralStep"/>
  </xsl:template>

  <xsl:template match="proceduralStep/title" mode="labeltitle">
    <xsl:apply-templates/>
  </xsl:template>

  <!--<xsl:template match="proceduralStep/para">
    <xsl:choose>
      <xsl:when test="position() = 1">
	<xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
	<para><xsl:apply-templates/></para>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->

</xsl:stylesheet>
