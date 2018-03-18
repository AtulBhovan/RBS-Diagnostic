${TOTALTEST_JOBCARD}
//***   SPECIFY JOBCARD IN TOTALTEST PREFERENCES TO SUBSTITUTE
//*
//*** THE JOB CARD MUST INCLUDE A NOTIFY STATEMENT SUCH 
//*** AS NOTIFY=&SYSUID and also a REGION=0M parameter
//*
//********************************************************************
//* Execute Target Runner under TSO using the DSN command
//*    and the RUN subcommand
//********************************************************************
//RUNBD2 EXEC PGM=IKJEFT01,REGION=500M
//*
//* You need to modify the following DD statements.
//*
//* The first DD statement should be changed to the ECC SLCXLOAD 
//* dataset that contains the Topaz for Total Test TTTRUNNR program.
//*
//* The second DD statement should be changed to the loadlib
//* containing the programs to run during the test.
//*
//* The third DD statement should be changed to the loadlib
//* containing the TSO DSN command.
//*
//* The fourth DD statement is only required if running the JCL 
//* from Topaz for Total Test CLI with Code Coverage support.
//* If testing an LE application it should be changed to the
//* loadlib containing the COBOL runtime(CEE.SCEERUN), otherwise 
//* it can be removed.
//*
//STEPLIB  DD DISP=SHR,DSN=SYSCOMPU.ECC.SLCXLOAD
//         DD DISP=SHR,DSN=PREV.POA1.LOAD
//         DD DISP=SHR,DSN=PREV.BOA1.LOAD
//         DD DISP=SHR,DSN=PREV.DOA1.LOAD
//         DD DISP=SHR,DSN=PREV.PUI1.LOAD
//         DD DISP=SHR,DSN=PREV.AUI2.LOAD
//         DD DISP=SHR,DSN=SYSDB2.DQA0.SDSNLOAD
//         DD DISP=SHR,DSN=SYSDB2.SDSNLOAD
//         DD DISP=SHR,DSN=SYS1.SCEERUN
//         DD DISP=SHR,DSN=SYS1.SCEERUN2
//         DD DISP=SHR,DSN=PREV.PRB1.LOAD
//*
//INFIL01  DD DSN=TTYA.P261736.OAPI2018.INPUT.FILE1,DISP=SHR
//OUTFIL01 DD DSN=TTYA.P261736.OAPI2018.OUTPUT.FILE120,DISP=SHR
//*
//TRPARM DD *
DEBUG(ON) 
*        Optionally set your custom exit program here:
* 
EXIT(NONE)
*
REPEAT(${TOTALTEST_REPEAT}),STUBS(${TOTALTEST_STUBS})
//*-----
//BININP DD DSN=${TOTALTEST_BININP},DISP=OLD
//BINREF DD DSN=${TOTALTEST_BINREF},DISP=OLD
//BINRES DD DSN=${TOTALTEST_BINRES},DISP=OLD
//*-----
//*-----
//*      Optional
//*      Add your custom DD statements
//SLSF001 DD DSN=TTOA.AOA1.DDIOTSO,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT DD SYSOUT=*
//*TTOUT  DD SYSOUT=*
//*          DISP=(NEW,CATLG,DELETE),
//*          UNIT=SYSDA,
//*          RECFM=FB,LRECL=80,BLKSIZE=0,
//*          SPACE=(CYL,(1,1),RLSE)
//SYSTSPRT DD SYSOUT=*
//SYSUDUMP DD SYSOUT=* 
//*
//* You need to modify the following RUN statement.
//*
//*
//* Change the <SUBSYSTEM ID> to your DB2 subsystem id(SSID).
//* Change the <PLAN NAME> to the plan name for your COBOL test program.
//*
//SYSTSIN  DD *
DSN SYSTEM(DQA0)
RUN PROGRAM(TTTRUNNR) PLAN(GOABATD2) PARMS('/NOSTAE')
END
/*
//












