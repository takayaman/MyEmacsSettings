/*=============================================================================
 * Project : %project%
 * Code : %file%
 * Written : %author%, %company%
 * Date : %date%
 * Copyright (c) %cyear% %author% <%email%>
 * Definition of %namespace%::%classname%
 * %brief%
 *===========================================================================*/

#ifndef %include-guard%
#define %include-guard%

/*=== Include ===============================================================*/

#include <stdint.h>
#include <glog/logging.h>

/*=== Define ================================================================*/

/*=== Class Definition  =====================================================*/

%namespace-open%

class %classname% {
 public:
  /*!
   * Defoult constructor
   */
  %classname%(void);

  /*!
   * Default destructor
   */
  ~%classname%(void);

  /*!
   * Copy constructor
   */
  %classname%(const %classname%& rhs);

  /*!
   * Assignment operator
   * @param rhs Right hand side
   * @return pointer of this object
   */
  %classname%& operator=(const %classname%& rhs);
};

/*!
 * Log output operator
 * @param lhs Left hand side
 * @param rhs Right hand side
 * @return Pointer of google::LogSink object
 */
google::LogSink& operator<<(google::LogSink& lhs, const %classname%& rhs);

%namespace-close%

#endif  // %include-guard%
