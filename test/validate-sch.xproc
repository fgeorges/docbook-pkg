<?xml version="1.0" encoding="UTF-8"?>
<p:pipeline xmlns:p="http://www.w3.org/ns/xproc"
            xmlns:pkg="http://expath.org/ns/pkg"
            version="1.0">

   <p:validate-with-schematron>
      <p:input port="schema">
         <p:document href="http://docbook.org/schemas/docbook.sch" pkg:kind="schematron"/>
      </p:input>
   </p:validate-with-schematron>

</p:pipeline>
