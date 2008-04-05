;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: asdf; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  ASDF system definition for IPMI
  </DESCRIPTION>
 <COPYRIGHT YEAR='2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/ipmi/trunk/ipmi.asd'/>
 <CHRONOLOGY>
  <DELTA DATE='20080316'>create documentation for "ipmi.asd"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :asdf)

(defsystem ipmi
  :description "Intelligent Platform Management Interface"
  :version "0.0"
  :author "Chun Tian (binghe) <binghe.lisp@gmail.com>"
  :depends-on (:usocket-udp)
  :components ((:file "package")
	       (:file "method-combination" :depends-on ("package"))
               (:file "rmcp" :depends-on ("method-combination"))
               (:file "asf" :depends-on ("rmcp"))
               (:file "ipmi" :depends-on ("rmcp"))
               (:file "sel" :depends-on ("ipmi"))))

:eof
