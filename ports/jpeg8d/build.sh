# Copyright (c) 2011 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

EXECUTABLES="rdjpgcom${NACL_EXEEXT} wrjpgcom${NACL_EXEEXT} \
      cjpeg${NACL_EXEEXT} djpeg${NACL_EXEEXT} jpegtran${NACL_EXEEXT}"

TestStep() {
  export SEL_LDR_LIB_PATH=$PWD/.libs

  if [[ ${NACL_SHARED} == 1 ]]; then
    for exe in ${EXECUTABLES}; do
     local script=$(basename ${exe%.*})
      WriteLauncherScript ${script} ${exe}
    done
  fi
  LogExecute make test

  if [[ ${NACL_ARCH} == pnacl ]]; then
    for arch in x86-32 arm; do
      for exe in ${EXECUTABLES}; do
        local exe_noext=${exe%.*}
        WriteLauncherScript ${exe_noext} ${exe_noext}.${arch}.nexe
      done
      LogExecute make test
    done
  fi
}
