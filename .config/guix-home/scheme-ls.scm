(define-module (guile-lsp-server)
               #:use-module (guix packages)
               #:use-module ((guix licenses)
                             #:prefix license:)
               #:use-module (guix download)
               #:use-module (guix git-download)
               #:use-module (guix gexp)
               #:use-module (guix build-system gnu)
               #:use-module (gnu packages)
               #:use-module (gnu packages autotools)
               #:use-module (gnu packages guile)
               #:use-module (gnu packages pkg-config)
               #:use-module (gnu packages texinfo)
               #:use-module (ice-9 rdelim)
               #:use-module (ice-9 popen)
               #:use-module (gnu packages guile-xyz))

(define %source-dir
  (getcwd))

(define-public guile-json-rpc
               (let ((version "0.4.0")
                     (revision "0")
                     (commit "3c4f55aa55bda8616f84f647f47e79b9fbd45889"))
                 (package
                   (name "guile-json-rpc")
                   (version (git-version version revision commit))
                   (source
                     (origin
                       (method git-fetch)
                       (uri (git-reference
                              (url "https://codeberg.org/rgherdt/scheme-json-rpc")
                              (commit commit)))
                       (sha256
                         (base32
                           "0z5azrxm4qd8dccz7hx2gnnw4wgig1n8x1jqv3bi9zack8q1wyfk"))))
                   (build-system gnu-build-system)
                   (arguments
                     (list
                       #:phases
                       #~(modify-phases
                           %standard-phases
                           (add-after 'unpack 'move-to-guile-directory
                                      (lambda _
                                        (chdir "./guile"))))))

                   (inputs (list guile-srfi-145 guile-srfi-180))
                   (native-inputs (list autoconf automake pkg-config texinfo guile-3.0))
                   (synopsis "An implementation of the JSON-RPC for Guile.")
                   (description
                     "@code{scheme-json-rpc} allows calling procedures
                     on remote servers by exchanging JSON objects.  It implements the
                     @url{jsonrpc specifications, https://www.jsonrpc.org/specification}.
                     The low-level API strives to be R7RS compliant, relying on some SRFI's
                     when needed.")
                     (home-page "https://codeberg.org/rgherdt/scheme-json-rpc")
                     (license license:expat))))

(define-public guile-lsp-server
               (let ((version "0.4.1")
                     (revision "0")
                     (commit "dfeb59bd97adff49e2904fdeda739d6a21e88b13"))
                 (package
                   (name "guile-lsp-server")
                   (version (git-version version revision commit))
                   (source
                     (origin
                       (method git-fetch)
                       (uri
                         (git-reference
                           (url "https://codeberg.org/rgherdt/scheme-lsp-server")
                           (commit commit)
                           ))
                       (file-name (git-file-name name version))
                       (sha256
                         (base32
                           "16c40pprk8xy6c1gigja6qgc13jqc086ylpcq0hi88hi3b7ss6ji"))
                       ))
                   (build-system gnu-build-system)
                   (arguments
                     (list
                       #:phases
                       #~(modify-phases
                           %standard-phases
                           (add-after
                             'unpack 'move-to-guile-directory
                             (lambda _
                               (chdir "./guile"))))))

                   (native-inputs
                     (list
                       autoconf
                       automake
                       pkg-config
                       texinfo
                       guile-3.0))
                   (propagated-inputs
                     (list
                       guile-3.0
                       guile-json-rpc
                       guile-srfi-145
                       guile-srfi-180
                       guile-irregex))
                   (synopsis "LSP (Language Server Protocol) server for Guile.")
                   (description
                     "Provides a library (lsp-server) and an executable
                     @code{guile-lsp-server} that can be used by LSP clients in order to
                     provide IDE functionality for Guile Scheme.")
                     (home-page "https://codeberg.org/rgherdt/scheme-lsp-server")
                     (license license:expat))))

guile-lsp-server
