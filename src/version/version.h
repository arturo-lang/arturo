#ifndef __VERSION_H__
#define __VERSION_H__

unsigned char Version[] = {
  0x30, 0x2e, 0x38
};
unsigned int Version_len = 3;
unsigned char BuildNo[] = {
  0x34, 0x31, 0x39
};
unsigned int BuildNo_len = 3;
unsigned char BuildDate[] = {
  0x32, 0x34, 0x2d, 0x4a, 0x61, 0x6e, 0x2d, 0x32, 0x30, 0x32, 0x30
};
unsigned int BuildDate_len = 11;

static inline void showVersion() {
struct utsname unameData;
uname(&unameData);
printf("\x1B[32m\x1B[1mArturo %s\x1B[0m (%s build %s) [%s-%s]\n",Version,BuildDate,BuildNo,unameData.machine,unameData.sysname);
printf("(c) 2019-2020 Yanis Zafirópulos\n");
printf("\n");
}
#endif
