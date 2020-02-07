
(script-fu-register
	"script-fu-random-planet"
	"Random Planet"
	""
	"Keksi"
	""
	""
	""
	SF-IMAGE "Image" 0
	SF-VALUE "Max angle deviation (deg)" "20"
	SF-VALUE "Max size decrease (%)" "30"


)(script-fu-menu-register "script-fu-random-planet" "<Image>/File")

(define (script-fu-random-planet
         img max_angle max_shrink)
(let* 
    (
        (layer (car (gimp-image-get-active-layer img)))
        (rad_degree 0.01745329251994329576923690768489)
        (new_angle (- (random (* 2 max_angle)) max_angle))
        (new_size (* (/ (- 100 (random max_shrink)) 100)))
    )

    (gimp-image-undo-group-start img)
    (gimp-context-push)
    
    (gimp-layer-scale
        layer
        (* new_size (car (gimp-drawable-width layer)))
        (* new_size (car (gimp-drawable-height layer)))
        TRUE
    )
    
    (gimp-item-transform-rotate
        layer
        (* rad_degree new_angle)
        TRUE
        0
        0
    )
    
    (gimp-hue-saturation
        layer
        0
        (- (random (* 2 180)) 180)
        0
        0
    )
 
	(gimp-context-pop)
	(gimp-displays-flush)
	(gimp-image-undo-group-end img)
)
)