(use-modules (gnu packages wm)
             (gnu packages)
             (guix packages)
             (guix git-download)
             )

(define bspwm-git
  (package
    (inherit bspwm)
    (name "bspwm-git")
    (version "master")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/baskerville/bspwm")
             (commit "8fc2269fe0f29a785885bcd9122812eae7226d7b")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1j2klj4wxvi75g33m9mkvgzckx2pc06ziq038xv8zdk1aw9r7nsq"))))
    ))
bspwm-git
