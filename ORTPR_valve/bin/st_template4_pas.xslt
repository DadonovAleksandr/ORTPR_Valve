<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="no" method="text"/>

    <xsl:key match="//conditionNode[@type='INPUT_VARIABLE']" name="distinctInputVariables" use="parameter[@name='name']/@value"/>
    <xsl:key match="//actionNode[@type='OUTPUT_ACTION']" name="distinctOutputActions" use="parameter[@name='name']/@value"/>
    <xsl:key match="//actionNode[@type='AUTOMATA_CALL']" name="distinctAutomataCalls" use="parameter[@name='automata']/@value"/>

    <!--===========================================================================================-->
    <!--Begin processing-->
    <xsl:template match="/model">
        <xsl:text>(* this file is machine generated! - not change this! *)&#x0A;</xsl:text>
        <xsl:text>(* Этот файл сгенерирован программой! не меняйте его руками! *)&#x0A;</xsl:text>
        <xsl:text>(* Для правки нужно использовать исходник *.vsd и программу генерации. *)&#x0A;</xsl:text>
        <xsl:text>(* Автор шаблона: Кернер А.В. 2016 год. *)&#x0A;</xsl:text>
        <xsl:text>(* Программа генератор: metaAuto. Автор: Канжелев С.Ю. 2005 год. *)&#x0A;</xsl:text>
        <xsl:text>(* Model:</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text> *)</xsl:text>
        <xsl:apply-templates select="stateMachine"/>
        <xsl:text>(* End. *)</xsl:text>
    </xsl:template>
    <!--===========================================================================================-->
    <!--Automata processing-->
    <xsl:template match="stateMachine">
        <xsl:text>&#x0A;</xsl:text>
        <xsl:text>(* Automat: </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text> *)&#x0A;</xsl:text>
        <xsl:text>(* </xsl:text>
        <xsl:value-of select="@description"/>
        <xsl:text> *)&#x0A;</xsl:text>
        <xsl:text>case State</xsl:text><xsl:value-of select="@name"/><xsl:text> of &#x0A;</xsl:text>
        <xsl:apply-templates mode="SWITCH_BLOCK" select="state//state[count(state) = 0]">
            <xsl:sort data-type="text" select="@name"/>
        </xsl:apply-templates>
        <xsl:variable name="stateMachineName" select="@name"/>
        <xsl:apply-templates
            mode="FUNCTION_DEFINITIONS"
            select="//actionNode[generate-id(.) = generate-id(key('distinctOutputActions', parameter[@name='name']/@value)[ancestor::stateMachine/@name=$stateMachineName])]">
            <xsl:sort select="@type"/>
            <xsl:sort select="@name"/>
        </xsl:apply-templates>
        <xsl:apply-templates
            mode="FUNCTION_DEFINITIONS"
            select="//actionNode[generate-id(.) = generate-id(key('distinctAutomataCalls', parameter[@name='automata']/@value)[ancestor::stateMachine/@name=$stateMachineName])]">
            <xsl:sort select="@type"/>
            <xsl:sort select="@name"/>
        </xsl:apply-templates>
        <xsl:apply-templates
            mode="FUNCTION_DEFINITIONS"
            select="//conditionNode[generate-id(.) = generate-id(key('distinctInputVariables', parameter[@name='name']/@value)[ancestor::stateMachine/@name=$stateMachineName])]">
            <xsl:sort select="@type"/>
            <xsl:sort select="@name"/>
        </xsl:apply-templates>
        <xsl:text>end_case; (* *)</xsl:text>
    </xsl:template>
    <!--End Automata processing-->
    <!--===========================================================================================-->
    <xsl:template match="state//state" mode="SWITCH_BLOCK">
        <xsl:text>&#x0A;</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>: (* </xsl:text>
        <xsl:value-of select="@description"/>
        <xsl:text> *)&#x0A;</xsl:text>
        <!-- Выходные данные: -->
        <xsl:choose>
          <xsl:when test="not(count(outputAction/actionNode) = 0)">
              <xsl:text>  (* Выходные данные: *)&#x0A;</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="outputAction/actionNode" mode="SWITCH_BLOCK"/>
        <xsl:text>&#x0A;</xsl:text>

        <!-- Процедуры вызываемые в этом состоянии: -->
        <xsl:choose>
          <xsl:when test="not(count(stateMachineRef/actionNode) = 0)">
              <xsl:text>  (* Процедуры вызываемые в этом состоянии: *)&#x0A;</xsl:text>
          </xsl:when>
        </xsl:choose>
        <xsl:apply-templates select="stateMachineRef/actionNode" mode="SWITCH_BLOCK"/>
        <xsl:text>&#x0A;</xsl:text>

        <!-- Условия перехода: -->
        <xsl:text>  (* Условия перехода: *)&#x0A;</xsl:text>
        <xsl:apply-templates mode="SWITCH_BLOCK" select="ancestor::stateMachine/transition[current()/ancestor-or-self::state/@name = @sourceRef]">
            <xsl:sort data-type="number" order="descending" select="count(condition)"/>
            <xsl:sort data-type="text" order="ascending" select="string-length(@priority) = 0"/>
            <xsl:sort data-type="number" select="@priority"/>
            <xsl:sort data-type="text" select="@targetRef"/>
        </xsl:apply-templates>
    </xsl:template>
    <!--===========================================================================================-->
    <!-- Transitions processing for creating switch block -->
    <xsl:template match="transition[not(count(./condition) = 0)]" mode="SWITCH_BLOCK">
      <xsl:text>  if (</xsl:text>
      <xsl:apply-templates mode="SWITCH_BLOCK" select="condition"/>
      <xsl:text>) then&#x0A;</xsl:text>
      <xsl:apply-templates mode="SWITCH_BLOCK" select="outputAction"/>
      <xsl:text>    State</xsl:text><xsl:value-of select="/model/stateMachine/@name"/><xsl:text> := </xsl:text>
      <xsl:value-of select="@targetRef"/>
      <xsl:text>; return;&#x0A;  end_if;&#x0A;</xsl:text>
    </xsl:template>
    <xsl:template match="transition[count(./condition) = 0]" mode="SWITCH_BLOCK">
      <xsl:text>  if (true) then&#x0A;</xsl:text>
      <xsl:apply-templates mode="SWITCH_BLOCK" select="outputAction"/>
      <xsl:text>    State</xsl:text><xsl:value-of select="/model/stateMachine/@name"/><xsl:text> := </xsl:text>
      <xsl:value-of select="@targetRef"/>
      <xsl:text>; return;&#x0A;  end_if;&#x0A;</xsl:text>
    </xsl:template>
    <!-- End Transitions processing for creating switch block -->
    <!--===========================================================================================-->

    <xsl:template match="condition" mode="SWITCH_BLOCK">
        <xsl:apply-templates mode="SWITCH_BLOCK"/>
    </xsl:template>
    <xsl:template match="outputAction" mode="SWITCH_BLOCK">
        <xsl:apply-templates mode="SWITCH_BLOCK"/>
    </xsl:template>


    <!--===========================================================================================-->
    <!-- Action nodes -->
    <xsl:template match="actionNode[@type='SIMPLE_OUTPUT_ACTION_IN_STATE']" mode="SWITCH_BLOCK">
        <xsl:text>  </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text> := TRUE;&#x0A;</xsl:text>
    </xsl:template>

    <xsl:template match="actionNode[@type='OUTPUT_ACTION']" mode="SWITCH_BLOCK">
        <xsl:text>    </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>();&#x0A;</xsl:text>
    </xsl:template>

    <xsl:template match="actionNode[@type='AUTOMATA_CALL']" mode="SWITCH_BLOCK">
        <xsl:text>    </xsl:text>
        <xsl:value-of select="parameter[@name='automata']/@value"/>
        <xsl:text>;&#x0A;</xsl:text>
    </xsl:template>

    <xsl:template match="actionNode" mode="SWITCH_BLOCK" priority="0">
        <xsl:text>/* ERROR: Unknown action Node type: '</xsl:text>
        <xsl:value-of select="@type"/>
        <xsl:text>';*/</xsl:text>
    </xsl:template>
    <!-- End Action nodes -->
    <!--===========================================================================================-->



    <!--===========================================================================================-->
    <!-- Condition nodes and operations -->
    <xsl:template match="conditionNode[@type='INPUT_VARIABLE']" mode="SWITCH_BLOCK">
        <xsl:text>x</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>()</xsl:text>
    </xsl:template>
    <xsl:template match="conditionNode[@type='EVENT']" mode="SWITCH_BLOCK">
        <xsl:text></xsl:text><xsl:value-of select="@name"/>
    </xsl:template>
    <xsl:template match="conditionNode" mode="SWITCH_BLOCK" priority="0">
        /* ERROR: Unknown action Node type: '
        <xsl:value-of select="@type"/>
        '; Please, correct the xslt file; */
    </xsl:template>
    <xsl:template match="binaryOperation[@type='AND']" mode="SWITCH_BLOCK">
        <xsl:text>(</xsl:text>
        <xsl:apply-templates mode="SWITCH_BLOCK" select="child::*[position()=1]"/>
        <xsl:text>) AND (</xsl:text>
        <xsl:apply-templates mode="SWITCH_BLOCK" select="child::*[position()=2]"/>
        <xsl:text>)</xsl:text>
    </xsl:template>
    <xsl:template match="binaryOperation[@type='OR']" mode="SWITCH_BLOCK">
        <xsl:text>(</xsl:text>
        <xsl:apply-templates mode="SWITCH_BLOCK" select="child::*[position()=1]"/>
        <xsl:text>) OR (</xsl:text>
        <xsl:apply-templates mode="SWITCH_BLOCK" select="child::*[position()=2]"/>
        <xsl:text>)</xsl:text>
    </xsl:template>
    <xsl:template match="unaryOperation[@type='NOT']" mode="SWITCH_BLOCK">
        <xsl:text>NOT(</xsl:text>
        <xsl:apply-templates mode="SWITCH_BLOCK" select="child::*[position()=1]"/>
        <xsl:text>)</xsl:text>
    </xsl:template>
    <xsl:template match="binaryOperation" mode="SWITCH_BLOCK" priority="0">
        /*Error: Unknown binary operation type: '
        <xsl:value-of select="@type"/>
        '; Please, correct the xslt file; */
    </xsl:template>
    <xsl:template match="unaryOperation" mode="SWITCH_BLOCK" priority="0">
        /*Error: Unknown unary operation type: '
        <xsl:value-of select="@type"/>
        '; Please, correct the xslt file; */
    </xsl:template>
    <!-- End Condition nodes and operations -->


    <!--===========================================================================================-->
<!--
    <xsl:template match="actionNode[@type='OUTPUT_ACTION']" mode="FUNCTION_DEFINITIONS">
        /// &lt;summary&gt;
        /// <xsl:value-of select="ancestor-or-self::stateMachine//node[(@type = current()/@type) and (@name = current()/@name)]/@description" />
        /// &lt;/summary&gt;
        protected abstract void z<xsl:value-of select="@name" />();
</xsl:template>
    <xsl:template match="actionNode[@type='AUTOMATA_CALL']" mode="FUNCTION_DEFINITIONS">
        /// &lt;summary&gt;
        /// Вызов реализации автомата <xsl:value-of select="parameter[@name='automata']/@value" />.
        /// &lt;/summary&gt;
        protected abstract void Call_<xsl:value-of select="parameter[@name='automata']/@value" />(int e);
</xsl:template>
    <xsl:template match="actionNode" priority="0" mode="FUNCTION_DEFINITIONS">
        /*ERROR: Unknown actionNode type: '<xsl:value-of select="@type" />'; Please, correct xslt file;*/
</xsl:template>
    <xsl:template match="conditionNode[@type='INPUT_VARIABLE']" mode="FUNCTION_DEFINITIONS">
        /// &lt;summary&gt;
        /// <xsl:value-of select="ancestor-or-self::stateMachine//node[(@type = current()/@type) and (@name = current()/@name)]/@description" />
        /// &lt;/summary&gt;
        /// &lt;returns&gt;True если условие выполнено, false - в противном случае&lt;/returns&gt;
        protected abstract bool x<xsl:value-of select="@name" />();
</xsl:template>

    <xsl:template match="conditionNode[@type='EVENT']" mode="FUNCTION_DEFINITIONS"/>
    <xsl:template match="conditionNode" mode="FUNCTION_DEFINITIONS" priority="0">
        /*ERROR: Unknown conditionNode type: '
        <xsl:value-of select="@type"/>
        '; Please, correct xslt file;*/
    </xsl:template>
-->
</xsl:stylesheet>
