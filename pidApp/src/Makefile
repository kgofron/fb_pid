TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = pid
# pid.dbd will be created and installed
DBD += pid.dbd

# pid.dbd will be made up from these files:
pid_DBD += base.dbd

# Include dbd files from all support applications:
pid_DBD += seqRecord.dbd mbboRecord.dbd
pid_DBD += system.dbd
pid_DBD += asSupport.dbd
pid_DBD += calcSupport.dbd
pid_DBD += devIocStats.dbd
pid_DBD += caPutLog.dbd
pid_DBD += stdSupport.dbd

# Add all the support libraries needed by this IOC
pid_LIBS += seq
pid_LIBS += autosave
pid_LIBS += calc
pid_LIBS += std
pid_LIBS += busy

pid_LIBS += devIocStats
pid_LIBS += caPutLog

# pid_registerRecordDeviceDriver.cpp derives from pid.dbd
pid_SRCS += pid_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
pid_SRCS_DEFAULT += pidMain.cpp
pid_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#pid_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
pid_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

