IMAGE_INSTALL_append_dh-stm32mp1-dhsom = " ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'wpebackend-fdo wpewebkit cog', '', d)} "
