/*=============================================================================
 * Project : %project%
 * Code : %file%
 * Written : %author%, %company%
 * Date : %date%
 * Copyright (c) %cyear% %author% <%email%>
 * %brief%
 *===========================================================================*/

/*=== Include ===============================================================*/

// #include <globalDef.h>
#include <stdint.h>
#include <glog/logging.h>

/*=== Local Define / Local Const ============================================*/

/*=== Local Variable ========================================================*/

/*=== Local Function Define =================================================*/

/*=== Local Function Implementation =========================================*/

/*=== Global Function Implementation ========================================*/

int main(int argc, char *argv[]) {
  /* Initialize */
  google::InitGoogleLogging(argv[0]);


  /* Finalize */
  google::InstallFailureSignalHandler();

  return EXIT_SUCCESS;
}
