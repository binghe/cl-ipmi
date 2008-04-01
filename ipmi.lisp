;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: ipmi; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  IPMI (Intelligent Platform Management Interface)
  </DESCRIPTION>
 <COPYRIGHT YEAR='2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/snmp/trunk/ipmi.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080321'>create documentation for "ipmi.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :ipmi)

(defvar *asf-rmcp-port* 623)

(defun asf-ping (host &optional port)
  (let* ((socket (socket-connect/udp host (or port *asf-rmcp-port*)
                                 :stream t :element-type '(unsigned-byte 8)))
         (ping (make-instance 'asf-presence-ping)))
    (write-sequence (encode ping) (socket-stream socket))
    (force-output (socket-stream socket))))

:eof
