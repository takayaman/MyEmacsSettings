/*=============================================================================
 * Project : %project%
 * Code : %file%
 * Written : %author%, %company%
 * Date : %date%
 * Copyright (c) %cyear% %author% <%email%>
 * %brief%
 *===========================================================================*/

#ifndef %include-guard%
#define %include-guard%

/*=== Include ===============================================================*/

#include <stdint>
#include <glog/logging.h>

/*=== Define ================================================================*/

/*=== Class Definition  =====================================================*/

%namespace-open%

class %file-without-ext% {
 public:
  /*!
   * Defoult constructor
   */
  %file-without-ext%(void);

  /*!
   * Default destructor
   */
  ~%file-without-ext%(void);

  /*!
   * Copy constructor
   */
  %file-without-ext%(const %file-without-ext%& rhs);

  /*!
   * Assignment operator
   * @param rhs Right hand side
   * @return pointer of this object
   */
  %file-without-ext%& operator=(const %file-without-ext%& rhs);
};

/*!
 * Log output operator
 * @param lhs Left hand side
 * @param rhs Right hand side
 * @return Pointer of google::LogSink object
 */
google::LogSink& operator<<(google::LogSink& lhs, const %file-without-ext%& rhs);

%namespace-close%

#endif  // %include-guard%
