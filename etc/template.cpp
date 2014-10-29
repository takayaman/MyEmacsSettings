/**
 * %file% - %bdsec%
 *
 * Copyright (c) 2013 N.Takayama <takayaman@uec.ac.jp>
 *
 *
 */

#include %include%
#include <ostream>

%namespace-open%

/**
 * Default constructor
 */
%file-without-ext%::%file-without-ext%()
{

}

/**
 * Default destructor
 */
%file-without-ext%::~%file-without-ext%()
 {
 }

/**
 * Copy constructor
 */
%file-without-ext%::%file-without-ext%( %file-without-ext%& rhs )
 {
 }

/**
 * Assignment operator
 */
%file-without-ext%& %file-without-ext%::operator=( const %file-without-ext%& rhs )
         {
             if( this != &rhs ){
                 // TODO: implement copy
             }
             return *this;
         }

/**
 * streamoutput operator
 */
std::ostream& operator<<( std::ostream& lhs, const %file-without-ext%& rhs )
{
    lhs << "%namespace%::%file-without-ext%{" <<
            // TODO: implement out stream of memder data
            "}";
    return lhs;
}
%namespace-close%

