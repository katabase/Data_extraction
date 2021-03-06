<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:s="http://purl.oclc.org/dsdl/schematron"
    exclude-result-prefixes="xs" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
<xsl:template match="TEI">
    <xsl:copy>
        <xsl:apply-templates/>
    </xsl:copy>
</xsl:template>
    
    <!-- The rule below ensures that the teiHeader of the final document is TEI P5 compliant (As of May 2019, it is not the case of the output provided by GROBID dictionaries output -->
    
    <xsl:template match="teiHeader">
        <teiHeader>
            <fileDesc>
                <titleStmt>
                    <title>METTRE UN TITRE COURT (par exemple code du PDF). Le code se met désormais dans TEI/@xml:id</title>
                    <!-- Le code se récupère ici
                        https://docs.google.com/spreadsheets/d/1hGOWZXAdhFf0K94tvPL5OMqTpAhVI7PKSlasLkirQGY/edit?usp=sharing
                    -->
                    <!-- CHOISIR LA BONNE PERSONNE -->
                    <respStmt>
                        <persName ref="#COL_000001">Simon Gabay</persName>
                        <persName ref="#COL_000002">Lucie Rondeau du Noyer</persName>
                        <persName ref="#COL_000003">Ljudmila Petkovic</persName>
                        <persName ref="#COL_000004">Alexandre Bartz</persName>
                        <persName ref="#COL_000005">Caroline Corbières</persName>
                        <persName ref="#COL_000006">Matthias Gille Levenson</persName>
                        <resp><date when="2019">2020</date></resp>
                    </respStmt>
                </titleStmt>
                <extent></extent>
                <publicationStmt>
                    <publisher>Projet e-Ditiones, Université de Neuchâtel</publisher>
                    <availability status="restricted"> 
                        <licence  target="https://creativecommons.org/licenses/by/2.0">Attribution 2.0 Generic (CC BY 2.0)</licence>
                    </availability>
                </publicationStmt>
                <sourceDesc>
                    <bibl ana=""> <!-- bibliographical description of the print-->
                        <title>à renseigner</title>
                        <num>si nécessaire</num>
                        <editor></editor>
                        <publisher></publisher>
                        <pubPlace></pubPlace>
                        <date></date>
                    </bibl>
                    <listEvent>
                        <event> <!-- description of the related auction sale if necessary -->
                           <p> <address><addrLine></addrLine></address>

                            <persName type="auctioneer"></persName>                            

                            <persName type="expert"></persName>
                            
                            <date></date>
 </p>
                        </event>
                    </listEvent>
                    
                    <listWit><!-- list of the different instances of the catalog that were consulted / are known -->
                        <witness><ptr/></witness>
                        
                    </listWit> 
                    <listBibl> <!-- if applicable, a list of bibliographical references can be provided -->
                        <bibl></bibl>
                    </listBibl>
                </sourceDesc>
                
            </fileDesc>
            <profileDesc>
                <langUsage>
                    <language ident="fr">french</language>
                </langUsage>
            </profileDesc>
            
            <encodingDesc>
                <samplingDecl><p>This electronic version of the catalog only reproduces the entries that correspond to documents for sale. All text preceding or succeeding the list of documents for sale is not reproduced below.</p></samplingDecl>
                <appInfo>
                    <application version="1.11" ident="Transkribus" when="">
                        <label>Transkribus</label>
                        <ptr target="https://transkribus.eu/Transkribus/"/>
                    </application>
                    <application version="0.5.4" ident="GROBID" when="">
                        <label>GROBID_Dictionaries - A machine learning software for structuring digitized dictionaries</label>
                        <ptr target="https://github.com/MedKhem/grobid-dictionaries"/>
                    </application>
                </appInfo>
                <classDecl>
                    <taxonomy xml:id="catalogue_type">
                        <desc>Type of catalogues</desc>
                        <category xml:id="RDA">
                            <catDesc>Revue des autographes, des curiosités de l'histoire et de la biographie</catDesc>
                        </category>
                        <category xml:id="LAD">
                            <catDesc>Lettres autographes et documents historiques</catDesc>
                        </category>
                        <category xml:id="AUC">
                            <catDesc>Vente aux enchères</catDesc>
                        </category>
                        <category xml:id="LAV">
                            <catDesc>Ventes Laverdet</catDesc>
                        </category>
                        <category xml:id="OTH">
                            <catDesc>Divers/inconnu</catDesc>
                        </category>
                    </taxonomy>
                </classDecl>
            </encodingDesc>
        </teiHeader>

    </xsl:template>
    
    <xsl:template match="text">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="body">
        <xsl:copy>
            <xsl:element name="gap"/>
            <xsl:element name="list">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:copy>
        <xsl:element name="gap"/>
    </xsl:template>
    
    <xsl:template match="entry">
        <xsl:element name="item">
            <xsl:attribute name="n">
                <xsl:value-of select=".//num"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="pc"/>
 
    <xsl:template match="num">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="name">
        <xsl:element name="name">  
            <xsl:attribute name="type">
                <xsl:text>author</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="concat(., .//following-sibling::*[1])"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="desc">
        <xsl:element name="trait">
            <xsl:element name="p">
            <xsl:apply-templates/>
                <xsl:value-of select="../following-sibling::pc[1]"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="sense//sense">
        <xsl:element name="desc">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!--
    <xsl:when test="matches(., '\d$')">
        <xsl:analyze-string select="." regex="(\d+$)">
            <xsl:matching-substring>
                <xsl:element name="desc">
                    <xsl:variable name="tokens" select="tokenize(.,regex-group(1))"/>
                    <xsl:value-of select="$tokens[not(.=$tokens[last()])]" separator="-"/>
                </xsl:element>
                <xsl:element name="num">
                    <xsl:attribute name="type">
                        <xsl:text>price</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="regex-group(1)"/>
                </xsl:element>
            </xsl:matching-substring>
        </xsl:analyze-string>
        <xsl:value-of select="regex-group(1)"/>
    </xsl:when>
    -->
    
    
    <!--    <xsl:template match="sense//sense">
        <xsl:element name="desc">
            <xsl:apply-templates/>
            <xsl:choose>
                 <xsl:when test="./following-sibling::*[position()=1][name()='pc'] ">
                <xsl:when test="./following-sibling::pc">
                    <xsl:value-of select="following-sibling::pc[1]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="./ancestor::entry/following-sibling::pc[1]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
        </xsl:template> -->
    
    <xsl:template match="note">
        <xsl:copy>
            <xsl:apply-templates/>
            <xsl:value-of select="./ancestor::entry/following-sibling::pc[1]"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>

