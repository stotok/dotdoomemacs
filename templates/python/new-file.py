#!/usr/bin/env python3
#-*- coding:utf-8 mode:python -*-
#

import sys
import os
import subprocess

from datetime import datetime

class CBaseException(Exception): pass
class CCommandFail(CBaseException): pass

# version info
__version_info__ = (0, 0, 1)
__version__      = '.'.join(str(c) for c in __version_info__)
__progname_version__ = __file__ + ' Ver ' + __version__

#
class ClassName(object):
    #
    def __init__(self, **kwargs):
        self.outputfile     = os.path.join(os.path.abspath(os.getcwd()), kwargs.get('outputfile'))
        self.now            = datetime.now() # self.now.strftime('%d-%b-%Y %H:%M:%S')

    #
    def run_commands(self, cmds):
        '''
        Parameter 'cmds' is a list of commands including it's parameters.
        '''
        for cmd in cmds:
            try:
                p = subprocess.Popen(cmd, shell=True,
                                     stdin=subprocess.PIPE,
                                     stdout=subprocess.PIPE,
                                     stderr=subprocess.PIPE)
            except OSError:
                raise CCommandFail('Cmd failed [OSError] {}'.format(cmd))
            except:
                raise CCommandFail('Cmd failed [Unknown Error]: {}'.format(cmd))

            #
            # p.wait()
            out, err = p.communicate()
            if p.returncode:
                raise CCommandFail('Cmd {} return error {}.\n{}'.format(cmd, p.returncode, err.decode('ascii')))
            #
            return (out, err)

    #
    def execute_main(self):
        try:
            out, err = self.run_commands(['ls -alF'])
            print('out: {}'.format(out.decode('ascii')))
            print('err: {}'.format(err.decode('ascii')))
        except CCommandFail as e:
            pass
        except Exception as e:
            pass

# main
if __name__ == '__main__':
    import argparse

    # setup parser
    parser = argparse.ArgumentParser(description='Program Description')
    parser.add_argument('--version', action='version', version=__progname_version__)
    parser.add_argument('-v', '--verbose', action='count', default=0,
                        help='increase verbosity. Specify multiple time for increased diagnostic output.')
    parser.add_argument('-o', '--out', dest='outputfile', required=True, help='output report filename')

    args = parser.parse_args()
    opts = {'verbose'         : args.verbose,
            'outputfile'      : args.outputfile,
            }

    ClassName(**opts).execute_main()
