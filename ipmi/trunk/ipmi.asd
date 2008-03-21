;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: asdf; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  ASDF system definition for SNMP
  </DESCRIPTION>
 <COPYRIGHT YEAR='2007-2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/snmp.asd'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "snmp.asd"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :asdf)

(defsystem ipmi
  :description "Intelligent Platform Management Interface"
  :version "0.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:snmp)
  :components ((:file "package")
               (:file "rmcp" :depends-on ("package"))
               (:file "asf" :depends-on ("rmcp"))
               (:file "ipmi" :depends-on ("rmcp"))))

:eof
