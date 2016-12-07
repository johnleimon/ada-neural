pragma Ada_95;
pragma Warnings (Off);
with System;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2016 (20160515-49)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_main" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#102abe07#;
   pragma Export (C, u00001, "mainB");
   u00002 : constant Version_32 := 16#b6df930e#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#337e9ce1#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#84ad4a42#;
   pragma Export (C, u00005, "ada__numericsS");
   u00006 : constant Version_32 := 16#c3282aa7#;
   pragma Export (C, u00006, "systemS");
   u00007 : constant Version_32 := 16#87a448ff#;
   pragma Export (C, u00007, "system__exception_tableB");
   u00008 : constant Version_32 := 16#9e8643e5#;
   pragma Export (C, u00008, "system__exception_tableS");
   u00009 : constant Version_32 := 16#5f84b5ab#;
   pragma Export (C, u00009, "system__soft_linksB");
   u00010 : constant Version_32 := 16#5dacf2f2#;
   pragma Export (C, u00010, "system__soft_linksS");
   u00011 : constant Version_32 := 16#b01dad17#;
   pragma Export (C, u00011, "system__parametersB");
   u00012 : constant Version_32 := 16#bd0227d8#;
   pragma Export (C, u00012, "system__parametersS");
   u00013 : constant Version_32 := 16#0f0cb66d#;
   pragma Export (C, u00013, "system__secondary_stackB");
   u00014 : constant Version_32 := 16#6849e5ce#;
   pragma Export (C, u00014, "system__secondary_stackS");
   u00015 : constant Version_32 := 16#39a03df9#;
   pragma Export (C, u00015, "system__storage_elementsB");
   u00016 : constant Version_32 := 16#eeeb60a3#;
   pragma Export (C, u00016, "system__storage_elementsS");
   u00017 : constant Version_32 := 16#472fa979#;
   pragma Export (C, u00017, "ada__exceptionsB");
   u00018 : constant Version_32 := 16#a2017425#;
   pragma Export (C, u00018, "ada__exceptionsS");
   u00019 : constant Version_32 := 16#e947e6a9#;
   pragma Export (C, u00019, "ada__exceptions__last_chance_handlerB");
   u00020 : constant Version_32 := 16#41e5552e#;
   pragma Export (C, u00020, "ada__exceptions__last_chance_handlerS");
   u00021 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00021, "system__exceptionsB");
   u00022 : constant Version_32 := 16#ab4b4751#;
   pragma Export (C, u00022, "system__exceptionsS");
   u00023 : constant Version_32 := 16#4c9e814d#;
   pragma Export (C, u00023, "system__exceptions__machineS");
   u00024 : constant Version_32 := 16#aa0563fc#;
   pragma Export (C, u00024, "system__exceptions_debugB");
   u00025 : constant Version_32 := 16#bda2d363#;
   pragma Export (C, u00025, "system__exceptions_debugS");
   u00026 : constant Version_32 := 16#6c2f8802#;
   pragma Export (C, u00026, "system__img_intB");
   u00027 : constant Version_32 := 16#c1f3ca65#;
   pragma Export (C, u00027, "system__img_intS");
   u00028 : constant Version_32 := 16#39df8c17#;
   pragma Export (C, u00028, "system__tracebackB");
   u00029 : constant Version_32 := 16#9d0af463#;
   pragma Export (C, u00029, "system__tracebackS");
   u00030 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00030, "system__traceback_entriesB");
   u00031 : constant Version_32 := 16#c373dcd7#;
   pragma Export (C, u00031, "system__traceback_entriesS");
   u00032 : constant Version_32 := 16#6fd210f2#;
   pragma Export (C, u00032, "system__traceback__symbolicB");
   u00033 : constant Version_32 := 16#dd19f67a#;
   pragma Export (C, u00033, "system__traceback__symbolicS");
   u00034 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00034, "ada__exceptions__tracebackB");
   u00035 : constant Version_32 := 16#20245e75#;
   pragma Export (C, u00035, "ada__exceptions__tracebackS");
   u00036 : constant Version_32 := 16#57a37a42#;
   pragma Export (C, u00036, "system__address_imageB");
   u00037 : constant Version_32 := 16#62c4b79d#;
   pragma Export (C, u00037, "system__address_imageS");
   u00038 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00038, "system__wch_conB");
   u00039 : constant Version_32 := 16#d8550875#;
   pragma Export (C, u00039, "system__wch_conS");
   u00040 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00040, "system__wch_stwB");
   u00041 : constant Version_32 := 16#f5442474#;
   pragma Export (C, u00041, "system__wch_stwS");
   u00042 : constant Version_32 := 16#a831679c#;
   pragma Export (C, u00042, "system__wch_cnvB");
   u00043 : constant Version_32 := 16#d7e2b286#;
   pragma Export (C, u00043, "system__wch_cnvS");
   u00044 : constant Version_32 := 16#5ab55268#;
   pragma Export (C, u00044, "interfacesS");
   u00045 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00045, "system__wch_jisB");
   u00046 : constant Version_32 := 16#5792aba7#;
   pragma Export (C, u00046, "system__wch_jisS");
   u00047 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00047, "system__stack_checkingB");
   u00048 : constant Version_32 := 16#4d97414f#;
   pragma Export (C, u00048, "system__stack_checkingS");
   u00049 : constant Version_32 := 16#3158da1f#;
   pragma Export (C, u00049, "ada__numerics__real_arraysB");
   u00050 : constant Version_32 := 16#0c903214#;
   pragma Export (C, u00050, "ada__numerics__real_arraysS");
   u00051 : constant Version_32 := 16#5e196e91#;
   pragma Export (C, u00051, "ada__containersS");
   u00052 : constant Version_32 := 16#6c05c057#;
   pragma Export (C, u00052, "system__exn_llfB");
   u00053 : constant Version_32 := 16#7f56917b#;
   pragma Export (C, u00053, "system__exn_llfS");
   u00054 : constant Version_32 := 16#9b5d36b3#;
   pragma Export (C, u00054, "system__fat_fltS");
   u00055 : constant Version_32 := 16#f7ae5624#;
   pragma Export (C, u00055, "system__unsigned_typesS");
   u00056 : constant Version_32 := 16#07fba347#;
   pragma Export (C, u00056, "system__generic_array_operationsB");
   u00057 : constant Version_32 := 16#ed49b3fc#;
   pragma Export (C, u00057, "system__generic_array_operationsS");
   u00058 : constant Version_32 := 16#920eada5#;
   pragma Export (C, u00058, "ada__tagsB");
   u00059 : constant Version_32 := 16#13ca27f3#;
   pragma Export (C, u00059, "ada__tagsS");
   u00060 : constant Version_32 := 16#c3335bfd#;
   pragma Export (C, u00060, "system__htableB");
   u00061 : constant Version_32 := 16#47ea994d#;
   pragma Export (C, u00061, "system__htableS");
   u00062 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00062, "system__string_hashB");
   u00063 : constant Version_32 := 16#e5b4f233#;
   pragma Export (C, u00063, "system__string_hashS");
   u00064 : constant Version_32 := 16#afdbf393#;
   pragma Export (C, u00064, "system__val_lluB");
   u00065 : constant Version_32 := 16#8d5c0156#;
   pragma Export (C, u00065, "system__val_lluS");
   u00066 : constant Version_32 := 16#27b600b2#;
   pragma Export (C, u00066, "system__val_utilB");
   u00067 : constant Version_32 := 16#6f889c59#;
   pragma Export (C, u00067, "system__val_utilS");
   u00068 : constant Version_32 := 16#d1060688#;
   pragma Export (C, u00068, "system__case_utilB");
   u00069 : constant Version_32 := 16#e7214370#;
   pragma Export (C, u00069, "system__case_utilS");
   u00070 : constant Version_32 := 16#d5bfa9f3#;
   pragma Export (C, u00070, "ada__text_ioB");
   u00071 : constant Version_32 := 16#2d7da68a#;
   pragma Export (C, u00071, "ada__text_ioS");
   u00072 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00072, "ada__streamsB");
   u00073 : constant Version_32 := 16#2e6701ab#;
   pragma Export (C, u00073, "ada__streamsS");
   u00074 : constant Version_32 := 16#db5c917c#;
   pragma Export (C, u00074, "ada__io_exceptionsS");
   u00075 : constant Version_32 := 16#84a27f0d#;
   pragma Export (C, u00075, "interfaces__c_streamsB");
   u00076 : constant Version_32 := 16#b1330297#;
   pragma Export (C, u00076, "interfaces__c_streamsS");
   u00077 : constant Version_32 := 16#b3b9fca9#;
   pragma Export (C, u00077, "system__crtlS");
   u00078 : constant Version_32 := 16#b29d05bd#;
   pragma Export (C, u00078, "system__file_ioB");
   u00079 : constant Version_32 := 16#6459cbc2#;
   pragma Export (C, u00079, "system__file_ioS");
   u00080 : constant Version_32 := 16#cf417de3#;
   pragma Export (C, u00080, "ada__finalizationS");
   u00081 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00081, "system__finalization_rootB");
   u00082 : constant Version_32 := 16#8cda5937#;
   pragma Export (C, u00082, "system__finalization_rootS");
   u00083 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00083, "interfaces__cB");
   u00084 : constant Version_32 := 16#70be4e8c#;
   pragma Export (C, u00084, "interfaces__cS");
   u00085 : constant Version_32 := 16#7358ec0a#;
   pragma Export (C, u00085, "system__os_libB");
   u00086 : constant Version_32 := 16#bf5ce13f#;
   pragma Export (C, u00086, "system__os_libS");
   u00087 : constant Version_32 := 16#1a817b8e#;
   pragma Export (C, u00087, "system__stringsB");
   u00088 : constant Version_32 := 16#bd973bc1#;
   pragma Export (C, u00088, "system__stringsS");
   u00089 : constant Version_32 := 16#3eb7b00f#;
   pragma Export (C, u00089, "system__file_control_blockS");
   u00090 : constant Version_32 := 16#3dbb6c61#;
   pragma Export (C, u00090, "nnS");
   u00091 : constant Version_32 := 16#b5135415#;
   pragma Export (C, u00091, "nn__ioB");
   u00092 : constant Version_32 := 16#89ca483c#;
   pragma Export (C, u00092, "nn__ioS");
   u00093 : constant Version_32 := 16#d5f9759f#;
   pragma Export (C, u00093, "ada__text_io__float_auxB");
   u00094 : constant Version_32 := 16#f854caf5#;
   pragma Export (C, u00094, "ada__text_io__float_auxS");
   u00095 : constant Version_32 := 16#181dc502#;
   pragma Export (C, u00095, "ada__text_io__generic_auxB");
   u00096 : constant Version_32 := 16#a6c327d3#;
   pragma Export (C, u00096, "ada__text_io__generic_auxS");
   u00097 : constant Version_32 := 16#8aa4f090#;
   pragma Export (C, u00097, "system__img_realB");
   u00098 : constant Version_32 := 16#04807b45#;
   pragma Export (C, u00098, "system__img_realS");
   u00099 : constant Version_32 := 16#c7bf9154#;
   pragma Export (C, u00099, "system__fat_llfS");
   u00100 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00100, "system__float_controlB");
   u00101 : constant Version_32 := 16#23d4699b#;
   pragma Export (C, u00101, "system__float_controlS");
   u00102 : constant Version_32 := 16#3e932977#;
   pragma Export (C, u00102, "system__img_lluB");
   u00103 : constant Version_32 := 16#be6756e7#;
   pragma Export (C, u00103, "system__img_lluS");
   u00104 : constant Version_32 := 16#ec78c2bf#;
   pragma Export (C, u00104, "system__img_unsB");
   u00105 : constant Version_32 := 16#685a6ad3#;
   pragma Export (C, u00105, "system__img_unsS");
   u00106 : constant Version_32 := 16#93584cd0#;
   pragma Export (C, u00106, "system__powten_tableS");
   u00107 : constant Version_32 := 16#faa9a7b2#;
   pragma Export (C, u00107, "system__val_realB");
   u00108 : constant Version_32 := 16#3d015db6#;
   pragma Export (C, u00108, "system__val_realS");
   u00109 : constant Version_32 := 16#0626abd3#;
   pragma Export (C, u00109, "nn__neuronB");
   u00110 : constant Version_32 := 16#fee6eda7#;
   pragma Export (C, u00110, "nn__neuronS");
   u00111 : constant Version_32 := 16#33b6834b#;
   pragma Export (C, u00111, "nn__transferB");
   u00112 : constant Version_32 := 16#e3405104#;
   pragma Export (C, u00112, "nn__transferS");
   u00113 : constant Version_32 := 16#3e0cf54d#;
   pragma Export (C, u00113, "ada__numerics__auxB");
   u00114 : constant Version_32 := 16#9f6e24ed#;
   pragma Export (C, u00114, "ada__numerics__auxS");
   u00115 : constant Version_32 := 16#cc935169#;
   pragma Export (C, u00115, "system__machine_codeS");
   u00116 : constant Version_32 := 16#a6359005#;
   pragma Export (C, u00116, "system__memoryB");
   u00117 : constant Version_32 := 16#9a554c93#;
   pragma Export (C, u00117, "system__memoryS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  interfaces%s
   --  system%s
   --  system.case_util%s
   --  system.case_util%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.generic_array_operations%s
   --  system.htable%s
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_real%s
   --  system.machine_code%s
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.powten_table%s
   --  system.standard_library%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.os_lib%s
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  ada.exceptions%s
   --  system.soft_links%s
   --  system.unsigned_types%s
   --  system.fat_flt%s
   --  system.fat_llf%s
   --  system.img_llu%s
   --  system.img_llu%b
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.img_real%b
   --  system.val_llu%s
   --  system.val_real%s
   --  system.val_util%s
   --  system.val_util%b
   --  system.val_real%b
   --  system.val_llu%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_cnv%s
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%b
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  system.address_image%s
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.containers%s
   --  ada.io_exceptions%s
   --  ada.numerics%s
   --  system.generic_array_operations%b
   --  ada.numerics.aux%s
   --  ada.numerics.aux%b
   --  ada.tags%s
   --  ada.streams%s
   --  ada.streams%b
   --  interfaces.c%s
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.exceptions.machine%s
   --  system.file_control_block%s
   --  system.file_io%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.memory%s
   --  system.memory%b
   --  system.standard_library%b
   --  system.secondary_stack%s
   --  system.file_io%b
   --  interfaces.c%b
   --  ada.tags%b
   --  system.soft_links%b
   --  system.os_lib%b
   --  system.secondary_stack%b
   --  system.address_image%b
   --  ada.exceptions.traceback%b
   --  ada.numerics.real_arrays%s
   --  ada.numerics.real_arrays%b
   --  system.traceback%s
   --  system.traceback%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  ada.text_io.float_aux%s
   --  ada.text_io.generic_aux%s
   --  ada.text_io.generic_aux%b
   --  ada.text_io.float_aux%b
   --  nn%s
   --  nn.io%s
   --  nn.io%b
   --  nn.neuron%s
   --  nn.transfer%s
   --  nn.transfer%b
   --  nn.neuron%b
   --  main%b
   --  END ELABORATION ORDER


end ada_main;
