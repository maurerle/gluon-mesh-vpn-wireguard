include $(TOPDIR)/rules.mk

PKG_NAME:=ff-mesh-vpn-wireguard
PKG_VERSION:=1

include $(TOPDIR)/../package/gluon.mk

define Package/ff-mesh-vpn-wireguard
  TITLE:=Support for connecting meshes via wireguard
  DEPENDS:=+gluon-core +libgluonutil +gluon-mesh-vpn-core +wireguard-tools +ff-wgpeerselector +libubus
endef

$(eval $(call BuildPackageGluon,ff-mesh-vpn-wireguard))
