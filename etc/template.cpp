/*=============================================================================
 * Project : %project%
 * Code : %file%
 * Written : %author%, %company%
 * Date : %date%
 * Copyright (c) %cyear% %author% <%email%>
 * %brief%
 *===========================================================================*/

/*=== Include ===============================================================*/

#include %include%
#include <stdint.h>
#include <glog/logging.h>

/*=== Local Define / Local Const ============================================*/

/*=== Class Implementation ==================================================*/

%namespace-open%

/*--- Constructor / Destructor / Initialize ---------------------------------*/

/* Defoult constructor */
%file-without-ext%::%file-without-ext%() {
}

/* Default destructor */
%file-without-ext%::~%file-without-ext%() {
}

/*  Copy constructor */
%file-without-ext%::%file-without-ext%(const %file-without-ext%& rhs) {
}

/* Assignment operator */
%file-without-ext%& %file-without-ext%::operator=(const %file-without-ext%& rhs) {
  if (this != &rhs) {
    // TODO(%author%): implement copy
  }
  return *this;
}

/*--- Operation -------------------------------------------------------------*/

/*  Log output operator */
google::LogSink& operator<<(google::LogSink& lhs, const %file-without-ext%& rhs) {
  lhs << "%namespace%::%file-without-ext%{" <<
      // TODO(%author%): implement out stream of memder data
      "}";
  return lhs;
}

/*--- Accessor --------------------------------------------------------------*/

/*--- Event -----------------------------------------------------------------*/

%namespace-close%

