<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
			     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			     xmlns:uml="http://schema.omg.org/spec/UML/2.4"
			     xmlns:xmi="http://www.omg.org/spec/XMI/2.1"
			     xmlns:euml="http://www.eclipse.org/uml2/5.0.0/UML"
			     xmlns:exmi="http://www.omg.org/XMI">

<xsl:template match="/euml:Model">
  <xmi:XMI xmi:version="2.1">
    <uml:Model xmi:type='uml:Model'>
      <xsl:attribute name="name">
	<xsl:value-of select="@name" />
      </xsl:attribute>
      <xsl:apply-templates select="packagedElement" />
    </uml:Model>
  </xmi:XMI>
</xsl:template>

<xsl:template match="packagedElement">
  <packagedElement>
    <xsl:variable name="id">//<xsl:value-of select="@name" /></xsl:variable>
    <xsl:attribute name="xmi:type">
      <xsl:value-of select="@xsi:type" />
    </xsl:attribute>
    <xsl:attribute name="xmi:id">
      <xsl:value-of select="$id" />
    </xsl:attribute>
    <xsl:attribute name="name">
      <xsl:value-of select="@name" />
    </xsl:attribute>
    <xsl:apply-templates select="region">
      <xsl:with-param name="parentId" select="$id" />
    </xsl:apply-templates>
  </packagedElement>
</xsl:template>

<xsl:template match="region">
  <xsl:param name="parentId" />
  <xsl:variable name="elementPosition"><xsl:number count="region" /></xsl:variable>
  <xsl:variable name="id"><xsl:value-of select="$parentId" />/@region.<xsl:value-of select="$elementPosition - 1" /></xsl:variable>
  <region xmi:type="uml:Region">
    <xsl:attribute name="xmi:id">
      <xsl:value-of select="$id" />
    </xsl:attribute>
    <xsl:apply-templates select="subvertex">
      <xsl:with-param name="parentId" select="$id" />
    </xsl:apply-templates>
    <xsl:apply-templates select="transition">
      <xsl:with-param name="parentId" select="$id" />
    </xsl:apply-templates>
  </region>
</xsl:template>

<xsl:template match="subvertex[@name]">
  <xsl:param name="parentId" />
  <xsl:variable name="id"><xsl:value-of select="$parentId" />/<xsl:value-of select="@name" /></xsl:variable>
  <subvertex>
    <xsl:attribute name="xmi:type">
      <xsl:value-of select="@xsi:type" />
    </xsl:attribute>
    <xsl:attribute name="xmi:id">
      <xsl:value-of select="$id" />
    </xsl:attribute>
    <xsl:attribute name="name">
      <xsl:value-of select="@name" />
    </xsl:attribute>
    <xsl:if test="@kind">
      <xsl:attribute name="kind">
	<xsl:value-of select="@kind" />
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates select="region">
      <xsl:with-param name="parentId" select="$id" />
    </xsl:apply-templates>
    <xsl:apply-templates select="doActivity" />
  </subvertex>
</xsl:template>

<xsl:template match="subvertex[not(@name)]">
  <xsl:param name="parentId" />
  <xsl:variable name="elementPosition"><xsl:number count="subvertex" /></xsl:variable>
  <xsl:variable name="id"><xsl:value-of select="$parentId" />/@subvertex.<xsl:value-of select="$elementPosition - 1" /></xsl:variable>
  <subvertex>
    <xsl:attribute name="xmi:type">
      <xsl:value-of select="@xsi:type" />
    </xsl:attribute>
    <xsl:attribute name="xmi:id">
      <xsl:value-of select="$id" />
    </xsl:attribute>
    <xsl:if test="@kind">
      <xsl:attribute name="kind">
	<xsl:value-of select="@kind" />
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates select="region">
      <xsl:with-param name="parentId" select="$id" />
    </xsl:apply-templates>
    <xsl:apply-templates select="doActivity" />
  </subvertex>
</xsl:template>

<xsl:template match="doActivity">
  <doActivity>
    <xsl:attribute name="xmi:type">
      <xsl:value-of select="@xsi:type" />
    </xsl:attribute>
    <xsl:attribute name="name">
      <xsl:value-of select="@name" />
    </xsl:attribute>
  </doActivity>
</xsl:template>

<xsl:template match="transition">
  <xsl:param name="parentId" />
  <xsl:variable name="elementPosition"><xsl:number count="transition" /></xsl:variable>
  <xsl:variable name="id"><xsl:value-of select="$parentId" />/@transition.<xsl:value-of select="$elementPosition - 1" /></xsl:variable>
  <transition xmi:type="uml:Transition">
    <xsl:attribute name="xmi:id">
      <xsl:value-of select="$id" />
    </xsl:attribute>
    <xsl:attribute name="source">
      <xsl:value-of select="@source" />
    </xsl:attribute>
    <xsl:attribute name="target">
      <xsl:value-of select="@target" />
    </xsl:attribute>
    <xsl:if test="@guard">
      <xsl:attribute name="guard">
	<xsl:value-of select="@guard" />
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates select="effect" />
    <xsl:apply-templates select="ownedRule">
      <xsl:with-param name="parentId" select="$id" />
    </xsl:apply-templates>
    <xsl:apply-templates select="trigger" />
  </transition>
</xsl:template>

<xsl:template match="effect">
  <effect>
    <xsl:attribute name="xmi:type">
      <xsl:value-of select="@xsi:type" />
    </xsl:attribute>
    <xsl:attribute name="name">
      <xsl:value-of select="@name" />
    </xsl:attribute>
  </effect>
</xsl:template>

<xsl:template match="ownedRule">
  <xsl:param name="parentId" />
  <xsl:variable name="elementPosition"><xsl:number count="ownedRule" /></xsl:variable>
  <xsl:variable name="id"><xsl:value-of select="$parentId" />/@ownedRule.<xsl:value-of select="$elementPosition - 1" /></xsl:variable>
  <ownedRule xmi:type="uml:Constraint">
    <xsl:attribute name="xmi:id">
      <xsl:value-of select="$id" />
    </xsl:attribute>
    <xsl:apply-templates select="specification" />
  </ownedRule>
</xsl:template>

<xsl:template match="specification">
  <specification>
    <xsl:attribute name="xmi:type">
      <xsl:value-of select="@xsi:type" />
    </xsl:attribute>
    <xsl:copy-of select="body" />
  </specification>
</xsl:template>

<xsl:template match="trigger">
  <trigger xmi:type="uml:Trigger">
    <xsl:attribute name="name">
      <xsl:value-of select="@name" />
    </xsl:attribute>
  </trigger>
</xsl:template>

</xsl:transform>
