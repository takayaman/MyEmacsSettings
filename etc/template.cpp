/*=============================================================================
 * Project : %project%
 * Code : %file%
 * Written : %author%, %company%
 * Date : %date%
 * Copyright (c) %cyear% %author% <%email%>
 * Implementation of %namespace%::%classname%
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
%classname%::%classname%() {
}

/* Default destructor */
%classname%::~%classname%() {
}

/*  Copy constructor */
%classname%::%classname%(const %classname%& rhs) {
}

/* Assignment operator */
%classname%& %classname%::operator=(const %classname%& rhs) {
  if (this != &rhs) {
    // TODO(%author%): implement copy
  }
  return *this;
}

/*--- Operation -------------------------------------------------------------*/

/*  Log output operator */
google::LogMessage& operator<<(google::LogMessage& lhs, const %classname%& rhs) {
  lhs.stream() << "%namespace%::%classname%{" <<
      // TODO(%author%): implement out stream of memder data
      "}" << std::endl;
  return lhs;
}

/*--- Accessor --------------------------------------------------------------*/

/*--- Event -----------------------------------------------------------------*/

%namespace-close%

