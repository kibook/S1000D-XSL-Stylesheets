<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://docbook.org/ns/docbook"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  version="1.0">

  <!-- This file contains templates for elements with project configurable
       attribute values, defined in Chap 3.9.6.1 of the S1000D Issue 4.2 spec.

       Since these are more likely to be customized by a project, they are
       placed separately from the other templates. -->

  <!-- inlineSignificantData: significantParaDataType

       "psd01"          Ammunition
       "psd02"          Instruction disposition
       "psd03"          Lubricant
       "psd04"          Maintenance level
       "psd05"          Manufacturer code
       "psd06"          Manufacturers recommendation
       "psd07"          Modification code
       "psd08"          Qualification code
       "psd09"          Training level
       "psd10"          Control or indicator value
       "psd51"-"psd99"  Available for projects -->
  <xsl:template match="inlineSignificantData">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- emphasis: emphasisType

       "em01"         Bold (default)
       "em02"         Italic
       "em03"         Underline
       "em04"         Overline
       "em05"         Strikethrough
       "em51"-"em99"  Available for projects -->
  <xsl:template match="emphasis">
    <xsl:element name="emphasis">
      <xsl:attribute name="role">
        <xsl:choose>
          <xsl:when test="@emphasisType = 'em02'">italic</xsl:when>
          <xsl:when test="@emphasisType = 'em03'">underline</xsl:when>
          <xsl:when test="@emphasisType = 'em04'">overline</xsl:when>
          <xsl:when test="@emphasisType = 'em05'">strikethrough</xsl:when>
          <xsl:otherwise>bold</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

  <!-- verbatimText: verbatimStyle

       "vs01"         Generic verbatim (default)
       "vs02"         Filename
       "vs11"         XML/SGML markup
       "vs12"         XML/SGML element name
       "vs13"         XML/SGML attribute name
       "vs14"         XML/SGML attribute value
       "vs15"         XML/SGML entity name
       "vs16"         XML/SGML processing instruction
       "vs21"         Program prompt
       "vs22"         User input
       "vs23"         Computer output
       "vs24"         Program listing
       "vs25"         Program variable name
       "vs26"         Program variable value
       "vs27"         Constant
       "vs28"         Class name
       "vs29"         Parameter name
       "vs51"-"vs99"  Available for projects -->
  <xsl:template match="verbatimText">
    <xsl:choose>
      <!-- Block verbatim text types -->
      <xsl:when test="@verbatimStyle = 'vs11'">
        <programlisting>
          <xsl:call-template name="revisionflag"/>
          <xsl:apply-templates/>
        </programlisting>
      </xsl:when>
      <xsl:when test="@verbatimStyle = 'vs23'">
        <screen>
          <xsl:call-template name="revisionflag"/>
          <xsl:apply-templates/>
        </screen>
      </xsl:when>
      <xsl:when test="@verbatimStyle = 'vs24'">
        <programlisting>
          <xsl:call-template name="revisionflag"/>
          <xsl:apply-templates/>
        </programlisting>
      </xsl:when>
      <!-- Inline verbatim text types -->
      <xsl:otherwise>
        <phrase>
          <xsl:call-template name="revisionflag"/>
          <literal>
            <xsl:apply-templates/>
          </literal>
        </phrase>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- caption: color

       "co00"         None
       "co01"         Green
       "co02"         Amber
       "co03"         Yellow
       "co04"         Red
       "co07"         White
       "co08"         Grey
       "co09"         Clear (default)
       "co10"         Black
       "co51"-"co99"  Available for projects -->
  <xsl:template match="@color">
    <xsl:choose>
      <xsl:when test=". = 'co01'">#00FF00</xsl:when>
      <xsl:when test=". = 'co02'">#FF9900</xsl:when>
      <xsl:when test=". = 'co03'">#FFFF00</xsl:when>
      <xsl:when test=". = 'co04'">#FF0000</xsl:when>
      <xsl:when test=". = 'co07'">#FFFFFF</xsl:when>
      <xsl:when test=". = 'co08'">#CCCCCC</xsl:when>
      <xsl:when test=". = 'co10'">#000000</xsl:when>
      <xsl:otherwise>inherit</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="@color" mode="text.color">
    <xsl:choose>
      <xsl:when test=". = 'co04'">#FFFFFF</xsl:when>
      <xsl:when test=". = 'co10'">#FFFFFF</xsl:when>
      <xsl:otherwise>inherit</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- quantityUnitOfMeasure

       Determines the display of each of the standard UoM.

       "um51"-"um99" are also available for projects. -->
  <xsl:template match="@quantityUnitOfMeasure">
    <xsl:choose>
      <xsl:when test=". = '%'">%</xsl:when>
      <xsl:when test=". = '(dyne/cm)4/gcm3'"> (dyne/cm)<superscript>4</superscript>/gcm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = '(N/m)4/kg.m3'"> (N/m)<superscript>4</superscript>/kg.m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = '1/a'">/a</xsl:when>
      <xsl:when test=". = '1/angstrom'">/angstrom</xsl:when>
      <xsl:when test=". = '1/bar'">/bar</xsl:when>
      <xsl:when test=". = '1/bbl'">/bbl</xsl:when>
      <xsl:when test=". = '1/cm'">/cm</xsl:when>
      <xsl:when test=". = '1/d'">/d</xsl:when>
      <xsl:when test=". = '1/degC'">/°C</xsl:when>
      <xsl:when test=". = '1/degF'">/°F</xsl:when>
      <xsl:when test=". = '1/degR'">/°R</xsl:when>
      <xsl:when test=". = '1/ft'">/ft</xsl:when>
      <xsl:when test=". = '1/ft2'">/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = '1/ft3'">/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = '1/g'">/g</xsl:when>
      <xsl:when test=". = '1/galUK'">/galUK</xsl:when>
      <xsl:when test=". = '1/galUS'">/galUS</xsl:when>
      <xsl:when test=". = '1/H'"> H<superscript>-1</superscript></xsl:when>
      <xsl:when test=". = '1/h'">/h</xsl:when>
      <xsl:when test=". = '1/in'">/in</xsl:when>
      <xsl:when test=". = '1/K'">/K</xsl:when>
      <xsl:when test=". = '1/kg'">/kg</xsl:when>
      <xsl:when test=". = '1/km2'">/km<superscript>2</superscript></xsl:when>
      <xsl:when test=". = '1/kPa'">/kPa</xsl:when>
      <xsl:when test=". = '1/L'">/L</xsl:when>
      <xsl:when test=". = '1/lbf'">/lbf</xsl:when>
      <xsl:when test=". = '1/lbm'">/lbm</xsl:when>
      <xsl:when test=". = '1/m'">/m</xsl:when>
      <xsl:when test=". = '1/m2'">/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = '1/m3'">/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = '1/mi'">/mi</xsl:when>
      <xsl:when test=". = '1/mi2'">/mi<superscript>2</superscript></xsl:when>
      <xsl:when test=". = '1/min'">/min</xsl:when>
      <xsl:when test=". = '1/mm'">/mm</xsl:when>
      <xsl:when test=". = '1/N'">/N</xsl:when>
      <xsl:when test=". = '1/nm'">/nm</xsl:when>
      <xsl:when test=". = '1/Pa'">/Pa</xsl:when>
      <xsl:when test=". = '1/pPa'">/pPa</xsl:when>
      <xsl:when test=". = '1/psi'">/psi</xsl:when>
      <xsl:when test=". = '1/s'">/s</xsl:when>
      <xsl:when test=". = '1/upsi'">/upsi</xsl:when>
      <xsl:when test=". = '1/uV'">/uV</xsl:when>
      <xsl:when test=". = '1/V'">/V</xsl:when>
      <xsl:when test=". = '1/wk'">/wk</xsl:when>
      <xsl:when test=". = '1/yd'">/yd</xsl:when>
      <xsl:when test=". = '1000ft3'"> 1000ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = '1000ft3/bbl'"> 1000ft<superscript>3</superscript>/bbl</xsl:when>
      <xsl:when test=". = '1000ft3/d'"> 1000ft<superscript>3</superscript>/d</xsl:when>
      <xsl:when test=". = '1000ft3/d.ft'"> 1000ft<superscript>3</superscript>/d.ft</xsl:when>
      <xsl:when test=". = '1000ft3/psi.d'"> 1000ft<superscript>3</superscript>/psi.d</xsl:when>
      <xsl:when test=". = '1000m3/d'"> 1000m<superscript>3</superscript>/d</xsl:when>
      <xsl:when test=". = '1000m3/d.m'"> 1000m<superscript>3</superscript>/d.m</xsl:when>
      <xsl:when test=". = '1000m3/h'"> 1000m<superscript>3</superscript>/h</xsl:when>
      <xsl:when test=". = '1000m3/h.m'"> 1000m<superscript>3</superscript>/h.m</xsl:when>
      <xsl:when test=". = '1000m4/d'"> 1000m<superscript>4</superscript>/d</xsl:when>
      <xsl:when test=". = '10Mg/m3'"> 10Mg/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'A.m2'"> A.m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'A/cm2'"> A/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'A/ft2'"> A/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'A/m2'"> A/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'A/mm2'"> A/mm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'b/cm3'"> b/cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'bar2'"> bar<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'bar2/cP'"> bar<superscript>2</superscript>/cP</xsl:when>
      <xsl:when test=". = 'bbl/d2'"> bbl/d<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'bbl/ft3'"> bbl/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'bbl/hr2'"> bbl/hr<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'bbl/k(ft3)'"> bbl/k(ft<superscript>3</superscript>)</xsl:when>
      <xsl:when test=". = 'bbl/M(ft3)'"> bbl/M(ft<superscript>3</superscript>)</xsl:when>
      <xsl:when test=". = 'Btu.in/hr.ft2.F'"> Btu.in/hr.ft<superscript>2</superscript>.F</xsl:when>
      <xsl:when test=". = 'Btu/ft3'"> Btu/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'Btu/hr.ft2'"> Btu/hr.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'Btu/hr.ft2.degF'"> Btu/hr ft<superscript>2</superscript> °F</xsl:when>
      <xsl:when test=". = 'Btu/hr.ft2.degR'"> Btu/hr ft<superscript>2</superscript> °R</xsl:when>
      <xsl:when test=". = 'Btu/hr.ft3'"> Btu/hr.ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'Btu/hr.ft3.degF'"> Btu/hr ft<superscript>3</superscript> °F</xsl:when>
      <xsl:when test=". = 'Btu/hr.m2.degC'"> Btu/hr m<superscript>2</superscript> °CC</xsl:when>
      <xsl:when test=". = 'Btu/s.ft2'"> Btu/s.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'Btu/s.ft2.degF'"> Btu/s.ft<superscript>2</superscript> °F</xsl:when>
      <xsl:when test=". = 'Btu/s.ft3'"> Btu/s.ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'Btu/s.ft3.degF'"> Btu/s.ft<superscript>3</superscript> °F</xsl:when>
      <xsl:when test=". = 'C/cm2'"> C/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'C/cm3'"> C/cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'C/m2'"> C/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'C/m3'"> C/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'C/mm2'"> C/mm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'C/mm3'"> C/mm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'cal/cm3'"> cal/cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'cal/h.cm2'"> cal/h.cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'cal/h.cm2.degC'"> cal/h.cm<superscript>2</superscript> °C</xsl:when>
      <xsl:when test=". = 'cal/h.cm3'"> cal/h.cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'cal/mm3'"> cal/mm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'cal/s.cm2.degC'"> cal/s.cm<superscript>2</superscript> °C</xsl:when>
      <xsl:when test=". = 'cal/s.cm3'"> cal/s.cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'cd/m2'"> cd/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'cm/s2'"> cm/s<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'cm2'"> cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'cm2/g'"> cm<superscript>2</superscript>/g</xsl:when>
      <xsl:when test=". = 'cm2/s'"> cm<superscript>2</superscript>/s</xsl:when>
      <xsl:when test=". = 'cm3'"> cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'cm3/30min'"> cm<superscript>3</superscript>/30min</xsl:when>
      <xsl:when test=". = 'cm3/cm3'"> cm<superscript>3</superscript>/cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'cm3/g'"> cm<superscript>3</superscript>/g</xsl:when>
      <xsl:when test=". = 'cm3/h'"> cm<superscript>3</superscript>/h</xsl:when>
      <xsl:when test=". = 'cm3/m3'"> cm<superscript>3</superscript>/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'cm3/min'"> cm<superscript>3</superscript>/min</xsl:when>
      <xsl:when test=". = 'cm3/s'"> cm<superscript>3</superscript>/s</xsl:when>
      <xsl:when test=". = 'cm4'"> cm<superscript>4</superscript></xsl:when>
      <xsl:when test=". = 'd/ft3'"> d/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'd/k(ft3)'"> d/k(ft<superscript>3</superscript>)</xsl:when>
      <xsl:when test=". = 'd/m3'"> d/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'dega'">°</xsl:when>
      <xsl:when test=". = 'degC'"> °C</xsl:when>
      <xsl:when test=". = 'degC.m2.h/kcal'"> °C.m<superscript>2</superscript>.h/kcal</xsl:when>
      <xsl:when test=". = 'degF'"> °F</xsl:when>
      <xsl:when test=". = 'degF.ft2.h/Btu'"> °F.ft<superscript>2</superscript>.h/Btu</xsl:when>
      <xsl:when test=". = 'degR'"> °R</xsl:when>
      <xsl:when test=". = 'dm3'"> dm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'dm3/100km'"> dm<superscript>3</superscript>/100km</xsl:when>
      <xsl:when test=". = 'dm3/kg'"> dm<superscript>3</superscript>/kg</xsl:when>
      <xsl:when test=". = 'dm3/km(100)'"> dm<superscript>3</superscript>/km(100)</xsl:when>
      <xsl:when test=". = 'dm3/kW.h'"> dm<superscript>3</superscript>/kW.h</xsl:when>
      <xsl:when test=". = 'dm3/m'"> dm<superscript>3</superscript>/m</xsl:when>
      <xsl:when test=". = 'dm3/m3'"> dm<superscript>3</superscript>/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'dm3/MJ'"> dm<superscript>3</superscript>/MJ</xsl:when>
      <xsl:when test=". = 'dm3/mol(kg)'"> dm<superscript>3</superscript>/mol(kg)</xsl:when>
      <xsl:when test=". = 'dm3/s'"> dm<superscript>3</superscript>/s</xsl:when>
      <xsl:when test=". = 'dm3/s2'"> dm<superscript>3</superscript>/s<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'dm3/t'"> dm<superscript>3</superscript>/t</xsl:when>
      <xsl:when test=". = 'dyne.cm2'"> dyne.cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'dyne.s/cm2'"> dyne.s/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'dyne/cm2'"> dyne/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'eq/m3'"> eq/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'erg/cm2'"> erg/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'erg/cm3'"> erg/cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'erg/m3'"> erg/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'ft/ft3'"> ft/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'ft/s2'"> ft/s<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ft2'"> ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ft2/h'"> ft<superscript>2</superscript>/h</xsl:when>
      <xsl:when test=". = 'ft2/in3'"> ft<superscript>2</superscript>/in<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'ft2/s'"> ft<superscript>2</superscript>/s</xsl:when>
      <xsl:when test=". = 'ft3'"> ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'ft3(std,60F)'"> ft<superscript>3</superscript>(std,60F)</xsl:when>
      <xsl:when test=". = 'ft3/bbl'"> ft<superscript>3</superscript>/bbl</xsl:when>
      <xsl:when test=". = 'ft3/d'"> ft<superscript>3</superscript>/d</xsl:when>
      <xsl:when test=". = 'ft3/d.ft.psi'"> ft<superscript>3</superscript>/d.ft.psi</xsl:when>
      <xsl:when test=". = 'ft3/d2'"> ft<superscript>3</superscript>/d<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ft3/ft'"> ft<superscript>3</superscript>/ft</xsl:when>
      <xsl:when test=". = 'ft3/ft3'"> ft<superscript>3</superscript>/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'ft3/h'"> ft<superscript>3</superscript>/h</xsl:when>
      <xsl:when test=". = 'ft3/h2'"> ft<superscript>3</superscript>/h<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ft3/kg'"> ft<superscript>3</superscript>/kg</xsl:when>
      <xsl:when test=". = 'ft3/lbm'"> ft<superscript>3</superscript>/lbm</xsl:when>
      <xsl:when test=". = 'ft3/min'"> ft<superscript>3</superscript>/min</xsl:when>
      <xsl:when test=". = 'ft3/min.ft2'"> ft<superscript>3</superscript>/min.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ft3/min2'"> ft<superscript>3</superscript>/min<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ft3/mol(lbm)'"> ft<superscript>3</superscript>/mol(lbm)</xsl:when>
      <xsl:when test=". = 'ft3/s'"> ft<superscript>3</superscript>/s</xsl:when>
      <xsl:when test=". = 'ft3/s.ft2'"> ft<superscript>3</superscript>/s.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ft3/s2'"> ft<superscript>3</superscript>/s<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ft3/sack94'"> ft<superscript>3</superscript>/sack94</xsl:when>
      <xsl:when test=". = 'ft3/scf(60F)'"> ft<superscript>3</superscript>/scf(60F)</xsl:when>
      <xsl:when test=". = 'g.ft/cm3.s'"> g.ft/cm<superscript>3</superscript>.s</xsl:when>
      <xsl:when test=". = 'g/cm3'"> g/cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'g/cm4'"> g/cm<superscript>4</superscript></xsl:when>
      <xsl:when test=". = 'g/dm3'"> g/dm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'g/m3'"> g/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'galUK/ft3'"> galUK/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'galUK/hr.ft2'"> galUK/hr.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'galUK/hr.in2'"> galUK/hr.in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'galUK/hr2'"> galUK/hr<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'galUK/min.ft2'"> galUK/min.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'galUK/min2'"> galUK/min<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'galUS/ft3'"> galUS/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'galUS/hr.ft2'"> galUS/hr.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'galUS/hr.in2'"> galUS/hr.in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'galUS/hr2'"> galUS/hr<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'galUS/min.ft2'"> galUS/min.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'galUS/min2'"> galUS/min<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'GPa2'"> GPa<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'grain/100ft3'"> grain/100ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'grain/ft3'"> grain/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'grain/ft3(100)'"> grain/ft<superscript>3</superscript>(100)</xsl:when>
      <xsl:when test=". = 'Gsm3'"> Gsm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'h/ft3'"> h/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'h/m3'"> h/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'hhp/in2'"> hhp/in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'hp/ft3'"> hp/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'hp/in2'"> hp/in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'in2'"> in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'in2/ft2'"> in<superscript>2</superscript>/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'in2/in2'"> in<superscript>2</superscript>/in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'in2/s'"> in<superscript>2</superscript>/s</xsl:when>
      <xsl:when test=". = 'in3'"> in<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'in3/ft'"> in<superscript>3</superscript>/ft</xsl:when>
      <xsl:when test=". = 'in4'"> in<superscript>4</superscript></xsl:when>
      <xsl:when test=". = 'J/cm2'"> J/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'J/dm3'"> J/dm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'J/m2'"> J/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'J/m3'"> J/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'J/s.m2.degC'"> J/s m<superscript>2</superscript> °C</xsl:when>
      <xsl:when test=". = 'K.m2/kW'"> K.m<superscript>2</superscript>/kW</xsl:when>
      <xsl:when test=". = 'K.m2/W'"> K.m<superscript>2</superscript>/W</xsl:when>
      <xsl:when test=". = 'kcal.m/cm2'"> kcal.m/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kcal/cm3'"> kcal/cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'kcal/h.m2.degC'"> kcal/h m<superscript>2</superscript> °C</xsl:when>
      <xsl:when test=". = 'kcal/m3'"> kcal/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'kg.m/cm2'"> kg.m/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kg.m2'"> kg.m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kg/dm3'"> kg/dm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'kg/dm4'"> kg/dm<superscript>4</superscript></xsl:when>
      <xsl:when test=". = 'kg/m2'"> kg/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kg/m2.s'"> kg/m<superscript>2</superscript>.s</xsl:when>
      <xsl:when test=". = 'kg/m3'"> kg/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'kg/m4'"> kg/m<superscript>4</superscript></xsl:when>
      <xsl:when test=". = 'kgf.m/cm2'"> kgf.m/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kgf.m2'"> kgf.m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kgf.s/m2'"> kgf.s/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kgf/cm2'"> kgf/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kgf/mm2'"> kgf/mm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kJ.m/h.m2.K'"> kJ.m/h.m<superscript>2</superscript>.K</xsl:when>
      <xsl:when test=". = 'kJ/dm3'"> kJ/dm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'kJ/h.m2.K'"> kJ/h.m<superscript>2</superscript>.K</xsl:when>
      <xsl:when test=". = 'kJ/m3'"> kJ/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'km/dm3'"> km/dm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'km2'"> km<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'km3'"> km<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'kN.m2'"> kN.m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kN/m2'"> kN/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kPa2'"> kPa<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kPa2/cP'"> kPa<superscript>2</superscript>/cP</xsl:when>
      <xsl:when test=". = 'kPa2/kcP'"> kPa<superscript>2</superscript>/kcP</xsl:when>
      <xsl:when test=". = 'kpsi2'"> kpsi<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ksm3'"> ksm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'ksm3/d'"> ksm<superscript>3</superscript>/d</xsl:when>
      <xsl:when test=". = 'ksm3/sm3'"> ksm<superscript>3</superscript>/sm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'kW.h/dm3'"> kW.h/dm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'kW.h/m3'"> kW.h/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'kW/cm2'"> kW/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kW/m2'"> kW/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'kW/m2.K'"> kW/m<superscript>2</superscript>.K</xsl:when>
      <xsl:when test=". = 'kW/m3'"> kW/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'kW/m3.K'"> kW/m<superscript>3</superscript>.K</xsl:when>
      <xsl:when test=". = 'L/m3'"> L/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'L/s2'"> L/s<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbf.ft/in2'"> lbf.ft/in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbf.in2'"> lbf.in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbf.s/ft2'"> lbf.s/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbf.s/in2'"> lbf.s/in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbf/100ft2'"> lbf/100ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbf/ft2'"> lbf/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbf/ft2(100)'"> lbf/ft<superscript>2</superscript>(100)</xsl:when>
      <xsl:when test=". = 'lbf/ft3'"> lbf/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'lbf/in2'"> lbf/in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbm.ft2'"> lbm.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbm.ft2/s2'"> lbm.ft<superscript>2</superscript>/s<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbm/100ft2'"> lbm/100ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbm/ft2'"> lbm/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbm/ft3'"> lbm/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'lbm/ft4'"> lbm/ft<superscript>4</superscript></xsl:when>
      <xsl:when test=". = 'lbm/h.ft2'"> lbm/h.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lbm/in3'"> lbm/in<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'lbm/s.ft2'"> lbm/s.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'lm/m2'"> lm/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'M(ft3)'"> M(ft<superscript>3</superscript>)</xsl:when>
      <xsl:when test=". = 'M(ft3)/acre.ft'"> M(ft<superscript>3</superscript>)/acre.ft</xsl:when>
      <xsl:when test=". = 'M(ft3)/d'"> M(ft<superscript>3</superscript>)/d</xsl:when>
      <xsl:when test=". = 'M(m3)'"> M(m<superscript>3</superscript>)</xsl:when>
      <xsl:when test=". = 'M(m3)/d'"> M(m<superscript>3</superscript>)/d</xsl:when>
      <xsl:when test=". = 'm/m3'"> m/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'm/s2'"> m/s<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'm2'"> m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'm2/cm3'"> m<superscript>2</superscript>/cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'm2/d.kPa'"> m<superscript>2</superscript>/d.kPa</xsl:when>
      <xsl:when test=". = 'm2/g'"> m<superscript>2</superscript>/g</xsl:when>
      <xsl:when test=". = 'm2/h'"> m<superscript>2</superscript>/h</xsl:when>
      <xsl:when test=". = 'm2/kg'"> m<superscript>2</superscript>/kg</xsl:when>
      <xsl:when test=". = 'm2/m2'"> m<superscript>2</superscript>/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'm2/m3'"> m<superscript>2</superscript>/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'm2/mol'"> m<superscript>2</superscript>/mol</xsl:when>
      <xsl:when test=". = 'm2/Pa.s'"> m<superscript>2</superscript>/Pa.s</xsl:when>
      <xsl:when test=". = 'm2/s'"> m<superscript>2</superscript>/s</xsl:when>
      <xsl:when test=". = 'm3'"> m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'm3(std,0C)'"> m<superscript>3</superscript>(std,0C)</xsl:when>
      <xsl:when test=". = 'm3(std,15C)'"> m<superscript>3</superscript>(std,15C)</xsl:when>
      <xsl:when test=". = 'm3/bar.d'"> m<superscript>3</superscript>/bar.d</xsl:when>
      <xsl:when test=". = 'm3/bar.h'"> m<superscript>3</superscript>/bar.h</xsl:when>
      <xsl:when test=". = 'm3/bar.min'"> m<superscript>3</superscript>/bar.min</xsl:when>
      <xsl:when test=". = 'm3/cP.d.kPa'"> m<superscript>3</superscript>/cP.d.kPa</xsl:when>
      <xsl:when test=". = 'm3/cP.Pa.s'"> m<superscript>3</superscript>/cP.Pa.s</xsl:when>
      <xsl:when test=". = 'm3/d'"> m<superscript>3</superscript>/d</xsl:when>
      <xsl:when test=". = 'm3/d.kPa'"> m<superscript>3</superscript>/d.kPa</xsl:when>
      <xsl:when test=". = 'm3/d.m'"> m<superscript>3</superscript>/d.m</xsl:when>
      <xsl:when test=". = 'm3/d2'"> m<superscript>3</superscript>/d<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'm3/g'"> m<superscript>3</superscript>/g</xsl:when>
      <xsl:when test=". = 'm3/h'"> m<superscript>3</superscript>/h</xsl:when>
      <xsl:when test=". = 'm3/h.m'"> m<superscript>3</superscript>/h.m</xsl:when>
      <xsl:when test=". = 'm3/ha.m'"> m<superscript>3</superscript>/ha.m</xsl:when>
      <xsl:when test=". = 'm3/J'"> m<superscript>3</superscript>/J</xsl:when>
      <xsl:when test=". = 'm3/kg'"> m<superscript>3</superscript>/kg</xsl:when>
      <xsl:when test=". = 'm3/km'"> m<superscript>3</superscript>/km</xsl:when>
      <xsl:when test=". = 'm3/kPa.d'"> m<superscript>3</superscript>/kPa.d</xsl:when>
      <xsl:when test=". = 'm3/kPa.h'"> m<superscript>3</superscript>/kPa.h</xsl:when>
      <xsl:when test=". = 'm3/kW.h'"> m<superscript>3</superscript>/kW.h</xsl:when>
      <xsl:when test=". = 'm3/m'"> m<superscript>3</superscript>/m</xsl:when>
      <xsl:when test=". = 'm3/m2'"> m<superscript>3</superscript>/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'm3/m3'"> m<superscript>3</superscript>/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'm3/min'"> m<superscript>3</superscript>/min</xsl:when>
      <xsl:when test=". = 'm3/mol'"> m<superscript>3</superscript>/mol</xsl:when>
      <xsl:when test=". = 'm3/mol(kg)'"> m<superscript>3</superscript>/mol(kg)</xsl:when>
      <xsl:when test=". = 'm3/Pa.s'"> m<superscript>3</superscript>/Pa.s</xsl:when>
      <xsl:when test=". = 'm3/Pa/s'"> m<superscript>3</superscript>/Pa/s</xsl:when>
      <xsl:when test=". = 'm3/Pa2.s2'"> m<superscript>3</superscript>/Pa<superscript>2</superscript>.s<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'm3/psi.d'"> m<superscript>3</superscript>/psi.d</xsl:when>
      <xsl:when test=". = 'm3/s'"> m<superscript>3</superscript>/s</xsl:when>
      <xsl:when test=". = 'm3/s.ft'"> m<superscript>3</superscript>/s.ft</xsl:when>
      <xsl:when test=". = 'm3/s.m'"> m<superscript>3</superscript>/s.m</xsl:when>
      <xsl:when test=". = 'm3/s.m2'"> m<superscript>3</superscript>/s.m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'm3/s2'"> m<superscript>3</superscript>/s<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'm3/scm(0C)'"> m<superscript>3</superscript>/scm(0C)</xsl:when>
      <xsl:when test=". = 'm3/scm(15C)'"> m<superscript>3</superscript>/scm(15C)</xsl:when>
      <xsl:when test=". = 'm3/t'"> m<superscript>3</superscript>/t</xsl:when>
      <xsl:when test=". = 'm3/tonUK'"> m<superscript>3</superscript>/tonUK</xsl:when>
      <xsl:when test=". = 'm3/tonUS'"> m<superscript>3</superscript>/tonUS</xsl:when>
      <xsl:when test=". = 'm4'"> m<superscript>4</superscript></xsl:when>
      <xsl:when test=". = 'm4/s'"> m<superscript>4</superscript>/s</xsl:when>
      <xsl:when test=". = 'mA/cm2'"> mA/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mA/ft2'"> mA/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mC/m2'"> mC/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mD.ft2/lbf.s'"> mD.ft<superscript>2</superscript>/lbf.s</xsl:when>
      <xsl:when test=". = 'mD.in2/lbf.s'"> mD.in<superscript>2</superscript>/lbf.s</xsl:when>
      <xsl:when test=". = 'meq/cm3'"> meq/cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'mg/dm3'"> mg/dm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'Mg/m2'"> Mg/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'Mg/m3'"> Mg/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'mg/m3'"> mg/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'mi2'"> mi<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mi3'"> mi<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'mina'">&#x2032;</xsl:when>
      <xsl:when test=". = 'miUS2'"> miUS<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mJ/cm2'"> mJ/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mJ/m2'"> mJ/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'MJ/m3'"> MJ/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'mm2'"> mm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mm2/mm2'"> mm<superscript>2</superscript>/mm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mm2/s'"> mm<superscript>2</superscript>/s</xsl:when>
      <xsl:when test=". = 'mm3'"> mm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'mm3/J'"> mm<superscript>3</superscript>/J</xsl:when>
      <xsl:when test=". = 'mN.m2'"> mN.m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mol(kg)/m3'"> mol(kg)/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'mol(lbm)/ft3'"> mol(lbm)/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'mol(lbm)/h.ft2'"> mol(lbm)/h.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mol(lbm)/s.ft2'"> mol(lbm)/s.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mol/m2'"> mol/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'mol/m2.s'"> mol/m<superscript>2</superscript>.s</xsl:when>
      <xsl:when test=". = 'mol/m3'"> mol/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'ms/2'"> ms/<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'Msm3'"> Msm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'MW.h/m3'"> MW.h/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'mW/m2'"> mW/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'N.m'"> Nm</xsl:when>
      <xsl:when test=". = 'N.m2'"> N.m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'N.s/m2'"> N.s/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'N/m2'"> N/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'N/m3'"> N/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'N/mm2'"> N/mm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'N4/kg.m7'"> N<superscript>4</superscript>/kg.m7</xsl:when>
      <xsl:when test=". = 'Pa.s/m3'"> Pa.s/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'Pa.s2/m3'"> Pa.s<superscript>2</superscript>/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'Pa/m3'"> Pa/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'Pa2'"> Pa<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'pdl.cm2'"> pdl.cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'psi2'"> psi<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'psi2.d/cP.ft3'"> psi<superscript>2</superscript>.d/cP.ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'psi2.d/cp.ft3'"> psi<superscript>2</superscript>.d/cp.ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'psi2.d2/cP.ft6'"> psi<superscript>2</superscript>.d<superscript>2</superscript>/cP.ft<superscript>6</superscript></xsl:when>
      <xsl:when test=". = 'psi2.d2/cp.ft6'"> psi<superscript>2</superscript>.d<superscript>2</superscript>/cp.ft<superscript>6</superscript></xsl:when>
      <xsl:when test=". = 'psi2/cP'"> psi<superscript>2</superscript>/cP</xsl:when>
      <xsl:when test=". = 'rad/ft3'"> rad/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'rad/m3'"> rad/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'rad/s2'"> rad/s<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 's/ft3'"> s/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 's/m3'"> s/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'scf(60F)/ft2'"> scf(60F)/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'scf(60F)/ft3'"> scf(60F)/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'scm(0C)/m2'"> scm(0C)/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'scm(0C)/m3'"> scm(0C)/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'scm(15C)/m2'"> scm(15C)/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'scm(15C)/m3'"> scm(15C)/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'sm3/ksm3'"> sm<superscript>3</superscript>/ksm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'sm3/sm3'"> sm<superscript>3</superscript>/sm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'therm/ft3'"> therm/ft<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'tonfUK.ft2'"> tonfUK.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'tonfUK/ft2'"> tonfUK/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'tonfUS.ft2'"> tonfUS.ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'tonfUS/ft2'"> tonfUS/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'tonfUS/in2'"> tonfUS/in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'tonUS/ft2'"> tonUS/ft<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'uA/cm2'"> uA/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'uA/in2'"> uA/in<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ucal/s.cm2'"> ucal/s.cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'ug/cm3'"> ug/cm<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'um2'"> um<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'um2.m'"> um<superscript>2</superscript>.m</xsl:when>
      <xsl:when test=". = 'uW/m3'"> uW/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'W/cm2'"> W/cm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'W/m2'"> W/m<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'W/m2.K'"> W/m<superscript>2</superscript>.K</xsl:when>
      <xsl:when test=". = 'W/m2.sr'"> W/m<superscript>2</superscript>.sr</xsl:when>
      <xsl:when test=". = 'W/m3'"> W/m<superscript>3</superscript></xsl:when>
      <xsl:when test=". = 'W/m3.K'"> W/m<superscript>3</superscript>.K</xsl:when>
      <xsl:when test=". = 'W/mm2'"> W/mm<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'yd2'"> yd<superscript>2</superscript></xsl:when>
      <xsl:when test=". = 'yd3'"> yd<superscript>3</superscript></xsl:when>
      <xsl:otherwise>
        <xsl:text> </xsl:text>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- accessPointType -->
  <xsl:template match="@accessPointType">
    <xsl:choose>
      <xsl:when test=". = 'accpnl01'">door</xsl:when>
      <xsl:when test=". = 'accpnl02'">panel</xsl:when>
      <xsl:when test=". = 'accpnl03'">electrical panel</xsl:when>
      <xsl:when test=". = 'accpnl04'">hatch</xsl:when>
      <xsl:when test=". = 'accpnl05'">fillet</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="security">
    <xsl:choose>
      <xsl:when test="@securityClassification = '01'">
        <xsl:choose>
          <xsl:when test="$show.unclassified != 0">
            <xsl:text>UNCLASSIFIED</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>&#160;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>CLASSIFIED: <xsl:value-of select="@securityClassification"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
