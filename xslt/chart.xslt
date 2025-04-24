<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns="http://www.w3.org/2000/svg">
  
  <xsl:template match="/">
    <svg width="600" height="400" viewBox="0 0 600 400">
      <!-- Chart Title -->
      <text x="300" y="30" text-anchor="middle" font-size="20">
        <xsl:value-of select="dataset/title"/>
      </text>

      <!-- Y-axis Labels -->
      <text x="50" y="360" text-anchor="middle" transform="rotate(-90 50,360)" 
            font-size="12">Values</text>
      
      <!-- X-axis Labels -->
      <text x="300" y="390" text-anchor="middle" font-size="12">Months</text>

      <!-- Grid Lines -->
      <xsl:call-template name="y-axis-grid">
        <xsl:with-param name="steps" select="5"/>
        <xsl:with-param name="max-value" select="400"/>
      </xsl:call-template>

      <!-- Bars -->
      <xsl:for-each select="dataset/items/item">
        <g class="bar-group">
          <!-- Bar -->
          <rect class="bar" 
                x="{position() * 80 + 60}" 
                y="{350 - @value}" 
                width="40" 
                height="{@value}" 
                fill="#4CAF50">
            <xsl:attribute name="data-value">
              <xsl:value-of select="@value"/>
            </xsl:attribute>
          </rect>

          <!-- Value Label -->
          <text x="{position() * 80 + 80}" 
                y="{350 - @value - 10}" 
                text-anchor="middle" 
                class="value-label">
            <xsl:value-of select="@value"/>
          </text>

          <!-- Category Label -->
          <text x="{position() * 80 + 80}" 
                y="380" 
                text-anchor="middle" 
                class="axis-label">
            <xsl:value-of select="@category"/>
          </text>
        </g>
      </xsl:for-each>
    </svg>
  </xsl:template>

  <!-- Y-axis Grid Template -->
  <xsl:template name="y-axis-grid">
    <xsl:param name="steps"/>
    <xsl:param name="max-value"/>
    <xsl:param name="current" select="1"/>
    
    <xsl:if test="$current &lt;= $steps">
      <g class="grid-line">
        <line x1="60" y1="{350 - ($max-value div $steps) * $current}" 
              x2="540" y2="{350 - ($max-value div $steps) * $current}" 
              stroke="#eee"/>
        <text x="50" y="{350 - ($max-value div $steps) * $current + 3}" 
              text-anchor="end" font-size="10">
          <xsl:value-of select="($max-value div $steps) * $current"/>
        </text>
      </g>
      <xsl:call-template name="y-axis-grid">
        <xsl:with-param name="steps" select="$steps"/>
        <xsl:with-param name="max-value" select="$max-value"/>
        <xsl:with-param name="current" select="$current + 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>