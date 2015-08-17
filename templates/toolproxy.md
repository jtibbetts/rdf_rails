
<div  class="status">
	IMS Final Release
</div>

![](http://www.imsglobal.org/images/imslogo.png)

ToolProxy JSON Binding
=====================
in the *application/vnd.ims.lti.v2.toolproxy+json*
format

<div class="subtitle">Final Version 2.0</div>  

</p>

<table class="mediaTypeProperties">
	<tr>
		<th>
			Media Type
		</th>
		<td>
			application/vnd.ims.lti.v2.toolproxy+json
		</td>
	</tr>
	<tr>
		<th>
			RDF Type
		</th>
		<td>
			<a href="../../../../../../../uml/purl.imsglobal.org/vocab/lti/v2/lti/index.html#ToolProxy">http://purl.imsglobal.org/vocab/lti/v2/lti#ToolProxy</a>
		</td>
	</tr>
	<tr>
		<th>
			JSON-LD
		</th>
		<td>
			<a href="context.json">http://purl.imsglobal.org/ctx/lti/v2/ToolProxy</a>
		</td>
	</tr>
</table>  

<p>
	
<div class="titlePageData">Date Issued: 6 January 2014</div>
<div class="titlePageData">Latest version: <a href="http://www.imsglobal.org/lti">http://www.imsglobal.org/lti</a></div>
<div class="legal" style="margin-top: 2em">
	
*<span style="font-size:9.0pt">IPR and Distribution Notices</span></b>

<p><span style="font-size:9.0pt;color:windowtext">Recipients of
this document are requested to submit, with their comments, notification of any
relevant patent claims or other intellectual property rights of which they may
be aware that might be infringed by any implementation of the specification set
forth in this document, and to provide supporting documentation.</span></p>

<p><span style="font-size:9.0pt;color:windowtext">IMS takes no
position regarding the validity or scope of any intellectual property or other
rights that might be claimed to pertain to the implementation or use of the
technology described in this document or the extent to which any license under
such rights might or might not be available; neither does it represent that it
has made any effort to identify any such rights. Information on IMS&#39;s
procedures with respect to rights in IMS specifications can be found at the IMS
Intellectual Property Rights web page: <a href="http://www.imsglobal.org/ipr/imsipr_policyFinal.pdf" target="_blank">http://www.imsglobal.org/ipr/<WBR>imsipr_policyFinal.pdf</a>.</span></p>

<p><span style="font-size:9.0pt;color:windowtext">Copyright © 2014 IMS Global Learning Consortium. All Rights Reserved.</span></p>

<p><span style="font-size:9.0pt;color:windowtext">Use of this
specification to develop products or services is governed by the license with
IMS found on the IMS website: <a href="http://www.imsglobal.org/license.html" target="_blank">http://www.imsglobal.org/<WBR>license.html</a>.</span></p>

<p><span style="font-size:9.0pt;color:windowtext">Permission is
granted to all parties to use excerpts from this document as needed in
producing requests for proposals.</span></p>

<p><span style="font-size:9.0pt;color:windowtext">The limited
permissions granted above are perpetual and will not be revoked by IMS or its
successors or assigns.</span></p>

<p><span style="font-size:9.0pt;color:windowtext">THIS
SPECIFICATION IS BEING OFFERED WITHOUT ANY WARRANTY WHATSOEVER, AND IN PARTICULAR,
ANY WARRANTY OF NONINFRINGEMENT IS EXPRESSLY DISCLAIMED. ANY USE OF THIS
SPECIFICATION SHALL BE MADE ENTIRELY AT THE IMPLEMENTER&#39;S OWN RISK, AND NEITHER
THE CONSORTIUM, NOR ANY OF ITS MEMBERS OR SUBMITTERS, SHALL HAVE ANY LIABILITY
WHATSOEVER TO ANY IMPLEMENTER OR THIRD PARTY FOR ANY DAMAGES OF ANY NATURE
WHATSOEVER, DIRECTLY OR INDIRECTLY, ARISING FROM THE USE OF THIS SPECIFICATION.</span></p>

<p>
	<span style="font-size:9.0pt">Join the discussion and post comments on the LTI Public Forum: <a href="http://www.imsglobal.org/community/forum/categories.cfm?catid=44" target="_blank">http://www.imsglobal.org/<wbr>community/forum/categories.<wbr>cfm?catid=44</a></span>
</p>
<hr>
<h2>
	Abstract
</h2>
<div>
	In the IMS LTI standard, a Tool Proxy represents an integration contract between two systems known respectively as Tool Consumer and Tool Provider. This specification document defines a JSON binding for Tool Proxy objects.
</div>
<h2>
	Table of Contents
</h2>
<ul class="toc">
	<li class="tocline">
		<span class="secno">1.</span> <a href="#Introduction">Introduction</a>
	</li>
	<li style="list-style: none">
		<ul class="toc">
			<li class="tocline">
				<span class="secno">1.1</span> <a href="#How_To_Read_this_Document">How To Read this Document</a>
			</li>
			<li class="tocline">
				<span class="secno">1.2</span> <a href="#Reserved_Terms">Reserved Terms</a>
			</li>
			<li class="tocline">
				<span class="secno">1.3</span> <a href="#The_JSON-LD_Context">The JSON-LD Context</a>
			</li>
		</ul>
	</li>
	<li class="tocline">
		<span class="secno">2.</span> <a href="#The_ToolProxy_Media_Type">The ToolProxy Media Type</a>
	</li>
	<li class="tocline">
		<span class="secno">3.</span> <a href="#JSON_Data_Bindings">JSON Data Bindings</a>
	</li>
	<li style="list-style: none">
		<ul class="toc">
			<li class="tocline">
				<span class="secno">3.1</span> <a href="#BaseUrlChoice">BaseUrlChoice</a>
			</li>
			<li class="tocline">
				<span class="secno">3.2</span> <a href="#BaseUrlSelector">BaseUrlSelector</a>
			</li>
			<li class="tocline">
				<span class="secno">3.3</span> <a href="#Capability">Capability</a>
			</li>
			<li class="tocline">
				<span class="secno">3.4</span> <a href="#Contact">Contact</a>
			</li>
			<li class="tocline">
				<span class="secno">3.5</span> <a href="#DataValue.Type">DataValue.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.6</span> <a href="#GUID.Type">GUID.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.7</span> <a href="#HttpMethod">HttpMethod</a>
			</li>
			<li class="tocline">
				<span class="secno">3.8</span> <a href="#IconEndpoint">IconEndpoint</a>
			</li>
			<li class="tocline">
				<span class="secno">3.9</span> <a href="#IconInfo">IconInfo</a>
			</li>
			<li class="tocline">
				<span class="secno">3.10</span> <a href="#IconStyle">IconStyle</a>
			</li>
			<li class="tocline">
				<span class="secno">3.11</span> <a href="#LocalizedName">LocalizedName</a>
			</li>
			<li class="tocline">
				<span class="secno">3.12</span> <a href="#LocalizedText">LocalizedText</a>
			</li>
			<li class="tocline">
				<span class="secno">3.13</span> <a href="#MessageHandler">MessageHandler</a>
			</li>
			<li class="tocline">
				<span class="secno">3.14</span> <a href="#MessageType">MessageType</a>
			</li>
			<li class="tocline">
				<span class="secno">3.15</span> <a href="#Name.Type">Name.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.16</span> <a href="#Parameter">Parameter</a>
			</li>
			<li class="tocline">
				<span class="secno">3.17</span> <a href="#ProductFamily">ProductFamily</a>
			</li>
			<li class="tocline">
				<span class="secno">3.18</span> <a href="#ProductInfo">ProductInfo</a>
			</li>
			<li class="tocline">
				<span class="secno">3.19</span> <a href="#ProductInstance">ProductInstance</a>
			</li>
			<li class="tocline">
				<span class="secno">3.20</span> <a href="#PropertyMap">PropertyMap</a>
			</li>
			<li class="tocline">
				<span class="secno">3.21</span> <a href="#ResourceHandler">ResourceHandler</a>
			</li>
			<li class="tocline">
				<span class="secno">3.22</span> <a href="#ResourceType">ResourceType</a>
			</li>
			<li class="tocline">
				<span class="secno">3.23</span> <a href="#RestService">RestService</a>
			</li>
			<li class="tocline">
				<span class="secno">3.24</span> <a href="#RestServiceProfile">RestServiceProfile</a>
			</li>
			<li class="tocline">
				<span>3.25</span> <a href="#SecurityContract">SecurityContract</a>
			</li>
			<li class="tocline">
				<span class="secno">3.26</span> <a href="#ServiceDescriptor">ServiceDescriptor</a>
			</li>
			<li class="tocline">
				<span class="secno">3.27</span> <a href="#ServiceOwner">ServiceOwner</a>
			</li>
			<li class="tocline">
				<span class="secno">3.28</span> <a href="#ServiceProfile">ServiceProfile</a>
			</li>
			<li class="tocline">
				<span class="secno">3.29</span> <a href="#ServiceProvider">ServiceProvider</a>
			</li>
			<li class="tocline">
				<span class="secno">3.30</span> <a href="#Token.Type">Token.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.31</span> <a href="#ToolProfile">ToolProfile</a>
			</li>
			<li class="tocline">
				<span class="secno">3.32</span> <a href="#ToolProxy">ToolProxy</a>
			</li>
			<li class="tocline">
				<span class="secno">3.33</span> <a href="#VariableName.Type">VariableName.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.34</span> <a href="#Vendor">Vendor</a>
			</li>
			<li class="tocline">
				<span class="secno">3.35</span> <a href="#LongName.Type">LongName.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.36</span> <a href="#Text.Type">Text.Type</a>
			</li>
		</ul>
	</li>
	<li class="tocline">
		<span class="secno">4.</span> <a href="#References">References</a>
	</li>
	<li class="tocline">
		<a href="#About_this_Document">About this Document</a>
	</li>
	<li style="list-style: none">
		<ul class="toc"></ul>
	</li>
</ul>
<p>
	<span style="font-size:9.0pt">Join the discussion and post comments on the LTI Public Forum: <a href="http://www.imsglobal.org/community/forum/categories.cfm?catid=44" target="_blank">http://www.imsglobal.org/<wbr>community/forum/categories.<wbr>cfm?catid=44</a></span>
</p>
<hr>
<h2>
	Abstract
</h2>
<div>
	In the IMS LTI standard, a Tool Proxy represents an integration contract between two systems known respectively as Tool Consumer and Tool Provider. This specification document defines a JSON binding for Tool Proxy objects.
</div>
<h2>
	Table of Contents
</h2>
<ul class="toc">
	<li class="tocline">
		<span class="secno">1.</span> <a href="#Introduction">Introduction</a>
	</li>
	<li style="list-style: none">
		<ul class="toc">
			<li class="tocline">
				<span class="secno">1.1</span> <a href="#How_To_Read_this_Document">How To Read this Document</a>
			</li>
			<li class="tocline">
				<span class="secno">1.2</span> <a href="#Reserved_Terms">Reserved Terms</a>
			</li>
			<li class="tocline">
				<span class="secno">1.3</span> <a href="#The_JSON-LD_Context">The JSON-LD Context</a>
			</li>
		</ul>
	</li>
	<li class="tocline">
		<span class="secno">2.</span> <a href="#The_ToolProxy_Media_Type">The ToolProxy Media Type</a>
	</li>
	<li class="tocline">
		<span class="secno">3.</span> <a href="#JSON_Data_Bindings">JSON Data Bindings</a>
	</li>
	<li style="list-style: none">
		<ul class="toc">
			<li class="tocline">
				<span class="secno">3.1</span> <a href="#BaseUrlChoice">BaseUrlChoice</a>
			</li>
			<li class="tocline">
				<span class="secno">3.2</span> <a href="#BaseUrlSelector">BaseUrlSelector</a>
			</li>
			<li class="tocline">
				<span class="secno">3.3</span> <a href="#Capability">Capability</a>
			</li>
			<li class="tocline">
				<span class="secno">3.4</span> <a href="#Contact">Contact</a>
			</li>
			<li class="tocline">
				<span class="secno">3.5</span> <a href="#DataValue.Type">DataValue.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.6</span> <a href="#GUID.Type">GUID.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.7</span> <a href="#HttpMethod">HttpMethod</a>
			</li>
			<li class="tocline">
				<span class="secno">3.8</span> <a href="#IconEndpoint">IconEndpoint</a>
			</li>
			<li class="tocline">
				<span class="secno">3.9</span> <a href="#IconInfo">IconInfo</a>
			</li>
			<li class="tocline">
				<span class="secno">3.10</span> <a href="#IconStyle">IconStyle</a>
			</li>
			<li class="tocline">
				<span class="secno">3.11</span> <a href="#LocalizedName">LocalizedName</a>
			</li>
			<li class="tocline">
				<span class="secno">3.12</span> <a href="#LocalizedText">LocalizedText</a>
			</li>
			<li class="tocline">
				<span class="secno">3.13</span> <a href="#MessageHandler">MessageHandler</a>
			</li>
			<li class="tocline">
				<span class="secno">3.14</span> <a href="#MessageType">MessageType</a>
			</li>
			<li class="tocline">
				<span class="secno">3.15</span> <a href="#Name.Type">Name.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.16</span> <a href="#Parameter">Parameter</a>
			</li>
			<li class="tocline">
				<span class="secno">3.17</span> <a href="#ProductFamily">ProductFamily</a>
			</li>
			<li class="tocline">
				<span class="secno">3.18</span> <a href="#ProductInfo">ProductInfo</a>
			</li>
			<li class="tocline">
				<span class="secno">3.19</span> <a href="#ProductInstance">ProductInstance</a>
			</li>
			<li class="tocline">
				<span class="secno">3.20</span> <a href="#PropertyMap">PropertyMap</a>
			</li>
			<li class="tocline">
				<span class="secno">3.21</span> <a href="#ResourceHandler">ResourceHandler</a>
			</li>
			<li class="tocline">
				<span class="secno">3.22</span> <a href="#ResourceType">ResourceType</a>
			</li>
			<li class="tocline">
				<span class="secno">3.23</span> <a href="#RestService">RestService</a>
			</li>
			<li class="tocline">
				<span class="secno">3.24</span> <a href="#RestServiceProfile">RestServiceProfile</a>
			</li>
			<li class="tocline">
				<span>3.25</span> <a href="#SecurityContract">SecurityContract</a>
			</li>
			<li class="tocline">
				<span class="secno">3.26</span> <a href="#ServiceDescriptor">ServiceDescriptor</a>
			</li>
			<li class="tocline">
				<span class="secno">3.27</span> <a href="#ServiceOwner">ServiceOwner</a>
			</li>
			<li class="tocline">
				<span class="secno">3.28</span> <a href="#ServiceProfile">ServiceProfile</a>
			</li>
			<li class="tocline">
				<span class="secno">3.29</span> <a href="#ServiceProvider">ServiceProvider</a>
			</li>
			<li class="tocline">
				<span class="secno">3.30</span> <a href="#Token.Type">Token.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.31</span> <a href="#ToolProfile">ToolProfile</a>
			</li>
			<li class="tocline">
				<span class="secno">3.32</span> <a href="#ToolProxy">ToolProxy</a>
			</li>
			<li class="tocline">
				<span class="secno">3.33</span> <a href="#VariableName.Type">VariableName.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.34</span> <a href="#Vendor">Vendor</a>
			</li>
			<li class="tocline">
				<span class="secno">3.35</span> <a href="#LongName.Type">LongName.Type</a>
			</li>
			<li class="tocline">
				<span class="secno">3.36</span> <a href="#Text.Type">Text.Type</a>
			</li>
		</ul>
	</li>
	<li class="tocline">
		<span class="secno">4.</span> <a href="#References">References</a>
	</li>
	<li class="tocline">
		<a href="#About_this_Document">About this Document</a>
	</li>
	<li style="list-style: none">
		<ul class="toc"></ul>
	</li>
</ul>

