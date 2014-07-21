<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								xmlns:xmi="http://www.omg.org/spec/XMI/20110701"
								xmlns:MagicDraw_Profile="http://www.omg.org/spec/UML/20110701/MagicDrawProfile"
								xmlns:uml="http://www.omg.org/spec/UML/20110701"
								xmlns:euml="http://www.eclupse.org/uml2/5.0.0/UML"
								exclude-result-prefixes="uml">
<xsl:output method="xml" indent="yes"/>

	<xsl:template match="xmi:XMI">
		<xmi:XMI xmlns:euml="http://www.eclipse.org/uml2/5.0.0/UML">
			<xsl:apply-templates selet="*"/>
		</xmi:XMI>
	</xsl:template>

	<xsl:template match="*">
		<xsl:choose>
			<xsl:when test="starts-with(name(),'uml')">
				<xsl:element name="{concat('e',name())}">
					<xsl:apply-templates select="@*|*"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="{name()}">
					<xsl:apply-templates select="@*|*"/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="@*">
		<xsl:attribute name="{name()}">
			<xsl:choose>
				<xsl:when test="starts-with(.,'uml')">
					<xsl:value-of select="concat('e',.)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:template>
	
	<xsl:template match="xmi:Extension | xmi:Documentation | ownedComment | MagicDraw_Profile:DiagramInfo | body" />
	
	
	
</xsl:stylesheet>