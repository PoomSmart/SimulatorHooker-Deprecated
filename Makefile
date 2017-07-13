DEBUG = 0

include $(THEOS)/makefiles/common.mk

AGGREGATE_NAME = SimulatorHooker
SUBPROJECTS = Injector

include $(THEOS_MAKE_PATH)/aggregate.mk
