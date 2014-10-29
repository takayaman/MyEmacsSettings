/**
 * %file% %bdsec%
 *
 * Copyright (c) 2013 N.Takayama <takayaman@uec.ac.jp>
 *
 *
 */

#ifndef %include-guard%
#define %include-guard%

#include <iosfwd>

%namespace-open%

class %file-withount-ext%
{
	
public:
	/* Default constructor */
	%file-without-ext%();
	/* Destructor */
	~%file-without-ext%();
	/* Copy Constructor */
	%file-without-ext%( const %file-without-ext%& rhs );
	/* Assignment operator */
	%file-without-ext%& operator=( const %file-without-ext%& rhs );	
};

/* stream output operator */
std::ostream& operator<<( std::ostream& lhs, const %file-without-ext%& rhs );

%namespace-close%
#endif /* %include-guard% */
