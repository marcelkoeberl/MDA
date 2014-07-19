<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								xmlns:xmi="http://www.omg.org/spec/XMI/20110701"
								xmlns:MagicDraw_Profile="http://www.omg.org/spec/UML/20110701/MagicDrawProfile"
								exclude-result-prefixes="MagicDraw_Profile">
<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@*|*">
		<xsl:copy>
			<xsl:apply-templates select="@*|*"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="xmi:Extension | xmi:Documentation | ownedComment | MagicDraw_Profile:DiagramInfo" />
	
	
	
</xsl:stylesheet>