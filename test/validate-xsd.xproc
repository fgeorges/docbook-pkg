<?xml version="1.0" encoding="UTF-8"?>
<p:pipeline xmlns:p="http://www.w3.org/ns/xproc"
            xmlns:pkg="http://expath.org/ns/pkg"
            version="1.0">

   <p:validate-with-xml-schema>
      <p:input port="schema">
         <p:document href="http://docbook.org/schemas/docbook.xsd" pkg:kind="xsd"/>
      </p:input>
   </p:validate-with-xml-schema>

</p:pipeline>
