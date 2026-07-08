################################################################################
#
# broadcom-sta
#
################################################################################

BROADCOM_STA_VERSION = batocera-6.18.16-1
BROADCOM_STA_SITE = $(call github,wolfclostermann,broadcom-sta-patched,$(BROADCOM_STA_VERSION))
BROADCOM_STA_LICENSE = Proprietary
BROADCOM_STA_REDISTRIBUTE = NO

BROADCOM_STA_MODULE_MAKE_OPTS = \
	USER_EXTRA_CFLAGS="-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN -Wno-error"

define BROADCOM_STA_BLACKLIST_IN_TREE_DRIVERS
	mkdir -p $(TARGET_DIR)/etc/modprobe.d
	cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/network/broadcom-sta/blacklist-broadcom-sta.conf \
		$(TARGET_DIR)/etc/modprobe.d/
endef

BROADCOM_STA_POST_INSTALL_TARGET_HOOKS += BROADCOM_STA_BLACKLIST_IN_TREE_DRIVERS

$(eval $(kernel-module))
$(eval $(generic-package))
