(defsystem :hello-world-server
  :author "Jonathan Godbout"
  :version "0.0.1"
  :licence "MIT-style"
  :description      "CL-protobuf Hello World Server"
  :long-description "CL-protobuf Hello World Server"
  :defsystem-depends-on (:cl-protobufs)
  :depends-on (:hunchentoot :trivial-utf-8)
  :components
  ((:module "src"
    :serial t
    :pathname ""
    :components ((:protobuf-source-file "hello-world")
                 (:file "hello-world-server")))))
