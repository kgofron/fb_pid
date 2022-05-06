#!../../bin/linux-x86_64/pid

< envPaths
< /epics/common/xf10idd-ioc1-netsetup.cmd
errlogInit(20000)
# recDynLinkQsize needs to increase

epicsEnvSet("ENGINEER",  "Beamline Control")
epicsEnvSet("LOCATION",  "744 10IDD RG-D2")


epicsEnvSet("SYS", "XF:10ID-CT")
epicsEnvSet("IOCNAME", "pid") # set by softioc init.d script
epicsEnvSet("IOC_P", "$(SYS){IOC:$(IOCNAME)}")

## Register all support components
dbLoadDatabase("../../dbd/pid.dbd",0,0)
pid_registerRecordDeviceDriver(pdbbase) 

## Load record instances
dbLoadRecords("$(DEVIOCSTATS)/db/iocAdminSoft.db","IOC=$(IOC_P)")
dbLoadRecords("$(RECCASTER)/db/reccaster.db", "P=$(IOC_P)RecSync")

#epicsEnvSet("DEV", "{Pid:01}")
#dbLoadRecords("$(TOP)/db/pid.db", "Sys=$(SYS),Dev=$(DEV),PREC=3,INP=$(SYS)$(DEV)input_,OUT=$(SYS)$(DEV)output_")
#epicsEnvSet("DEV", "{Pid:02}")
#dbLoadRecords("$(TOP)/db/pid.db", "Sys=$(SYS),Dev=$(DEV),PREC=3,INP=$(SYS)$(DEV)input_,OUT=$(SYS)$(DEV)output_")
#epicsEnvSet("DEV", "{Pid:03}")
#dbLoadRecords("$(TOP)/db/pid.db", "Sys=$(SYS),Dev=$(DEV),PREC=3,INP=$(SYS)$(DEV)input_,OUT=$(SYS)$(DEV)output_")
#epicsEnvSet("DEV", "{Pid:04}")
#dbLoadRecords("$(TOP)/db/pid.db", "Sys=$(SYS),Dev=$(DEV),PREC=3,INP=$(SYS)$(DEV)input_,OUT=$(SYS)$(DEV)output_")

epicsEnvSet("DEV", "{FbPid:01}")
dbLoadRecords("$(TOP)/db/fb_epid.db", "Sys=$(SYS),Dev=$(DEV),PID=PID,PREC=6,IN=$(SYS)$(DEV)PID:input_,OUT=$(SYS)$(DEV)PID:output_,MODE=PID,CALC=A,PERMIT1=,PERMIT2=,PERMIT3=,PERMIT4=")
epicsEnvSet("DEV", "{FbPid:02}")
dbLoadRecords("$(TOP)/db/fb_epid.db", "Sys=$(SYS),Dev=$(DEV),PID=PID,PREC=6,IN=$(SYS)$(DEV)PID:input_,OUT=$(SYS)$(DEV)PID:output_,MODE=PID,CALC=A,PERMIT1=,PERMIT2=,PERMIT3=,PERMIT4=")
epicsEnvSet("DEV", "{FbPid:03}")
dbLoadRecords("$(TOP)/db/fb_epid.db", "Sys=$(SYS),Dev=$(DEV),PID=PID,PREC=6,IN=$(SYS)$(DEV)PID:input_,OUT=$(SYS)$(DEV)PID:output_,MODE=PID,CALC=A,PERMIT1=,PERMIT2=,PERMIT3=,PERMIT4=")
epicsEnvSet("DEV", "{FbPid:04}")
dbLoadRecords("$(TOP)/db/fb_epid.db", "Sys=$(SYS),Dev=$(DEV),PID=PID,PREC=6,IN=$(SYS)$(DEV)PID:input_,OUT=$(SYS)$(DEV)PID:output_,MODE=PID,CALC=A,PERMIT1=,PERMIT2=,PERMIT3=,PERMIT4=")
epicsEnvSet("DEV", "{FbPid:05}")
dbLoadRecords("$(TOP)/db/fb_epid.db", "Sys=$(SYS),Dev=$(DEV),PID=PID,PREC=6,IN=$(SYS)$(DEV)PID:input_,OUT=$(SYS)$(DEV)PID:output_,MODE=PID,CALC=A,PERMIT1=,PERMIT2=,PERMIT3=,PERMIT4=")
epicsEnvSet("DEV", "{FbPid:06}")
dbLoadRecords("$(TOP)/db/fb_epid.db", "Sys=$(SYS),Dev=$(DEV),PID=PID,PREC=6,IN=$(SYS)$(DEV)PID:input_,OUT=$(SYS)$(DEV)PID:output_,MODE=PID,CALC=A,PERMIT1=,PERMIT2=,PERMIT3=,PERMIT4=")

dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=$(IOC_P)")

cd ${TOP}/
save_restoreSet_status_prefix("$(IOC_P)")

#system("install -m 777 -d ${TOP}/as/save")
#system("install -m 777 -d ${TOP}/as/req")

set_savefile_path("${TOP}/as/save","")
set_requestfile_path("$(EPICS_BASE)/as/req")
set_requestfile_path("${TOP}/as/req")

set_pass0_restoreFile("ioc_settings.sav")
#set_pass1_restoreFile("ioc_settings_pass1.sav")

callbackSetQueueSize(50000)
### need more entries in wait/scan-record channel-access queue? sscan must be compiled in.
var recDynLinkQsize 1024
#var swaitRecordDebug 6

iocInit()

makeAutosaveFileFromDbInfo("${TOP}/as/req/ioc_settings.req", "autosaveFields_pass0")

create_monitor_set("ioc_settings.req", 10, "P=$(IOC_P)")
# caPutLogInit("ioclog.cs.nsls2.local:7004", 1)

# Avoid: filename="../swaitRecord.c" line number=870 ;  recWait: rngBufGet error
# Cycle the off->on, and messages stop
dbpf("$(SYS){FbPid:01}PID:on","off")
dbpf("$(SYS){FbPid:02}PID:on","off")
dbpf("$(SYS){FbPid:03}PID:on","off")
dbpf("$(SYS){FbPid:04}PID:on","off")
dbpf("$(SYS){FbPid:05}PID:on","off")
dbpf("$(SYS){FbPid:06}PID:on","off")
epicsThreadSleep 1
dbpf("$(SYS){FbPid:01}PID:on","on")
dbpf("$(SYS){FbPid:02}PID:on","on")
dbpf("$(SYS){FbPid:03}PID:on","on")
dbpf("$(SYS){FbPid:04}PID:on","on")
dbpf("$(SYS){FbPid:05}PID:on","on")
dbpf("$(SYS){FbPid:06}PID:on","on")

#dbpf("$(SYS){FbPid:01}PID:enable.PROC","1")
#dbpf("$(SYS){FbPid:02}PID:enable.PROC","1")
#dbpf("$(SYS){FbPid:03}PID:enable.PROC","1")
#dbpf("$(SYS){FbPid:04}PID:enable.PROC","1")
#dbpf("$(SYS){FbPid:05}PID:enable.PROC","1")
#dbpf("$(SYS){FbPid:06}PID:enable.PROC","1")

cd ${TOP}
dbl > ./records.dbl
#system "cp ./records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"
