PAL
===

SAP HANA predictive analysis library

Code Snippets/ snippet filename “PAL nnn” corresponds to the video it goes with.

Fork from [saphanaacademy/PAL](https://github.com/saphanaacademy/PAL). Dropped files for import wizard, updated SQL scripts to import data (control file does not work for me for some reason).

For the import to work, csv_import_path_filter may need to be set or disabled.  
```ALTER SYSTEM ALTER CONFIGURATION ('indexserver.ini', 'system') set ('import_export', 'enable_csv_import_path_filter') = 'false' with reconfigure```  
[See here.](https://help.sap.com/viewer/4fe29514fd584807ac9f2a04f6754767/2.0.05/en-US/20f712e175191014907393741fadcb97.html)
