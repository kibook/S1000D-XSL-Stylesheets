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

  <xsl:template match="dmodule[contains(@xsi:noNamespaceSchemaLocation, 'crew.xsd')]">
    <xsl:element name="chapter">
      <xsl:attribute name="xml:id">
        <xsl:text>ID_</xsl:text>
        <xsl:call-template name="get.dmcode"/>
      </xsl:attribute>
      <xsl:variable name="info.code">
        <xsl:call-template name="get.infocode"/>
      </xsl:variable>
      <xsl:apply-templates select="identAndStatusSection"/>
      <xsl:call-template name="content.refs"/>
      <xsl:apply-templates select="content/crew"/>
    </xsl:element>    
  </xsl:template>

  <xsl:template match="crew">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="descrCrew">
    <xsl:if test="$show.schema.heading != 0">
      <bridgehead renderas="centerhead">Crew/operator description</bridgehead>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="crewRefCard">
    <xsl:if test="not(title) and $show.schema.heading != 0">
      <bridgehead renderas="centerhead">Operation</bridgehead>
    </xsl:if>
    <xsl:apply-templates select="*"/>
  </xsl:template>

  <xsl:template match="crewRefCard/title">
    <bridgehead renderas="centerhead">
      <xsl:apply-templates/>
    </bridgehead>
  </xsl:template>

  <xsl:template match="crewDrill|subCrewDrill">
    <xsl:apply-templates select="*"/>
  </xsl:template>

  <xsl:template match="crewDrill/title">
    <bridgehead renderas="centerhead">
      <xsl:apply-templates/>
    </bridgehead>
  </xsl:template>

  <xsl:template match="subCrewDrill/title">
    <bridgehead renderas="sidehead0">
      <xsl:apply-templates/>
    </bridgehead>
  </xsl:template>

  <xsl:template match="crewDrillStep">
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
        <xsl:if test="title">
          <fo:block keep-with-next="always">
            <xsl:apply-templates select="title"/>
          </fo:block>
        </xsl:if>
        <xsl:variable name="con">
          <xsl:call-template name="applic.annotation"/>
          <xsl:apply-templates select="@warningRefs"/>
          <xsl:apply-templates select="@cautionRefs"/>
          <xsl:apply-templates select="*[not(self::crewDrillStep or self::title)]"/>
        </xsl:variable>
        <xsl:if test="$con != ''">
          <fo:block>
            <xsl:copy-of select="$con"/>
          </fo:block>
        </xsl:if>
      </xsl:with-param>
      <xsl:with-param name="title" select="title"/>
    </xsl:call-template>
    <xsl:apply-templates select="crewDrillStep"/>
  </xsl:template>

  <xsl:template match="crewDrillStep|if|elseIf|case" mode="number">
    <xsl:number count="crewDrillStep|if|elseIf|case" from="crewDrill" level="multiple"/>
  </xsl:template>

  <xsl:template match="crewDrillStep/title">
    <fo:block xsl:use-attribute-sets="step.title.level1.properties">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <xsl:template match="crewDrillStep/crewDrillStep/title">
    <fo:block xsl:use-attribute-sets="step.title.level2.properties">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <xsl:template match="crewDrillStep/crewDrillStep/crewDrillStep/title">
    <fo:block xsl:use-attribute-sets="step.title.level3.properties">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <xsl:template match="crewDrillStep/crewDrillStep/crewDrillStep/crewDrillStep/title">
    <fo:block xsl:use-attribute-sets="step.title.level4.properties">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>
  <xsl:template match="crewDrillStep/crewDrillStep/crewDrillStep/crewDrillStep/crewDrillStep/title">
    <fo:block xsl:use-attribute-sets="step.title.level5.properties">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="crewDrillStep" mode="label">
    <fo:block xsl:use-attribute-sets="step.title.level1.properties">
      <xsl:apply-templates select="." mode="number"/>
    </fo:block>
  </xsl:template>
  <xsl:template match="crewDrillStep/crewDrillStep" mode="label">
    <fo:block xsl:use-attribute-sets="step.title.level2.properties">
      <xsl:apply-templates select="." mode="number"/>
    </fo:block>
  </xsl:template>
  <xsl:template match="crewDrillStep/crewDrillStep/crewDrillStep" mode="label">
    <fo:block xsl:use-attribute-sets="step.title.level3.properties">
      <xsl:apply-templates select="." mode="number"/>
    </fo:block>
  </xsl:template>
  <xsl:template match="crewDrillStep/crewDrillStep/procedurapStep/crewDrillStep" mode="label">
    <fo:block xsl:use-attribute-sets="step.title.level4.properties">
      <xsl:apply-templates select="." mode="number"/>
    </fo:block>
  </xsl:template>
  <xsl:template match="crewDrillStep/crewDrillStep/crewDrillStep/crewDrillStep/crewDrillStep" mode="label">
    <fo:block xsl:use-attribute-sets="step.title.level5.properties">
      <xsl:apply-templates select="." mode="number"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="if|elseIf|case">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="caseCond">
    <xsl:call-template name="labelled.para">
      <xsl:with-param name="label">
        <xsl:apply-templates select="parent::*" mode="number"/>
      </xsl:with-param>
      <xsl:with-param name="content">
        <emphasis role="italic">
          <xsl:choose>
            <xsl:when test="parent::if">If </xsl:when>
            <xsl:when test="parent::elseIf">Else if </xsl:when>
            <xsl:when test="parent::case">Case </xsl:when>
          </xsl:choose>
          <xsl:apply-templates/>
          <xsl:text>:</xsl:text>
        </emphasis>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="challengeAndResponse">
    <fo:table start-indent="10mm" table-layout="fixed" width="100%">
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell text-align="left" text-align-last="justify">
            <fo:block>
              <xsl:apply-templates select="challenge/para/node()"/>
              <fo:leader>
                <xsl:attribute name="leader-pattern">
                  <xsl:apply-templates select="parent::crewDrillStep/@separatorStyle"/>
                </xsl:attribute>
              </fo:leader>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block start-indent="0pt">
              <xsl:apply-templates select="response"/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template match="@separatorStyle">
    <xsl:choose>
      <xsl:when test=". = 'dot'">dots</xsl:when>
      <xsl:when test=". = 'line'">rule</xsl:when>
      <xsl:when test=". = 'none'">space</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="challenge|response">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="endMatter">
    <xsl:apply-templates select="*"/>
  </xsl:template>

  <xsl:template match="crewProcedureName">
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
