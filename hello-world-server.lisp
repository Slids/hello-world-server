(defpackage #:hello-world-server
  (:use #:cl
        #:hunchentoot)
  (:export #:start-server
           #:stop-server)
  (:local-nicknames
   (#:hwp #:cl-protobufs.hello-world)))

(in-package :hello-world-server)

(setf *dispatch-table*
      (list #'dispatch-easy-handlers))

(setf *show-lisp-errors-p* t
      *show-lisp-backtraces-p* t)

(setf *acceptor* nil)

(define-easy-handler (hello-world :uri "/hello") ()
  (setf (hunchentoot:content-type*) "application/octet-stream")
  (let* ((post-request (raw-post-data))
         (request (if post-request
                      (cl-protobufs:deserialize-from-bytes
                       'hwp:request post-request)
                      (hwp:make-request)))
         (response (hwp:make-response
                    :response
                    (if (hwp:request.has-name request)
                        (format nil "Hello ~a" (hwp:request.name request))
                        "Hello"))))
    (cl-protobufs:serialize-to-bytes response)))

(defun stop-server ()
  (when *acceptor*
    (stop *acceptor*)))

(defun start-server ()
  (stop-server)
  (start (setf *acceptor*
               (make-instance 'easy-acceptor
                              :port 4242))))

(start-server)
