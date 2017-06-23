#!../../bin/linux-x86_64/pid

< envPaths

epicsEnvSet("ENGINEER",  "Yong HU x3961")
epicsEnvSet("LOCATION",  "740 3IDC RG-C1")

epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.3.0.255")

epicsEnvSet("SYS", "XF:03IDC-CT")
# epicsEnvSet("IOCNAME", "pid") # set by softioc init.d script
epicsEnvSet("IOC_P", "$(SYS){IOC:$(IOCNAME)}")

## Register all support components
dbLoadDatabase("../../dbd/pid.dbd",0,0)
pid_registerRecordDeviceDriver(pdbbase) 

## Load record instances
dbLoadRecords("$(EPICS_BASE)/db/iocAdminSoft.db","IOC=$(IOC_P)")

#epicsEnvSet("DEV", "{Pid:01}")
#dbLoadRecords("$(TOP)/db/pid.db", "Sys=$(SYS),Dev=$(DEV),PREC=3,INP=$(SYS)$(DEV)input_,OUT=$(SYS)$(DEV)output_")
#epicsEnvSet("DEV", "{Pid:02}")
#dbLoadRecords("$(TOP)/db/pid.db", "Sys=$(SYS),Dev=$(DEV),PREC=3,INP=$(SYS)$(DEV)input_,OUT=$(SYS)$(DEV)output_")
#epicsEnvSet("DEV", "{Pid:03}")
#dbLoadRecords("$(TOP)/db/pid.db", "Sys=$(SYS),Dev=$(DEV),PREC=3,INP=$(SYS)$(DEV)input_,OUT=$(SYS)$(DEV)output_")
#epicsEnvSet("DEV", "{Pid:04}")
#dbLoadRecords("$(TOP)/db/pid.db", "Sys=$(SYS),Dev=$(DEV),PREC=3,INP=$(SYS)$(DEV)input_,OUT=$(SYS)$(DEV)output_")

epicsEnvSet("DEV", "{FbPid:01}")
dbLoadRecords("$(TOP)/db/fb_epid.db", "Sys=$(SYS),Dev=$(DEV),PID=PID,PREC=3,IN=$(SYS)$(DEV)PID:input_,OUT=$(SYS)$(DEV)PID:output_,MODE=PID,CALC=A,PERMIT1=,PERMIT2=,PERMIT3=,PERMIT4=")
epicsEnvSet("DEV", "{FbPid:02}")
dbLoadRecords("$(TOP)/db/fb_epid.db", "Sys=$(SYS),Dev=$(DEV),PID=PID,PREC=3,IN=$(SYS)$(DEV)PID:input_,OUT=$(SYS)$(DEV)PID:output_,MODE=PID,CALC=A,PERMIT1=,PERMIT2=,PERMIT3=,PERMIT4=")
epicsEnvSet("DEV", "{FbPid:03}")
dbLoadRecords("$(TOP)/db/fb_epid.db", "Sys=$(SYS),Dev=$(DEV),PID=PID,PREC=3,IN=$(SYS)$(DEV)PID:input_,OUT=$(SYS)$(DEV)PID:output_,MODE=PID,CALC=A,PERMIT1=,PERMIT2=,PERMIT3=,PERMIT4=")
epicsEnvSet("DEV", "{FbPid:04}")
dbLoadRecords("$(TOP)/db/fb_epid.db", "Sys=$(SYS),Dev=$(DEV),PID=PID,PREC=3,IN=$(SYS)$(DEV)PID:input_,OUT=$(SYS)$(DEV)PID:output_,MODE=PID,CALC=A,PERMIT1=,PERMIT2=,PERMIT3=,PERMIT4=")

dbLoadRecords("$(EPICS_BASE)/db/save_restoreStatus.db", "P=$(IOC_P)")

cd ${TOP}/
save_restoreSet_status_prefix("$(IOC_P)")

system("install -m 777 -d ${TOP}/as/save")
system("install -m 777 -d ${TOP}/as/req")

set_savefile_path("${TOP}/as/save","")
set_requestfile_path("$(EPICS_BASE)/as/req")
set_requestfile_path("${TOP}/as/req")

set_pass0_restoreFile("ioc_settings.sav")
set_pass1_restoreFile("ioc_settings.sav")

iocInit()

makeAutosaveFileFromDbInfo("${TOP}/as/req/ioc_settings.req", "autosaveFields_pass0")

create_monitor_set("ioc_settings.req", 10, "P=$(IOC_P)")
# caPutLogInit("ioclog.cs.nsls2.local:7004", 1)

cd ${TOP}
dbl > ./records.dbl
system "cp ./records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"
